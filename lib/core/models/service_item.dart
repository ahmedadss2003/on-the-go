class ServiceItem {
  final int id;
  final int tourId;
  final String serviceName;
  final String createdAt;
  final String updatedAt;

  ServiceItem({
    required this.id,
    required this.tourId,
    required this.serviceName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
      id: json['id'],
      tourId: json['tour_id'],
      serviceName: json['service_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'tour_id': tourId,
    'service_name': serviceName,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
