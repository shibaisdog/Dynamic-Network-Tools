String owo(String line) {
  line = line.replaceAll("fun", "function");
  line = line.replaceAll("print", "console.log");
  return line;
}