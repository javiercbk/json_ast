import 'dart:io';
import 'package:test/test.dart';

import '../../types_helper.dart';
import '../../test_helper.dart';
import '../../../lib/error.dart';
import '../../../lib/location.dart';
import '../../../lib/parse.dart';

final location = Location.create;

final literal = createLiteral;

final ast = new TestAST(
    literal(12345, '12345', location(1, 1, 0, 1, 6, 5)), Settings());

void main() {
  group("number only", () {
    test("should parse number only correctly", () {
      final rawJSON =
          new File("test/fixtures/valid/number_only.json").readAsStringSync();
      final parsedAST = parse(rawJSON, Settings());
      assertNode(ast.ast, parsedAST, assertLocation: false, assertIndex: true);
    });
  });
}
