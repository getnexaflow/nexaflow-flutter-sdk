import 'block.dart';

/// {@template Page.Page}
/// A representation of a web page.
/// {@endtemplate}
class Page {
  /// Id of the page.
  final String id;

  /// The list of blocks that make up the content of the page.
  final List<Block> blocks;

  /// Metadata associated with the page.
  final PageMetadata metadata;

  /// Timestamp when the page was last updated.
  final String updatedAt;

  /// The id of the website to which the page belongs.
  final String websiteId;

  /// {@macro Page.Page}
  const Page({
    required this.id,
    required this.blocks,
    required this.metadata,
    required this.updatedAt,
    required this.websiteId,
  });

  /// Maps a JSON block to a specific [Block] subtype.
  static Block mapToBlock(Map<String, dynamic> block) {
    switch (BlockType.values.byName(block['blockType'])) {
      case BlockType.text:
        return TextBlock.fromJson(block);

      case BlockType.textArea:
        return TextBlock.fromJson(block);

      case BlockType.link:
        return TextBlock.fromJson(block);

      case BlockType.richTextEditor:
        return TextBlock.fromJson(block);

      case BlockType.list:
        return ListBlock.fromJson(block);

      case BlockType.group:
        return GroupBlock.fromJson(block);
    }
  }

  factory Page.fromJson(Map<String, dynamic> json) {
    return Page(
      id: json['id'],
      blocks: (json['blocks'] as List).map((e) => mapToBlock(e)).toList(),
      metadata: PageMetadata.fromJson(json['metadata']),
      updatedAt: json['updatedAt'],
      websiteId: json['websiteId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'blocks': blocks.map((e) => e.toJson()).toList(),
      'metadata': metadata.toJson(),
      'updatedAt': updatedAt,
      'websiteId': websiteId
    };
  }
}

/// {@template Page.PageMetadata}
/// A representation of a web page.
/// {@endtemplate}
class PageMetadata {
  /// Title of the page.
  final String title;

  /// Slug of the page.
  final String slug;

  /// Status of the page.
  final String status;

  /// Content type of the page.
  final String? contentType;

  /// {@macro Page.PageMetadata}
  const PageMetadata({
    required this.title,
    required this.slug,
    required this.status,
    this.contentType,
  });

  factory PageMetadata.fromJson(Map<String, dynamic> json) {
    return PageMetadata(
      title: json['title'],
      slug: json['slug'],
      status: json['status'],
      contentType: json['contentType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'slug': slug,
      'status': status,
      'contentType': contentType
    };
  }
}
