import 'dart:io';
import '../../__init__/init.dart' as i;
import '../__vm__/DNT.dart' as dnt;
import 'file-change-watch.dart' as watch;
void version(String args) {
  if (
    args == "-v" || 
    args == "--v" ||
    args == "-version" ||
    args == "--version"
  ) {
    print('DNT [Dynamic-Network-Tools] V.beta-1.0.0 at (Dart ${Platform.version})');
  }
}
void init(String args) {
  if (
    args == "i" || 
    args == "init" ||
    args == "-i" || 
    args == "--i" ||
    args == "-init" ||
    args == "--init"
  ) {
    i.init();
  }
}
void start(String args) {
  if (
    args == "s" || 
    args == "start"
  ) {
    dnt.start();
    watch.watch();
  }
}
void help() {
  print('Usage: dnt <command> [arguments]');
  print('\n');
  print('Global options:');
  print('  -v, --version               Show DNT Version.');
  print('  -i, --init                  Create DNT Program');
  print('\n');
  print('Available commands:');
  print('  start                       Start DNT Program');
}