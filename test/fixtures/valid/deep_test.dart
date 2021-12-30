import 'dart:io';
import 'package:test/test.dart';

import '../../types_helper.dart';
import '../../test_helper.dart';
import '../../../lib/error.dart';
import '../../../lib/parse.dart';

final object = createObject;
final id = createIdentifier;
final prop = createProperty;
final array = createArray;
final literal = createLiteral;

final _n = array([literal('n', '"n"')]);
final _m = array([literal('m', '"m"'), _n]);
final _l = array([literal('l', '"l"'), _m]);
final _k = array([literal('k', '"k"'), _l]);
final _j = array([literal('j', '"j"'), _k]);
final _i = array([literal('i', '"i"'), _j]);
final _h = array([literal('h', '"h"'), _i]);
final _g = object([prop(id('g', '"g"'), _h)]);
final _f = object([prop(id('f', '"f"'), _g)]);
final _e = object([prop(id('e', '"e"'), _f)]);
final _d = object([prop(id('d', '"d"'), _e)]);
final _c = object([prop(id('c', '"c"'), _d)]);
final _b = object([prop(id('b', '"b"'), _c)]);
final _a = object([prop(id('a', '"a"'), _b)]);

final ast = new TestAST(_a, new Settings());

void main() {
  group("deep json", () {
    test("should parse a deep json correctly", () {
      final rawJSON =
          new File("test/fixtures/valid/deep.json").readAsStringSync();
      final parsedAST = parse(rawJSON, Settings());
      assertNode(ast.ast, parsedAST, assertLocation: false, assertIndex: false);
    });
  });
}
