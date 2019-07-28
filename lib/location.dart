class Loc {
  final int line;
  final int column;

  Loc({this.line, this.column});
}

class Segment extends Loc{
  final int offset;

  Segment(int line, int column, this.offset) : super(line: line , column: column);
}

class Location {
  final Segment start;
	final Segment end;
  final String source;
	
  Location(this.start, this.end, this.source);

  static Location create(int startLine, int startColumn, int startOffset, int endLine, int endColumn, int endOffset, String source) {
    final startSegment = new Segment(startLine, startColumn, startOffset);
    final endSegment = new Segment(startLine, startColumn, startOffset);
    return new Location(startSegment, endSegment, source);
  }
}
