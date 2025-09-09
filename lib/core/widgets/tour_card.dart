import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/place_details/presentation/views/place_details_view.dart';

class TourCard extends StatefulWidget {
  const TourCard({super.key, required this.width, required this.tourModel});
  final double width;
  final TourModel tourModel;

  @override
  State<TourCard> createState() => _TourCardState();
}

class _TourCardState extends State<TourCard>
    with SingleTickerProviderStateMixin {
  bool isHover = false;
  late AnimationController _controller;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(PlaceDetailsView.routeName, extra: widget.tourModel);
        Future.delayed(Duration(milliseconds: 100), () {
          if (Scrollable.maybeOf(context) != null) {
            Scrollable.ensureVisible(
              context,
              duration: Duration(milliseconds: 800),
              curve: Curves.easeInOut,
            );
          }
        });
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()..scale(isHover ? 1.02 : 1.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  const Color.fromARGB(255, 254, 255, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      isHover
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.black.withOpacity(0.1),
                  blurRadius: isHover ? 20 : 10,
                  offset: Offset(0, isHover ? 8 : 4),
                  spreadRadius: isHover ? 2 : 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Section with Overlay
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(_getImageUrl()),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.3),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),

                        // Shimmer Effect
                        if (isHover)
                          AnimatedBuilder(
                            animation: _shimmerAnimation,
                            builder: (context, child) {
                              return Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.white.withOpacity(0.3),
                                        Colors.transparent,
                                      ],
                                      stops: const [0.0, 0.5, 1.0],
                                      begin: Alignment(
                                        _shimmerAnimation.value - 0.3,
                                        -1.0,
                                      ),
                                      end: Alignment(
                                        _shimmerAnimation.value + 0.3,
                                        1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                        // Status Badge
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(widget.tourModel.status),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              widget.tourModel.status.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        // Best Seller Badge (if applicable)
                        if (widget.tourModel.isBestSeller)
                          Positioned(
                            top: 12,
                            left: _getStatusBadgeWidth() + 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFFD700),
                                    Color(0xFFFF8E53),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Text(
                                "BEST SELLER",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                        // Discount Badge
                        if (widget.tourModel.discount > 0)
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFF6B6B),
                                    Color(0xFFFF8E53),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                "${_getDiscountPercent()}% OFF",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                        // Price Tag
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widget.tourModel.discount > 0) ...[
                                  Text(
                                    "\$${widget.tourModel.priceAdult.toInt()}",
                                    style: const TextStyle(
                                      color: Colors.white60,
                                      fontSize: 12,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                ],
                                Text(
                                  "\$${_getFinalPrice().toInt()}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content Section
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          AutoSizeText(
                            widget.tourModel.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2D3748),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),

                          // Rating
                          Row(
                            children: [
                              ...List.generate(
                                5,
                                (i) => Icon(
                                  Icons.star,
                                  color:
                                      i < _getRatingStars()
                                          ? Colors.amber
                                          : Colors.grey.shade300,
                                  size: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.tourModel.rating.toString(),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Description
                          Expanded(
                            child: AutoSizeText(
                              widget.tourModel.description,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          // Availability and Category
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: Colors.grey[500],
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  widget.tourModel.availability,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  widget.tourModel.category,
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getImageUrl() {
    if (widget.tourModel.images.isNotEmpty) {
      return widget.tourModel.images.first.url;
    }
    // Fallback image if no images are available
    return "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800";
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'popular':
        return Colors.orange;
      case 'new':
        return Colors.green;
      case 'hot':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  double _getStatusBadgeWidth() {
    // Approximate width calculation for status badge positioning
    return widget.tourModel.status.length * 8.0 + 16;
  }

  int _getDiscountPercent() =>
      ((widget.tourModel.discount / widget.tourModel.priceAdult) * 100).round();

  double _getFinalPrice() =>
      widget.tourModel.priceAdult - widget.tourModel.discount;

  int _getRatingStars() {
    try {
      final rating = double.tryParse(widget.tourModel.rating.toString()) ?? 0.0;
      return rating.round();
    } catch (e) {
      return 0;
    }
  }
}
