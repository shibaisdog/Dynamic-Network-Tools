import 'package:dotenv/dotenv.dart';
DotEnv dotenv = DotEnv(includePlatformEnvironment: true)..load();
DotEnv load_env() {
  return dotenv;
}