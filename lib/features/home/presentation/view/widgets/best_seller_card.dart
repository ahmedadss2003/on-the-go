import 'package:flutter/material.dart';

class BestSellerTourCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String country;
  final double rating;
  final int reviewCount;
  final int days;
  final String location;
  final String ageRange;
  final int maxGroupSize;
  final double originalPrice;
  final double currentPrice;
  final int discountPercent;

  const BestSellerTourCard({
    super.key,
    this.imageUrl =
        'https://images.unsplash.com/photo-1664624897176-4118caa15b2e?q=80&w=1169&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    this.title = 'Totally Morocco',
    this.country = 'Morocco',
    this.rating = 4.7,
    this.reviewCount = 164,
    this.days = 9,
    this.location = 'Marrakech back to Marrakech',
    this.ageRange = '15+',
    this.maxGroupSize = 24,
    this.originalPrice = 1403,
    this.currentPrice = 966,
    this.discountPercent = 35,
  });

  @override
  State<BestSellerTourCard> createState() => _BestSellerTourCardState();
}

class _BestSellerTourCardState extends State<BestSellerTourCard> {
  double spreadRadius = 2;
  Color containerColor = Colors.white;
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          spreadRadius = 4;
          containerColor = Colors.grey[200]!;
          isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          spreadRadius = 2;
          containerColor = Colors.white;
          isHover = false;
        });
      },
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(16),
          border:
              isHover
                  ? Border.all(
                    color: const Color.fromARGB(255, 0, 73, 95)!,
                    width: 0,
                  )
                  : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: spreadRadius,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildImageSection(), _buildContentSection()],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFA726),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                const Text(
                  'Best Seller',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE53E3E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Save\n${widget.discountPercent}%',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 16,
                height: 12,
                decoration: BoxDecoration(
                  color: const Color(0xFFD32F2F),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                widget.country,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF666666),
                ),
              ),
              const Spacer(),
              const Icon(Icons.star, color: Color(0xFFFFA726), size: 16),
              const SizedBox(width: 4),
              Text(
                '${widget.rating}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(${widget.reviewCount})',
                style: const TextStyle(fontSize: 12, color: Color(0xFF999999)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A365D),
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow('${widget.days} Days', null),
          const SizedBox(height: 8),
          _buildDetailRow(widget.location, null),
          const SizedBox(height: 8),
          _buildDetailRow('Age Range: ${widget.ageRange}', null),
          const SizedBox(height: 8),
          _buildDetailRow('Max Group Size: ${widget.maxGroupSize}', null),
          const SizedBox(height: 16),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'From',
                    style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${widget.originalPrice.toInt()}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFFE53E3E),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const Text(
                        'pp',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFE53E3E),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'USD',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${widget.currentPrice.toInt()}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A365D),
                        ),
                      ),
                      const Text(
                        'pp',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String text, IconData? icon) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 16, color: const Color(0xFF666666)),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
          ),
        ),
      ],
    );
  }
}
