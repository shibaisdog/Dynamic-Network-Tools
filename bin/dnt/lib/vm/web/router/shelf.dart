import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:dotenv/dotenv.dart';
import 'package:dnt/function/env.dart';
import 'router.dart';
Future<HttpServer> listen(int port) async {
  DotEnv Env = load_env();
  Uri scriptUri = Platform.script;
  String scriptPath = scriptUri.toFilePath();
  String scriptDirectory = Directory(scriptPath).parent.path;
  var CORS = corsHeaders(
    headers: {
      'Access-Control-Allow-Origin'  : Env['CORS-Origin'].toString(),
      'Access-Control-Allow-Methods' : Env['CORS-Methods'].toString(),
      'Access-Control-Allow-Headers' : Env['CORS-Headers'].toString(),
    },
  );
  final router = set_router();
  final staticHandler = createStaticHandler('${scriptDirectory}\\dist', defaultDocument: 'index.html', serveFilesOutsidePath: true);
  Pipeline Pipe = const Pipeline();
  var handler = Pipe
    .addMiddleware(logRequests())
    .addMiddleware(CORS)
    .addHandler((request) async {
      var staticResponse = await staticHandler(request);
      if (staticResponse.statusCode == 404) {
        var apiResponse = await router(request);
        if (apiResponse.statusCode == 404) {
          return Response.notFound(
            jsonEncode({'message': '404 Not Found'}),
            headers: {'content-type': 'application/json'});
        }
        return apiResponse;
      }
      return staticResponse;
    });
  HttpServer server = await io.serve(handler,InternetAddress.anyIPv4, 2095);
  return server;
}