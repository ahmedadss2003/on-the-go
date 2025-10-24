import 'dart:html' as html;

class SEOService {
  static void updateMetaTags({
    required String title,
    required String description,
    required String url,
    String? imageUrl,
  }) {
    // تحديث Title
    html.document.title = title;

    // تحديث Description
    _updateMetaTag('description', description);

    // تحديث Open Graph
    _updateMetaTag('og:title', title);
    _updateMetaTag('og:description', description);
    _updateMetaTag('og:url', url);

    if (imageUrl != null) {
      _updateMetaTag('og:image', imageUrl);
    }

    // تحديث Twitter Cards
    _updateMetaTag('twitter:title', title);
    _updateMetaTag('twitter:description', description);
    if (imageUrl != null) {
      _updateMetaTag('twitter:image', imageUrl);
    }
  }

  static void _updateMetaTag(String name, String content) {
    var meta = html.document.querySelector('meta[name="$name"]');
    if (meta == null) {
      meta =
          html.MetaElement()
            ..name = name
            ..content = content;
      html.document.head?.append(meta);
    } else {
      (meta as html.MetaElement).content = content;
    }
  }
}
