import 'dart:io';
import 'package:test/test.dart';
import "package:path/path.dart" show dirname, join, normalize;

import '../../types_helper.dart';
import '../../test_helper.dart';
import '../../../lib/location.dart';
import '../../../lib/error.dart';
import '../../../lib/parse.dart';

final ast = new TestAST(
    createArray([
      createArray([
        createArray([
          createArray([
            createArray([
              createArray([
                createArray(
                    [createArray([], Location.create(1, 8, 7, 1, 10, 9))],
                    Location.create(1, 7, 6, 1, 11, 10))
              ], Location.create(1, 6, 5, 1, 12, 11))
            ], Location.create(1, 5, 4, 1, 13, 12))
          ], Location.create(1, 4, 3, 1, 14, 13))
        ], Location.create(1, 3, 2, 1, 15, 14))
      ], Location.create(1, 2, 1, 1, 16, 15))
    ], Location.create(1, 1, 0, 1, 17, 16)),
    new Settings());

void main() {
  final currentDirectory = dirname(testScriptPath());
  group("array in arrays", () {
    test("should parse array in arrays correctly", () {
      final jsonFilePath =
          normalize(join(currentDirectory, 'array_in_arrays.json'));
      final rawJSON = new File(jsonFilePath).readAsStringSync();
      final parsedAST = parse(rawJSON, Settings());
      expect(ast.ast, equals(parsedAST));
    });
  });
}
