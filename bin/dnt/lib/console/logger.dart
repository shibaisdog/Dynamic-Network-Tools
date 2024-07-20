void info(where,message) {
  print('[${DateTime.now()}] [INFO] [$where] $message');
}
void error(where,message) {
  print('[${DateTime.now()}] [ERROR] [$where] $message');
}