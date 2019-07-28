import 'package:grapheme_splitter/grapheme_splitter.dart' show GraphemeSplitter;

String substring(String str, int start, [int end]) {
  final splitter = new GraphemeSplitter();
	final iterator = splitter.iterateGraphemes(str.substring(start));
  final strBuffer = new StringBuffer();
	iterator.forEach((v) {
    strBuffer.write(v);
  });
	return strBuffer.toString();
}

