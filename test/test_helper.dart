import 'package:test/test.dart';

import '../lib/tokenize.dart';

_assertSameNodeType(Node node, Node other) {
  expect(node.runtimeType, equals(other.runtimeType));
  expect(node.type, equals(other.type));
}

assertNode(Node node, Node other, {assertLocation: true, assertIndex: true}) {
  _assertSameNodeType(node, other);
  if (node is ValueNode && other is ValueNode) {
    _assertValueNode(node, other, assertLocation: assertLocation);
  }
  if (node is ObjectNode && other is ObjectNode) {
    _assertObjectNode(node, other,
        assertLocation: assertLocation, assertIndex: assertIndex);
  }
  if (node is ArrayNode && other is ArrayNode) {
    _assertArrayNode(node, other,
        assertLocation: assertLocation, assertIndex: assertIndex);
  }
  if (node is PropertyNode && other is PropertyNode) {
    _assertPropertyNode(node, other,
        assertLocation: assertLocation, assertIndex: assertIndex);
  }
  if (node is LiteralNode && other is LiteralNode) {
    _assertLiteralNode(node, other, assertLocation: assertLocation);
  }
}

_assertMaybeNode(dynamic val, dynamic other,
    {assertLocation: true, assertIndex: true}) {
  if (val is Node && other is Node) {
    assertNode(val, other,
        assertLocation: assertLocation, assertIndex: assertIndex);
  } else {
    expect(val.runtimeType, equals(other.runtimeType));
    expect(val, equals(other));
  }
}

_assertDynamicList(List l, List other,
    {assertLocation: true, assertIndex: true}) {
  if (l != null && other != null) {
    final len = l.length;
    expect(len, equals(l.length));
    for (int i = 0; i < len; i++) {
      final el = l.elementAt(i);
      final otherEl = other.elementAt(i);
      _assertMaybeNode(el, otherEl,
          assertLocation: assertLocation, assertIndex: assertIndex);
    }
  } else if (l == null && other != null || l != null && other == null) {
    expect(l, isNotNull);
    expect(other, isNotNull);
  }
}

_assertObjectNode(ObjectNode node, ObjectNode other,
    {assertLocation: true, assertIndex: true}) {
  if (assertLocation) {
    expect(node.loc, equals(other.loc));
  }
  _assertDynamicList(node.children, other.children,
      assertLocation: assertLocation, assertIndex: assertIndex);
}

_assertArrayNode(ArrayNode node, ArrayNode other,
    {assertLocation: true, assertIndex: true}) {
  if (assertLocation) {
    expect(node.loc, equals(other.loc));
  }
  _assertDynamicList(node.children, other.children,
      assertLocation: assertLocation, assertIndex: assertIndex);
}

_assertValueNode(ValueNode node, ValueNode other, {assertLocation: true}) {
  expect(node.value, equals(other.value));
  expect(node.raw, equals(other.raw));
  if (assertLocation) {
    expect(node.loc, equals(other.loc));
  }
}

_assertPropertyNode(PropertyNode node, PropertyNode other,
    {assertLocation: true, assertIndex: true}) {
  _assertValueNode(node.key as ValueNode, other.key as ValueNode,
      assertLocation: assertLocation);
  _assertMaybeNode(node.value, other.value,
      assertLocation: assertLocation, assertIndex: assertIndex);
  if (assertIndex) {
    expect(node.index, equals(other.index));
  }
  if (assertLocation) {
    expect(node.loc, equals(other.loc));
  }
  _assertDynamicList(node.children, other.children,
      assertLocation: assertLocation, assertIndex: assertIndex);
}

_assertLiteralNode(LiteralNode node, LiteralNode other,
    {assertLocation: true}) {
  expect(node.value, equals(other.value));
  expect(node.raw, equals(other.raw));
  if (assertLocation) {
    expect(node.loc, equals(other.loc));
  }
}
