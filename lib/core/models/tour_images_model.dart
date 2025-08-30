class TourImage {
  final int id;
  final int tourId;
  final String image;
  final String createdAt;
  final String updatedAt;

  TourImage({
    required this.id,
    required this.tourId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TourImage.fromJson(Map<String, dynamic> json) {
    return TourImage(
      id: json['id'],
      tourId: json['tour_id'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'tour_id': tourId,
        'image': image,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
