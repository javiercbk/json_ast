import 'dart:io';
import 'package:test/test.dart';
import "package:path/path.dart" show dirname, join, normalize;

import '../../types_helper.dart';
import '../../test_helper.dart';
import '../../../lib/error.dart';
import '../../../lib/location.dart';
import '../../../lib/parse.dart';

final location = Location.create;
final literal = createLiteral;

final ast = TestAST(
    literal('Some text', '"Some text"', location(1, 1, 0, 1, 12, 11)),
    Settings());

void main() {
  final currentDirectory = dirname(testScriptPath());
  group("string only", () {
    test("should parse string only correctly", () {
      final jsonFilePath =
          normalize(join(currentDirectory, 'string_only.json'));
      final rawJSON = new File(jsonFilePath).readAsStringSync();
      final parsedAST = parse(rawJSON, Settings());
      assertNode(ast.ast, parsedAST, assertLocation: true, assertIndex: true);
    });
  });
}
