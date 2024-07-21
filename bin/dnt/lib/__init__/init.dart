import 'dart:io';
void init() async {
  Uri scriptUri = Platform.script;
  String scriptPath = scriptUri.toFilePath();
  String scriptDirectory = Directory(scriptPath).parent.path;
  await Directory(scriptDirectory.replaceAll(scriptDirectory,'${scriptDirectory}\\dist')).create(recursive: true);
  await Directory(scriptDirectory.replaceAll(scriptDirectory,'${scriptDirectory}\\source')).create(recursive: true);
  File w_Env_file = File(scriptDirectory.replaceAll(scriptDirectory,'${scriptDirectory}\\.env'));
  File w_Rot_file = File(scriptDirectory.replaceAll(scriptDirectory,'${scriptDirectory}\\.@router'));
  File w_html_file = File(scriptDirectory.replaceAll(scriptDirectory,'${scriptDirectory}\\source\\index.html'));
  File w_css_file = File(scriptDirectory.replaceAll(scriptDirectory,'${scriptDirectory}\\source\\index.css'));
  String __init__Env__= """
# --- [ Set ] ---- #
Server-Port = 2095
# --- [ CORS ] ---- #
CORS = true
CORS-Origin = '*'
CORS-Methods = 'GET, POST, OPTIONS'
CORS-Headers =  'Content-Type'
""";
  String __init__Rot__= """
@router.get('/') -> req.file_send('index.html')
""";
  String __init__html__ = """
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="index.css">
        <title>DNT</title>
        <div id="DNT">
            <h2>Hello World!!</h2>
        </div>
    </head>
    <body>
    </body>
</html>
""";
  String __init__css__ = """
#DNT {
    text-align: center;
    margin: 0 auto;
}
""";
  w_Rot_file.writeAsStringSync(__init__Rot__);
  w_Env_file.writeAsStringSync(__init__Env__);
  w_html_file.writeAsStringSync(__init__html__);
  w_css_file.writeAsStringSync(__init__css__);
}