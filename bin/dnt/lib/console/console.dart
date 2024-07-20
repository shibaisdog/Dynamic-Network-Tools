import 'dart:io';
import 'ansi.dart' as ansi;
void console(int max,int index,String where,String message) {
  String _ = '[${ansi.bg_bright_green}';
  for (int i = 0; i <= index; i++) {
    _ += ' ';
  }
  _ += '${ansi.reset}';
  for (int i = 0; i <= max - index - 1; i++) {
    _ += ' ';
  }
  _ += '] ${ansi.fg_bright_red}${index / max * 100}% ${ansi.reset}| ${ansi.fg_bright_cyan}<${where}> : ${ansi.reset}${message}';
  stdout.write('\r\x1B[2K${_}');
}