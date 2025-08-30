import 'package:on_the_go/core/models/category_model.dart';
import 'package:on_the_go/core/models/service_item.dart';
import 'package:on_the_go/core/models/tour_images_model.dart';

class TourModel {
  final int id;
  final String title;
  final String description;
  final String? status;
  final String? timeOfTour;
  final int? ageRequirement;
  final String availability;
  final int numberOfPeople;
  final String? departureTime;
  final String? returnTime;
  final int priceAdult;
  final int priceChild;
  final int discount;
  final String createdAt;
  final String updatedAt;
  final String? youtubeVideoUrl;
  final List<ServiceItem> includes;
  final List<ServiceItem> notIncludes;
  final List<CategoryModel> categories;
  final List<TourImage> images;

  TourModel({
    required this.id,
    required this.title,
    required this.description,
    this.status,
    this.timeOfTour,
    this.ageRequirement,
    required this.availability,
    required this.numberOfPeople,
    required this.departureTime,
    required this.returnTime,
    required this.priceAdult,
    required this.priceChild,
    required this.discount,
    required this.createdAt,
    required this.updatedAt,
    this.youtubeVideoUrl, // Added to constructor
    required this.includes,
    required this.notIncludes,
    required this.categories,
    required this.images,
  });

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'],
      timeOfTour: json['time_of_tour'],
      ageRequirement: json['age_requirement'],
      availability: json['availability'] ?? '',
      numberOfPeople: json['number_of_people'] ?? 0,
      departureTime: json['departure_time'],
      returnTime: json['return_time'],
      priceAdult: json['price_adult'] ?? 0,
      priceChild: json['price_child'] ?? 0,
      discount: json['discount'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      youtubeVideoUrl: json['youtube_video_url'],
      includes:
          (json['includes'] as List<dynamic>?)
              ?.map((x) => ServiceItem.fromJson(x))
              .toList() ??
          [],
      notIncludes:
          (json['not_includes'] as List<dynamic>?)
              ?.map((x) => ServiceItem.fromJson(x))
              .toList() ??
          [],
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((x) => CategoryModel.fromJson(x))
              .toList() ??
          [],
      images:
          (json['images'] as List<dynamic>?)
              ?.map((x) => TourImage.fromJson(x))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'status': status,
    'time_of_tour': timeOfTour,
    'age_requirement': ageRequirement,
    'availability': availability,
    'number_of_people': numberOfPeople,
    'departure_time': departureTime,
    'return_time': returnTime,
    'price_adult': priceAdult,
    'price_child': priceChild,
    'discount': discount,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'youtube_video_url': youtubeVideoUrl, // Added to JSON serialization
    'includes': includes.map((x) => x.toJson()).toList(),
    'not_includes': notIncludes.map((x) => x.toJson()).toList(),
    'categories': categories.map((x) => x.toJson()).toList(),
    'images': images.map((x) => x.toJson()).toList(),
  };
}


  // factory TourModel.fromJson(Map<String, dynamic> json) {
  //   return TourModel(
  //     id: json['id'],
  //     title: json['title'],
  //     description: json['description'],
  //     status: json['status'],
  //     timeOfTour: json['time_of_tour'],
  //     ageRequirement: json['age_requirement'],
  //     availability: json['availability'],
  //     numberOfPeople: json['number_of_people'],
  //     departureTime: json['departure_time'],
  //     returnTime: json['return_time'],
  //     priceAdult: json['price_adult'],
  //     priceChild: json['price_child'],
  //     discount: json['discount'],
  //     createdAt: json['created_at'],
  //     updatedAt: json['updated_at'],
  //     youtubeVideoUrl: json['youtube_video_url'], // Added JSON parsing
  //     includes:
  //         json['includes'] != null
  //             ? List<ServiceItem>.from(
  //               json['includes'].map((x) => ServiceItem.fromJson(x)),
  //             )
  //             : [],
  //     notIncludes:
  //         json['not_includes'] != null
  //             ? List<ServiceItem>.from(
  //               json['not_includes'].map((x) => ServiceItem.fromJson(x)),
  //             )
  //             : [],
  //     categories:
  //         json['categories'] != null
  //             ? List<CategoryModel>.from(
  //               json['categories'].map((x) => CategoryModel.fromJson(x)),
  //             )
  //             : [],
  //     images:
  //         json['images'] != null
  //             ? List<TourImage>.from(
  //               json['images'].map((x) => TourImage.fromJson(x)),
  //             )
  //             : [],
  //   );
  // }
