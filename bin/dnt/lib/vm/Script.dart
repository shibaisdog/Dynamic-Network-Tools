import 'dart:io';
import 'dart:core';
import 'package:dotenv/dotenv.dart';
import 'package:dnt/function/env.dart';
import 'package:dnt/console/console.dart';
import 'package:dnt/console/ansi.dart' as ansi;
import 'script/js-compiler.dart' as js_compiler;
import 'web/App.dart' as app;
double run = 0;
void start() async {
  run = 0;
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  DotEnv Env = load_env();
  Uri scriptUri = Platform.script;
  String scriptPath = scriptUri.toFilePath();
  String scriptDirectory = Directory(scriptPath).parent.path;
  console(10,run.toInt(),'init','script-reset');
  String directoryPath = '${scriptDirectory}\\source';
  Directory folder = Directory(directoryPath.replaceAll(directoryPath,'${scriptDirectory}\\dist'));
  if (await folder.exists()) {
    await folder.delete(recursive: true);
  }
  await folder.create(recursive: true);
  List<String> Files = await getFiles(directoryPath);
  for (String _file in Files) {
    try {
      run += 10 / Files.length;
      File file = File(_file);
      console(10,run.toInt(),'read',_file);
      String __w = replaceLastOccurrence(_file,'.dt','.js').replaceAll(directoryPath,'${scriptDirectory}\\dist');
      File w_file = await file.copy(__w);;
      Directory directory = w_file.parent;
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (_file.endsWith('.dt')) {
        console(10,run.toInt(),'compilation',ansi.fg_bright_yellow+_file+ansi.fg_bright_cyan+" -> "+ansi.fg_bright_yellow+__w+ansi.reset);
        String contents = await file.readAsString();
        contents = js_compiler.owo(contents);
        w_file.writeAsStringSync(contents);
      } else {
        console(10,run.toInt(),'copy',ansi.fg_bright_yellow+_file+ansi.fg_bright_cyan+" -> "+ansi.fg_bright_yellow+__w+ansi.reset);
        await file.copy(__w);
      }
    } catch (e) {}
  }
  stopwatch.stop();
  print('\n${ansi.fg_bright_green}_____[  end compilation : ${stopwatch.elapsedMilliseconds}ms |  file count : ${Files.length}  ]_____${ansi.reset}');
  app.start(int.parse(Env['Server-Port'].toString()));
}
List<String> getFiles(String directoryPath) {
  final directory = Directory(directoryPath);
  final Files = <String>[];
  if (directory.existsSync()) {
    directory.listSync(recursive: true).forEach((FileSystemEntity entity) {
      if (entity is File) {
        console(10,run.toInt(),'push',entity.path);
        Files.add(entity.path);
      }
    });
  } else {
    print('Directory does not exist');
  }
  return Files;
}
String replaceLastOccurrence(String text, String target, String replacement) {
  final index = text.lastIndexOf(target);
  if (index == -1) {
    return text;
  }
  return text.substring(0, index) + replacement + text.substring(index + target.length);
}