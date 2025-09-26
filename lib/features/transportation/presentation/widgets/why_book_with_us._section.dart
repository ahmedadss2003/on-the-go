import 'package:flutter/material.dart';

class WhyBookWithUsSection extends StatelessWidget {
  const WhyBookWithUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isWeb = constraints.maxWidth > 900;
          bool isTablet =
              constraints.maxWidth > 700 && constraints.maxWidth <= 900;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trust Badges Section
              _buildTrustBadges(isWeb, isTablet),
              const SizedBox(height: 50),

              // Main Content Section
              isWeb ? _buildWebLayout() : _buildMobileLayout(isTablet),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTrustBadges(bool isWeb, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isWeb ? 40 : 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20,
        runSpacing: 20,
        children: [
          _buildTrustBadge(
            platform: 'REVIEWS',
            rating: '9.6 out of 10',
            stars: 4.5,
            color: Colors.green,
          ),
          _buildTrustBadge(
            platform: 'Trustpilot',
            rating: '8.7 out of 10',
            stars: 4.0,
            color: Colors.green,
            icon: Icons.verified_user,
          ),
          _buildTrustBadge(
            platform: 'tripadvisor',
            rating: '9.2 out of 10',
            stars: 5.0,
            color: Colors.green,
            icon: Icons.travel_explore,
          ),
        ],
      ),
    );
  }

  Widget _buildTrustBadge({
    required String platform,
    required String rating,
    required double stars,
    required Color color,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, color: color, size: 16),
                const SizedBox(width: 4),
              ],
              Text(
                platform,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (index) {
              return Icon(
                index < stars.floor()
                    ? Icons.star
                    : index < stars
                    ? Icons.star_half
                    : Icons.star_border,
                color: Colors.amber,
                size: 16,
              );
            }),
          ),
          const SizedBox(height: 4),
          Text(
            rating,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column - Why book with us
        Expanded(flex: 1, child: _buildWhyBookWithUs()),
        const SizedBox(width: 60),
        // Right Column - Why book a transfer (to be added later)
        // For now, leaving it commented as per your current code
      ],
    );
  }

  Widget _buildMobileLayout(bool isTablet) {
    return Column(
      children: [
        _buildWhyBookWithUs(),
        SizedBox(height: isTablet ? 40 : 30),
        // _buildWhyBookTransfer() (to be added later)
      ],
    );
  }

  Widget _buildWhyBookWithUs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Why book with us',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 20),
        _buildFeaturesList(),
      ],
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      {
        'icon': Icons.verified,
        'title': 'Excellent reputation',
        'color': Colors.green,
      },
      {
        'icon': Icons.credit_card_off,
        'title': 'No credit card fees',
        'color': Colors.blue,
      },
      {'icon': Icons.toll, 'title': 'Tolls included', 'color': Colors.green},
      {
        'icon': Icons.person,
        'title': 'Professional drivers',
        'color': Colors.green,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children:
            features.map((feature) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: (feature['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        feature['icon'] as IconData,
                        color: feature['color'] as Color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        feature['title'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}
