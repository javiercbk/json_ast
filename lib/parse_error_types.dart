
String unexpectedEnd () => 'Unexpected end of input';

String unexpectedToken (String token, String source, int line, int column) {
  final positionsBuffer = new StringBuffer();
  if (source != null) {
    positionsBuffer.write(source);
  }
  positionsBuffer.write(line);
  positionsBuffer.write(column);
  return 'Unexpected token <$token> at ${positionsBuffer.toString()}';
}

