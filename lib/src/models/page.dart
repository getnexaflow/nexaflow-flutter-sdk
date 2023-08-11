import 'block.dart';

class Page {
  final String id;
  final List<Block> blocks;

  final PageMetadata metadata;
  final String updatedAt;
  final String websiteId;

  const Page({
    required this.id,
    required this.blocks,
    required this.metadata,
    required this.updatedAt,
    required this.websiteId,
  });

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

class PageMetadata {
  final String title;
  final String slug;
  final String status;
  final String? contentType;

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
