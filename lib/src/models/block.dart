import 'field.dart';

/// Enum to represent different types of blocks.
enum BlockType {
  text('text'),
  textArea('textArea'),
  link('link'),
  richTextEditor('rich_text_editor'),
  list('list'),
  group('group');

  /// Enum to represent different types of blocks.
  const BlockType(this.value);

  /// Json value from api response
  final String value;
}

extension BlockTypeByValue<T extends BlockType> on Iterable<T> {
  T byValue(String name) {
    for (var value in this) {
      if (value.value == name) return value;
    }
    throw ArgumentError.value(name, "value", "No BlockType with that value");
  }
}

/// {@template Block.Block}
/// An abstract class to handle different types of blocks in block library.
/// {@endtemplate}
abstract class Block<T> {
  /// Block Name
  final String blockName;

  /// Block Type
  final BlockType blockType;

  /// Description of the block
  final String? blockDescription;

  /// Id of the block
  final String id;

  /// BlockData of type [T]
  final T blockData;

  /// Bool for nested blocks
  final bool nested;

  /// {@macro Block.Block}
  const Block({
    required this.blockName,
    required this.blockType,
    this.blockDescription,
    required this.id,
    required this.blockData,
    required this.nested,
  });

  Map<String, dynamic> toJson();
}

/// {@template Block.TextBlock}
/// A Block of type String? for handling blocks of type:
/// - [BlockType.text]
/// - [BlockType.textArea]
/// - [BlockType.link]
/// - [BlockType.richTextEditor]
/// {@endtemplate}
class TextBlock extends Block<String?> {
  /// {@macro Block.TextBlock}
  TextBlock({
    required String blockName,
    required BlockType blockType,
    String? blockDescription,
    required String id,
    required String? blockData,
    required bool nested,
  }) : super(
          blockName: blockName,
          blockType: blockType,
          blockDescription: blockDescription,
          id: id,
          blockData: blockData,
          nested: nested,
        );

  factory TextBlock.fromJson(Map<String, dynamic> json) {
    return TextBlock(
      blockName: json['blockName'],
      blockType: BlockType.values.byValue(json['blockType']),
      blockDescription: json['blockDescription'],
      id: json['id'],
      blockData: json['blockData'][json['blockName']],
      nested: json['nested'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'blockName': blockName,
      'blockType': blockType.name,
      'blockDescription': blockDescription,
      'id': id,
      'blockData': blockData,
      'nested': nested,
    };
  }
}

/// {@template Block.GroupBlock}
/// A Block of type Map<String, Field> for handling [BlockType.group] blocks.
/// {@endtemplate}
class GroupBlock extends Block<Map<String, Field>> {
  /// {@macro Block.GroupBlock}
  GroupBlock({
    required String blockName,
    String? blockDescription,
    required String id,
    required Map<String, Field> blockData,
    required bool nested,
  }) : super(
          blockName: blockName,
          blockType: BlockType.group,
          blockDescription: blockDescription,
          id: id,
          blockData: blockData,
          nested: nested,
        );

  factory GroupBlock.fromJson(Map<String, dynamic> json) {
    return GroupBlock(
      blockName: json['blockName'],
      blockDescription: json['blockDescription'],
      id: json['id'],
      blockData: (json['blockData'] as Map)
          .map((key, value) => MapEntry(key, Field.fromJson(value))),
      nested: json['nested'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'blockName': blockName,
      'blockType': blockType.name,
      'blockDescription': blockDescription,
      'id': id,
      'blockData': blockData.map((key, value) => MapEntry(key, value.toJson())),
      'nested': nested,
    };
  }
}

/// {@template Block.ListBlock}
/// A Block of type List<MultiField> for handling [BlockType.list] blocks.
/// {@endtemplate}
class ListBlock extends Block<List<MultiField>> {
  /// {@macro Block.ListBlock}
  ListBlock({
    required String blockName,
    String? blockDescription,
    required String id,
    required List<MultiField> blockData,
    required bool nested,
  }) : super(
          blockName: blockName,
          blockType: BlockType.list,
          blockDescription: blockDescription,
          id: id,
          blockData: blockData,
          nested: nested,
        );

  factory ListBlock.fromJson(Map<String, dynamic> json) {
    return ListBlock(
      blockName: json['blockName'],
      blockDescription: json['blockDescription'],
      id: json['id'],
      blockData: (json['blockData'] as List)
          .map((e) => MultiField.fromJson(e))
          .toList(),
      nested: json['nested'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'blockName': blockName,
      'blockType': blockType.name,
      'blockDescription': blockDescription,
      'id': id,
      'blockData': blockData.map((e) => e.toJson()).toList(),
      'nested': nested,
    };
  }
}
