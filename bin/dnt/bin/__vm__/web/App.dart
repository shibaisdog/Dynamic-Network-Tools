import 'dart:io';
import 'asset/logger.dart' as logger;
import 'router/shelf.dart';
HttpServer? server;
void start(int port) async {
  if (server == null) {
    server = await listen(port);
    logger.info("http",'Server running on http://${server?.address.host}:${server?.port}');
  } else {
    server?.close();
    logger.info("http",'Server Restarting...');
    server = await listen(port);
    logger.info("http",'Server running on http://${server?.address.host}:${server?.port}');
  }
}