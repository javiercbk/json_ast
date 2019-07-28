String unexpectedSymbol(String symbol, List<int> positions) {
  final positionsStr = positions.where((c) => c != null && c != 0).join(':');
  return 'Unexpected symbol <$symbol> at $positionsStr';
}