import 'package:dnt/function/cli-commands.dart';
void main(List<String> args) async {
  if (args.isNotEmpty) {
    for (String f in args) {
      version(f);
      init(f);
      start(f);
    }
  } else {
    help();
  }
  //print('Unknown Commands');
}