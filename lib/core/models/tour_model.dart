import 'package:flutter/material.dart';
import 'package:on_the_go/core/entities/tour_entity.dart';
import 'package:on_the_go/core/models/tour_images_model.dart';

class TourModel extends Tour {
  TourModel({
    required super.id,
    required super.title,
    required super.description,
    required super.timeOfTour,
    required super.ageRequirement,
    required super.availability,
    required super.numberOfPeople,
    required super.youtubeVideoUrl,
    super.departureTime,
    super.returnTime,
    required super.priceAdult,
    required super.priceChild,
    required super.discount,
    required super.priceIncludes,
    required super.priceExcludes,
    required super.images,
    required super.status,
    required super.isBestSeller,
    required super.governorate,
    required super.category,
    required super.review,
    required super.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timeOfTour': timeOfTour,
      'ageRequirement': ageRequirement,
      'availability': availability,
      'numberOfPeople': numberOfPeople,
      'youtubeVideoUrl': youtubeVideoUrl,
      'departureTime':
          departureTime != null ? formatTimeOfDay(departureTime!) : null,
      'returnTime': returnTime != null ? formatTimeOfDay(returnTime!) : null,
      'priceAdult': priceAdult,
      'priceChild': priceChild,
      'discount': discount,
      'priceIncludes': priceIncludes,
      'priceExcludes': priceExcludes,
      'images': images.map((e) => e.toJson()).toList(),
      'status': status,
      "governorate": governorate,
      'isBestSeller': isBestSeller,
      'category': category,
      'review': review,
      'rating': rating,
    };
  }

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      timeOfTour: json['timeOfTour'] ?? '',
      ageRequirement: json['ageRequirement'] ?? '',
      availability: json['availability'] ?? '',
      numberOfPeople: json['numberOfPeople'] ?? '',
      youtubeVideoUrl: json['youtubeVideoUrl'] ?? '',
      departureTime:
          json['departureTime'] != null
              ? TourModel.parseTimeOfDay(json['departureTime'])
              : null,
      returnTime:
          json['returnTime'] != null
              ? TourModel.parseTimeOfDay(json['returnTime'])
              : null,
      priceAdult: _convertToDouble(json['priceAdult']),
      priceChild: _convertToDouble(json['priceChild']),
      discount: _convertToDouble(json['discount']),
      priceIncludes: json['priceIncludes'] ?? '',
      priceExcludes: json['priceExcludes'] ?? '',
      images:
          (json['images'] as List<dynamic>? ?? [])
              .map((e) => TourImage.fromJson(e as Map<String, dynamic>))
              .toList(),
      status: json['status'] ?? 'Popular',
      isBestSeller: json['isBestSeller'] ?? false,
      governorate: json['governorate'] ?? 'Sharm El Sheikh',
      category: json['category'] ?? 'Red Sea',
      review: json['review'] ?? "",
      rating: json['rating'] ?? "0",
    );
  }

  // Helper method to safely convert to double
  static double _convertToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static TimeOfDay? parseTimeOfDay(String timeString) {
    try {
      if (timeString.isEmpty) return null;
      final parts = timeString.split(':');
      if (parts.length == 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        return TimeOfDay(hour: hour, minute: minute);
      }
    } catch (e) {
      print('Error parsing time: $e');
    }
    return null;
  }
}

String formatTimeOfDay(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}
