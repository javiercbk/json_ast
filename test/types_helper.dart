import '../lib/location.dart';
import '../lib/tokenize.dart';
import '../lib/error.dart';

ValueNode createIdentifier(String value, String raw, [Location location]) {
  if (raw == null) {
    raw = value;
  }
  final node = new ValueNode(value, raw);
  if (location != null) {
    node.loc = location;
  }
  return node;
}

PropertyNode createProperty(ValueNode key, dynamic value, [Location location]) {
  final node = new PropertyNode();
  node.key = key;
  node.value = value;
  if (location != null) {
    node.loc = location;
  }
  return node;
}

ObjectNode createObject(List<Node> properties, [Location location]) {
  final node = new ObjectNode();
  node.children.addAll(properties);
  if (location != null) {
    node.loc = location;
  }
  return node;
}

ArrayNode createArray(List items, [Location location]) {
  final node = new ArrayNode();
  node.children.addAll(items);
  if (location != null) {
    node.loc = location;
  }
  return node;
}

LiteralNode createLiteral(dynamic value, String raw, [Location location]) {
  final node = new LiteralNode(value, raw);
  if (location != null) {
    node.loc = location;
  }
  return node;
}

class TestAST {
  final Node ast;
  final Settings options;

  TestAST(this.ast, this.options);
}
