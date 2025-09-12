import 'package:flutter/widgets.dart';

class ReviewCardData {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final Color backgroundColor;
  final Color iconColor;
  final bool showStars;
  final double rating;

  ReviewCardData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.backgroundColor,
    required this.iconColor,
    this.showStars = false,
    this.rating = 0.0,
  });
}
