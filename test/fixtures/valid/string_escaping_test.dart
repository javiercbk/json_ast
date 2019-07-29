import 'dart:io';
import 'package:test/test.dart';
import "package:path/path.dart" show dirname, join, normalize;

import '../../types_helper.dart';
import '../../test_helper.dart';
import '../../../lib/error.dart';
import '../../../lib/location.dart';
import '../../../lib/parse.dart';

final location = Location.create;
final object = createObject;
final id = createIdentifier;
final prop = createProperty;
final array = createArray;
final literal = createLiteral;

final ast = TestAST(
    object([
      prop(id('quota\"tion', '"quota\\\"tion"'),
          literal('reverse\\solidus', '"reverse\\\\solidus"')),
      prop(id('soli\/dus', '"soli\\/dus"'),
          literal('back\bspace', '"back\\bspace"')),
      prop(id('form\ffeed', '"form\\ffeed"'),
          literal('new\nline', '"new\\nline"')),
      prop(id('re\rturn', '"re\\rturn"'),
          literal('tab\tsymbol', '"tab\\tsymbol"')),
      prop(id('hex\u0001digit', '"hex\\u0001digit"'), literal('', '""')),
      prop(id('\"\"\"\"', '"\\\"\\\"\\\"\\\""'),
          literal('\\\\\\', '"\\\\\\\\\\\\"')),
      prop(id('\/', '"\\/"'), literal('\b', '"\\b"')),
      prop(
          id('\"\/', '"\\\"\\/"'),
          literal(
              '\"\\\/\b\f\n\r\t\u0001', '"\\\"\\\\\\/\\b\\f\\n\\r\\t\\u0001"'))
    ]),
    Settings());

void main() {
  final currentDirectory = dirname(testScriptPath());
  group("string escaping", () {
    test("should parse string escaping correctly", () {
      final jsonFilePath =
          normalize(join(currentDirectory, 'string_escaping.json'));
      final rawJSON = new File(jsonFilePath).readAsStringSync();
      final parsedAST = parse(rawJSON, Settings());
      assertNode(ast.ast, parsedAST, assertLocation: false, assertIndex: true);
    });
  });
}
