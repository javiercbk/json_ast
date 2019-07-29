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
    array([
      literal('♥', '"\\u2665"'),
      object([
        prop(id('©', '"\\u00A9"'),
            literal('𝌆\b\n\t', '"\\uD834\\uDF06\\b\\n\\t"'))
      ]),
      literal('', '"\\u007f"'),
      object([
        prop(id('􏿿', '"\\uDBFF\\uDFFF"'), literal('𝄞', '"\\uD834\\uDD1E"'))
      ])
    ]),
    Settings());

void main() {
  final currentDirectory = dirname(testScriptPath());
  group("unicode", () {
    test("should parse unicode correctly", () {
      final jsonFilePath = normalize(join(currentDirectory, 'unicode.json'));
      final rawJSON = new File(jsonFilePath).readAsStringSync();
      final parsedAST = parse(rawJSON, Settings());
      assertNode(ast.ast, parsedAST, assertLocation: false, assertIndex: false);
    });
  });
}
