import '__function__/cli-commands.dart';
void main(List<String> args) async {
  if (args.isNotEmpty) {
    for (String f in args) {
      version(f);
      init(f);
      start(f);
    }
    print('Unknown Commands');
  } else {
    help();
  }
}