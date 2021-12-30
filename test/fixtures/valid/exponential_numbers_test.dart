import 'dart:io';
import 'package:test/test.dart';

import '../../types_helper.dart';
import '../../test_helper.dart';
import '../../../lib/error.dart';
import '../../../lib/parse.dart';

final array = createArray;
final literal = createLiteral;

final ast = new TestAST(
    array([
      literal(1, '1'),
      literal(1.2, '1.2'),
      literal(1.2e3, '1.2e3'),
      literal(1.2e-3, '1.2e-3')
    ]),
    new Settings());

void main() {
  group("exponential numbers", () {
    test("should parse an exponentian number correctly", () {
      final rawJSON = new File("test/fixtures/valid/exponential_numbers.json")
          .readAsStringSync();
      final parsedAST = parse(rawJSON, Settings());
      assertNode(ast.ast, parsedAST, assertLocation: false, assertIndex: false);
    });
  });
}
