class TourImage {
  final String url;
  final String publicId;

  TourImage({required this.url, required this.publicId});

  factory TourImage.fromJson(Map<String, dynamic> json) {
    return TourImage(url: json['url'], publicId: json['public_id']);
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'public_id': publicId};
  }
}
