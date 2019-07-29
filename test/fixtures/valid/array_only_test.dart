import 'dart:io';
import 'package:test/test.dart';
import "package:path/path.dart" show dirname, join, normalize;

import '../../types_helper.dart';
import '../../test_helper.dart';
import '../../../lib/location.dart';
import '../../../lib/error.dart';
import '../../../lib/parse.dart';

final ast = new TestAST(
    createArray([], Location.create(1, 1, 0, 1, 3, 2)), new Settings());

void main() {
  final currentDirectory = dirname(testScriptPath());
  group("array only test", () {
    test("should parse array only test correctly", () {
      final jsonFilePath = normalize(join(currentDirectory, 'array_only.json'));
      final rawJSON = new File(jsonFilePath).readAsStringSync();
      final parsedAST = parse(rawJSON, Settings());
      expect(ast.ast, equals(parsedAST));
    });
  });
}
