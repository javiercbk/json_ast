import 'dart:io';
import 'package:test/test.dart';

import '../../types_helper.dart';
import '../../test_helper.dart';
import '../../../lib/error.dart';
import '../../../lib/location.dart';
import '../../../lib/parse.dart';

final location = Location.create;
final object = createObject;

final ast = TestAST(object([], location(1, 1, 0, 1, 3, 2)), Settings());

void main() {
  group("object only", () {
    test("should parse object only correctly", () {
      final rawJSON =
          new File("test/fixtures/valid/object_only.json").readAsStringSync();
      final parsedAST = parse(rawJSON, Settings());
      assertNode(ast.ast, parsedAST, assertLocation: true, assertIndex: true);
    });
  });
}
