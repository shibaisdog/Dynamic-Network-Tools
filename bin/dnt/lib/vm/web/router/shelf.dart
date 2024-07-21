import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:dotenv/dotenv.dart';
import 'package:dnt/function/env.dart';
import 'package:dnt/vm/script/@router.dart';
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
  final staticHandler = createStaticHandler('${scriptDirectory}\\dist', serveFilesOutsidePath: true);
  Pipeline Pipe = const Pipeline();
  if (bool.parse(Env['CORS'].toString(), caseSensitive: false)) {
    Pipe.addMiddleware(CORS);
  }
  File R_F = File('${scriptDirectory}\\.@router');
  String contents = await R_F.readAsString();
  final r = await s_Router(contents.split('\n'));
  var handler = Pipe
    .addMiddleware(logRequests())
    .addHandler((request) async {
      var response = await r(request);
      if (response.statusCode == 404) {
        var staticResponse = await staticHandler(request);
        if (staticResponse.statusCode == 404) {
          var apiResponse = await router(request);
          if (apiResponse.statusCode == 404) {
            return Response.notFound(
              jsonEncode({'message': '404 Not Found'}),
              headers: {'content-type': 'application/json'}
            );
          }
          return apiResponse;
        }
        return staticResponse;
      } else {
        return response;
      }
    });
  HttpServer server = await io.serve(handler,InternetAddress.anyIPv4, 2095);
  return server;
}