import 'dart:io';
import 'package:test/test.dart';

import '../../types_helper.dart';
import '../../../lib/location.dart';
import '../../../lib/error.dart';
import '../../../lib/parse.dart';

final ast = new TestAST(
    createArray([], Location.create(1, 1, 0, 1, 3, 2)), new Settings());

void main() {
  group("array only test", () {
    test("should parse array only test correctly", () {
      final rawJSON =
          new File("test/fixtures/valid/array_only.json").readAsStringSync();
      final parsedAST = parse(rawJSON, Settings());
      expect(ast.ast, equals(parsedAST));
    });
  });
}
