import 'dart:io';
import '../__vm__/DNT.dart';
import '../__console__/ansi.dart' as ansi;
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
        print('${ansi.fg_red}File modified: ${event.path}${ansi.reset}\n');
        start();
      }
    }
  }
}