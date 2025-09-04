import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_the_go/features/place_details/presentation/views/place_details_view.dart';

class DemoTourModel {
  final String title;
  final String description;
  final String image;
  final double priceAdult;
  final double discount;
  final String status;
  final String availability;

  DemoTourModel({
    required this.title,
    required this.description,
    required this.image,
    required this.priceAdult,
    required this.discount,
    required this.status,
    required this.availability,
  });
}

class TripCard extends StatefulWidget {
  const TripCard({super.key, required this.width});
  final double width;

  @override
  State<TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<TripCard>
    with SingleTickerProviderStateMixin {
  bool isHover = false;
  late AnimationController _controller;
  late Animation<double> _shimmerAnimation;
  late final DemoTourModel tourModel;

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
    tourModel = _getDemoTourData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DemoTourModel _getDemoTourData() {
    final tours = [
      DemoTourModel(
        title: "Tropical Paradise Beach",
        description: "Crystal clear waters and pristine white sand beaches",
        image:
            "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800",
        priceAdult: 150.0,
        discount: 30.0,
        status: "popular",
        availability: "Daily",
      ),
      DemoTourModel(
        title: "Mountain Adventure Trek",
        description: "Breathtaking views and fresh mountain air experience",
        image:
            "https://images.unsplash.com/photo-1447433589675-4aaa569f3e05?w=800",
        priceAdult: 200.0,
        discount: 0.0,
        status: "new",
        availability: "Weekends",
      ),
      DemoTourModel(
        title: "Desert Safari Journey",
        description: "Golden dunes and traditional desert culture exploration",
        image:
            "https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800",
        priceAdult: 120.0,
        discount: 20.0,
        status: "hot",
        availability: "3x Weekly",
      ),
    ];
    return tours[DateTime.now().second % tours.length];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(PlaceDetailsView.routeName),
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
                              image: NetworkImage(tourModel.image),
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
                              color: _getStatusColor(tourModel.status),
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
                              tourModel.status.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        // Discount Badge
                        if (tourModel.discount > 0)
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
                                if (tourModel.discount > 0) ...[
                                  Text(
                                    "\$${tourModel.priceAdult.toInt()}",
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
                            tourModel.title,
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
                                      i < 4
                                          ? Colors.amber
                                          : Colors.grey.shade300,
                                  size: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "4.5",
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
                              tourModel.description,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          // Availability
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: Colors.grey[500],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                tourModel.availability,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "Available",
                                  style: TextStyle(
                                    color: Colors.green,
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

  Color _getStatusColor(String status) {
    switch (status) {
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

  int _getDiscountPercent() =>
      ((tourModel.discount / tourModel.priceAdult) * 100).round();

  double _getFinalPrice() => tourModel.priceAdult - tourModel.discount;
}
