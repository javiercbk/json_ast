import 'package:test/test.dart';
import '../lib/json_ast.dart';

void _assertException(void Function() fun, JSONASTException expected) {
  JSONASTException exceptionThrown;
  final exceptionAssertion = predicate((e) {
    if (e is JSONASTException) {
      exceptionThrown = e;
      return true;
    }
    return false;
  });
  expect(fun, throwsA(exceptionAssertion));
  expect(exceptionThrown.message, equals(expected.message));
  expect(exceptionThrown.source, equals(expected.source));
  expect(exceptionThrown.line, equals(expected.line));
  expect(exceptionThrown.column, equals(expected.column));
}

void main() {
  group("Error messages", () {
    test("unexpected symbol", () {
      final json = '{\n    "foo": incorrect\n}';
      final testFunc = () {
        return parse(json, new Settings(source: 'path/to/file.json'));
      };
      final expected = new JSONASTException(
          'Unexpected symbol <i> at path/to/file.json:2:12',
          json,
          'path/to/file.json',
          2,
          12);
      _assertException(testFunc, expected);
    });

    test("unexpected eof", () {
      final json = '{\n    "foo": 123';
      final testFunc =
          () => parse(json, new Settings(source: 'path/to/file.json'));
      final expected = new JSONASTException(
          'Unexpected end of input', json, 'path/to/file.json', 2, 15);
      _assertException(testFunc, expected);
    });

    test("unexpected token", () {
      final json = '{\n    "foo": 123\n}}';
      final testFunc =
          () => parse(json, new Settings(source: 'path/to/file.json'));
      final expected = new JSONASTException(
          'Unexpected token <}> at path/to/file.json:3:2',
          json,
          'path/to/file.json',
          3,
          2);
      _assertException(testFunc, expected);
    });
  });
}
