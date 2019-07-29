import 'dart:io';
import "package:path/path.dart"
    show dirname, join, normalize, extension, basename;
import 'package:test/test.dart';

import './test_helper.dart';
import '../lib/json_ast.dart';

void getFixtures(String currentDirectory, String dirname,
    void Function(String, String, String) func) async {
  final folderPath = normalize(join(currentDirectory, dirname));
  final dir = new Directory(folderPath);
  final entities = dir.listSync();
  final jsonFiles = entities.where((entity) =>
      extension(entity.path) == '.json' &&
      !basename(entity.path).startsWith('_'));
  jsonFiles.forEach((jsonFile) {
    final jsonFilePath = jsonFile.path;
    final fixtureName = basename(jsonFilePath);
    String jsonRawData;
    try {
      jsonRawData = new File(jsonFilePath).readAsStringSync();
    } catch (e) {
      // do nothing
    } finally {
      if (jsonRawData != null) {
        func(jsonFilePath, fixtureName, jsonRawData);
      }
    }
  });
}

void main() {
  final currentDirectory = dirname(testScriptPath());
  group("Right test fixtures", () {
    test('should parse valid json structures', () {
      getFixtures(currentDirectory, 'fixtures/valid',
          (String filePath, String fixtureName, String rawJSON) {
        final ast = parse(rawJSON, Settings(source: fixtureName));
        expect(ast, isNotNull,
            reason: 'file "$fixtureName" failed to be parsed');
      });
    });
  });

  group("Wrong test fixtures", () {
    test('should throw error on invalid json structures', () {
      getFixtures(currentDirectory, 'fixtures/invalid',
          (String filePath, String fixtureName, String rawJSON) {
        final filePathLen = filePath.length;
        final textFile =
            new File('${filePath.substring(0, filePathLen - 4)}txt');
        String errorStr;
        if (textFile.existsSync()) {
          errorStr = textFile.readAsStringSync();
        }
        try {
          final ast = parse(rawJSON, Settings());
          expect(ast, isNull,
              reason: 'file "$fixtureName" failed to be parsed');
        } catch (e) {
          expect(e, isNotNull,
              reason: 'file "$fixtureName" failed to be parsed');
          if (errorStr != null) {
            expect(e.message, startsWith(errorStr));
          }
        }
      });
    });
  });
}
