import 'dart:io';
import 'router/shelf.dart';
import 'package:dnt/console/logger.dart' as logger;
HttpServer? server;
void start(int port) async {
  if (server == null) {
    server = await listen(port);
    logger.info("http",'Server Running on http://${server?.address.host}:${server?.port}');
  } else {
    server?.close();
    logger.info("http",'Server Restarting...');
    server = await listen(port);
    logger.info("http",'Server Running on http://${server?.address.host}:${server?.port}');
  }
}