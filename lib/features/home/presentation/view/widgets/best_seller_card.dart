import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_the_go/features/place_details/presentation/views/place_details_view.dart';
import 'package:on_the_go/core/models/tour_model.dart'; // Add this import

class BestSellerTourCard extends StatefulWidget {
  final TourModel tour;

  const BestSellerTourCard({super.key, required this.tour});

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
      child: GestureDetector(
        onTap: () {
          context.go(
            "${PlaceDetailsView.routeName}/${widget.tour.id}", // 👈 بتمرر id بس
          );
        },
        child: Container(
          width: 280,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(16),
            border:
                isHover
                    ? Border.all(
                      color: const Color.fromARGB(255, 0, 73, 95),
                      width: 1,
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
      ),
    );
  }

  Widget _buildImageSection() {
    final imageUrl =
        widget.tour.images.isNotEmpty
            ? widget.tour.images.first.url
            : 'https://images.unsplash.com/photo-1664624897176-4118caa15b2e?q=80&w=1169&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Show Best Seller badge only if tour is marked as best seller
        if (widget.tour.isBestSeller)
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
        // Show discount badge if there's a discount
        if (widget.tour.discount > 0)
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
                'Save\n${widget.tour.discount.toInt()}%',
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
    // Calculate discounted price
    final originalPrice = widget.tour.priceAdult;
    final discountedPrice =
        originalPrice - (originalPrice * widget.tour.discount / 100);

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
              Expanded(
                child: AutoSizeText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  widget.tour.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF666666),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Spacer(),

              const Icon(Icons.star, color: Color(0xFFFFA726), size: 16),
              const Icon(Icons.star, color: Color(0xFFFFA726), size: 16),
              const Icon(Icons.star, color: Color(0xFFFFA726), size: 16),
              const Icon(Icons.star, color: Color(0xFFFFA726), size: 16),
              const Icon(Icons.star, color: Color(0xFFFFA726), size: 16),
              const SizedBox(width: 4),
              AutoSizeText(
                widget.tour.rating.toString() ??
                    "4.5", // You might want to add rating to TourModel
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 4),
              AutoSizeText(
                "(${widget.tour.review.toString()})" ??
                    "20", // You might want to add review count to TourModel
                style: TextStyle(fontSize: 12, color: Color(0xFF999999)),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 8),

          AutoSizeText(
            minFontSize: 12,
            widget.tour.description,
            maxFontSize: 30,
            style: const TextStyle(
              // fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A365D),
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          _buildDetailRow("duration: ${widget.tour.timeOfTour}", null),
          const SizedBox(height: 10),
          _buildDetailRow(widget.tour.governorate, null),
          const SizedBox(height: 10),
          _buildDetailRow('Avilability: ${widget.tour.availability}', null),
          const SizedBox(height: 10),

          Row(
            children: [
              // Show original price only if there's a discount
              if (widget.tour.discount > 0) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${originalPrice.toInt()}',
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
              ],
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${widget.tour.discount > 0 ? discountedPrice.toInt() : originalPrice.toInt()}',
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
          child: AutoSizeText(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF666666),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,

            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
