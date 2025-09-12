import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/review_card.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/review_card_data.dart';

class ReviewsSection extends StatelessWidget {
  final double width;
  final Color color = const Color.fromARGB(255, 98, 44, 25);

  const ReviewsSection({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width > 960 ? 30 : 16,
        vertical: 40,
      ),
      decoration: const BoxDecoration(color: Color(0xFFF8F9FA)),
      child: Column(
        children: [
          const AutoSizeText(
            'What Our Customers Say',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF101518),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Trusted by thousands of travelers worldwide',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF8D9199),
            ),
          ),
          const SizedBox(height: 32),
          _buildResponsiveGrid(),
        ],
      ),
    );
  }

  Widget _buildResponsiveGrid() {
    // Mobile: 1 column
    if (width < 768) {
      return Column(
        children: [
          _buildReviewCard(_reviewsData[0]),
          const SizedBox(height: 16),
          _buildReviewCard(_reviewsData[1]),
          const SizedBox(height: 16),
          _buildReviewCard(_reviewsData[2]),
          const SizedBox(height: 16),
          _buildReviewCard(_reviewsData[3]),
        ],
      );
    }

    // Tablet: 2 columns, 2 rows
    if (width < 1024) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildReviewCard(_reviewsData[0])),
              const SizedBox(width: 16),
              Expanded(child: _buildReviewCard(_reviewsData[1])),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildReviewCard(_reviewsData[2])),
              const SizedBox(width: 16),
              Expanded(child: _buildReviewCard(_reviewsData[3])),
            ],
          ),
        ],
      );
    }

    // Desktop: 4 columns, 1 row
    return Row(
      children: [
        Expanded(child: _buildReviewCard(_reviewsData[0])),
        const SizedBox(width: 16),
        Expanded(child: _buildReviewCard(_reviewsData[1])),
        const SizedBox(width: 16),
        Expanded(child: _buildReviewCard(_reviewsData[2])),
        const SizedBox(width: 16),
        Expanded(child: _buildReviewCard(_reviewsData[3])),
      ],
    );
  }

  Widget _buildReviewCard(ReviewCardData data) {
    return ReviewCard(
      icon: data.icon,
      title: data.title,
      subtitle: data.subtitle,
      description: data.description,
      backgroundColor: data.backgroundColor,
      iconColor: data.iconColor,
      showStars: data.showStars,
      rating: data.rating,
    );
  }

  // Static data for the four review cards
  static final List<ReviewCardData> _reviewsData = [
    ReviewCardData(
      icon: Icons.star_rounded,
      title: 'Trustpilot',
      subtitle: 'TrustScore 4.3 | 76,536 reviews',
      description: "We're trusted by our customers",
      backgroundColor: const Color.fromARGB(255, 98, 44, 25),
      iconColor: Colors.white,
      showStars: true,
      rating: 4.5,
    ),
    ReviewCardData(
      icon: Icons.security_rounded,
      title: 'SECURE YOUR ACCOUNT',
      subtitle: 'Your money is protected',
      description: 'Safe and secure payment processing',
      backgroundColor: const Color.fromARGB(255, 98, 44, 25),
      iconColor: Colors.white,
      showStars: false,
      rating: 0.0,
    ),
    ReviewCardData(
      icon: Icons.savings_rounded,
      title: 'No Deposits Required',
      subtitle: 'Payment plans with no fees',
      description: 'Flexible payment options available',
      backgroundColor: const Color.fromARGB(255, 98, 44, 25),
      iconColor: Colors.white,
      showStars: false,
      rating: 0.0,
    ),
    ReviewCardData(
      icon: Icons.book_rounded,
      title: 'easy Booking',
      subtitle: 'Quick and easy booking',
      description: 'Easy and hassle-free booking experience',
      backgroundColor: const Color.fromARGB(255, 98, 44, 25),
      iconColor: Colors.white,
      showStars: false,
      rating: 0.0,
    ),
  ];
}
