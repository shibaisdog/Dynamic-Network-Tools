import 'dart:io';
import 'package:dnt/vm/Script.dart';
import 'package:dnt/console/ansi.dart' as ansi;
void watch() async {
  Uri scriptUri = Platform.script;
  String scriptPath = scriptUri.toFilePath();
  String scriptDirectory = Directory(scriptPath).parent.path;
  Directory directory = Directory(scriptDirectory.replaceAll(scriptDirectory,'${scriptDirectory}\\source'));
  if (!await directory.exists()) {
    throw FileSystemException('Directory does not exist : ${scriptDirectory}\\source');
  }
  final debounceDuration = Duration(seconds: 1);
  final lastModified = <String, DateTime>{};
  await for (var event in directory.watch(recursive: true)) {
    final eventPath = event.path;
    if (event.type == FileSystemEvent.modify) {
      final now = DateTime.now();
      if (!lastModified.containsKey(eventPath) || now.difference(lastModified[eventPath]!) > debounceDuration) {
        lastModified[eventPath] = now;
        print('${ansi.fg_red}File modified: ${ansi.fg_bright_yellow}${event.path}${ansi.reset}\n');
        start();
      }
    }
  }
}