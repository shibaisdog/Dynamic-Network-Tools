import 'dart:io';
void init() async {
  Uri scriptUri = Platform.script;
  String scriptPath = scriptUri.toFilePath();
  String scriptDirectory = Directory(scriptPath).parent.path;
  await Directory(scriptDirectory.replaceAll(scriptDirectory,'${scriptDirectory}\\dist')).create(recursive: true);
  await Directory(scriptDirectory.replaceAll(scriptDirectory,'${scriptDirectory}\\source')).create(recursive: true);
  File w_file = File(scriptDirectory.replaceAll(scriptDirectory,'${scriptDirectory}\\source\\index.html'));
  String __init__html__ = """
<!DOCTYPE html>
<html>
    <head>
        <title>DNT</title>
        <h2>Hello World!!</h2>
    </head>
    <body>
    </body>
</html>
  """;
  w_file.writeAsStringSync(__init__html__);
}