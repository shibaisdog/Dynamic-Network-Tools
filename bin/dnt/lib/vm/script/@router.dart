import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
//import 'package:dnt/console/console.dart';
import 'package:dnt/console/ansi.dart' as ansi;
Router s_Router(List<String> U) {
  Uri scriptUri = Platform.script;
  String scriptPath = scriptUri.toFilePath();
  String scriptDirectory = Directory(scriptPath).parent.path;
  Router router = Router();
  for (String line in U) {
    line = line.replaceAll('"','').replaceAll("'",'').trim();
    if (line.isEmpty) {
      continue;
    }
    String page = line.substring(0,line.indexOf('->'));
    page = page.substring(page.indexOf('(')+1,page.indexOf(')'));
    String after = line.substring(line.indexOf('->')+2);
    if (after.indexOf('req.file_send') != -1) {
      String type = line.substring(0,line.indexOf('->')).substring(line.substring(0,line.indexOf('->')).indexOf('@router.')+8,line.substring(0,line.indexOf('->')).indexOf('('));
      String files = after.substring(after.indexOf('(')+1,after.indexOf(')'));
      print('${ansi.fg_bright_cyan}<seting-router> : ${ansi.fg_bright_green}[${type}] ${ansi.fg_bright_yellow}${page} ${ansi.fg_bright_cyan}-> ${ansi.fg_bright_yellow}${scriptDirectory}\\dist\\${files}${ansi.reset}');
      if (type == 'post') {
        router.post('${page}', (Request request) {
          File file = File('${scriptDirectory}\\dist\\${files}');
          if (file.existsSync()) {
            return Response.ok(
              file.openRead()
            );
          } else {
            return Response.notFound('File not found');
          }
        });
      } else {
        router.get('${page}', (Request request) {
          File file = File('${scriptDirectory}\\dist\\${files}');
          if (file.existsSync()) {
            return Response.ok(
              file.openRead()
            );
          } else {
            return Response.notFound('File not found');
          }
        });
      }
    }
  }
  return router;
}
