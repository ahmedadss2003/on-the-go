import 'package:flutter/material.dart';
import 'package:on_the_go/core/models/tour_images_model.dart';

class Tour {
  final String id;
  final String title;
  final String description;
  final String timeOfTour;
  final String ageRequirement;
  final String availability;
  final String numberOfPeople;
  final String youtubeVideoUrl;
  final TimeOfDay? departureTime;
  final TimeOfDay? returnTime;
  final double priceAdult;
  final double priceChild;
  final double discount;
  final String priceIncludes;
  final String priceExcludes;
  final List<TourImage> images;
  final String status;
  final String governorate;
  final String category;
  final bool isBestSeller;
  final String? review;
  final String? rating;
  final List<dynamic> includedItems;
  final List<dynamic> notIncludedItems;

  Tour({
    required this.id,
    required this.title,
    required this.description,
    required this.timeOfTour,
    required this.ageRequirement,
    required this.availability,
    required this.numberOfPeople,
    required this.youtubeVideoUrl,
    this.departureTime,
    this.returnTime,
    required this.priceAdult,
    required this.priceChild,
    required this.discount,
    required this.priceIncludes,
    required this.priceExcludes,
    required this.images,
    required this.status,
    required this.governorate,
    required this.category,
    required this.review,
    required this.rating,
    required this.isBestSeller,
    required this.includedItems,
    required this.notIncludedItems,
  });

  // Add this toString method to help with debugging
  @override
  String toString() {
    return 'Tour{id: $id, title: $title, status: $status, priceAdult: $priceAdult, priceChild: $priceChild , governorate: $governorate , category: $category,}';
  }
}
