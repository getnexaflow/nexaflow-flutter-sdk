import 'page.dart';

/// {@template Website.Website}
/// A representation of a website, containing metadata and pages.
/// {@endtemplate}
class Website {
  /// Id of the website.
  final String id;

  /// Metadata associated with the website.
  final Metadata metadata;

  /// The list of pages within the website.
  final List<Page> pages;

  /// {@macro Website.Website}
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

/// {@template Website.Metadata}
/// A representation of a website, containing metadata and pages.
/// {@endtemplate}
class Metadata {
  /// Name of the website.
  final String siteName;

  /// URL of the website.
  final String siteUrl;

  /// Description of the website.
  final String? description;

  /// {@macro Website.Metadata}
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
