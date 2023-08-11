import 'page.dart';

class Website {
  final String id;
  final Metadata metadata;
  final List<Page> pages;

  Website({
    required this.id,
    required this.metadata,
    required this.pages,
  });

  factory Website.fromJson(Map<String, dynamic> json) {
    return Website(
      id: json['id'],
      metadata: Metadata.fromJson(json['metadata']),
      pages: json['pages'] == null
          ? []
          : (json['pages'] as List).map((e) => Page.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'metadata': metadata.toJson(),
      'pages': pages.map((e) => e.toJson()).toList(),
    };
  }
}

class Metadata {
  final String siteName;
  final String siteUrl;
  final String? description;

  Metadata({
    required this.siteName,
    required this.siteUrl,
    this.description,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      siteName: json['siteName'],
      siteUrl: json['siteUrl'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'siteName': siteName,
      'siteUrl': siteUrl,
      'description': description,
    };
  }
}
