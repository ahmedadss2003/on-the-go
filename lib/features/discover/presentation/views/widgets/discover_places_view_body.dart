import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:on_the_go/core/models/tour_model.dart';
import 'package:on_the_go/features/discover/presentation/views/widgets/discover_places_gridview.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/footer_section.dart';

class DiscoverPlacesViewBody extends StatefulWidget {
  const DiscoverPlacesViewBody({
    super.key,
    required this.governMentName,

    this.type,
    this.tourModel,
  });
  final String governMentName;
  final String? type;
  final TourModel? tourModel;
  @override
  State<DiscoverPlacesViewBody> createState() => _DiscoverPlacesViewBodyState();
}

class _DiscoverPlacesViewBodyState extends State<DiscoverPlacesViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<double>(
      begin: 30.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF4F46E5), // Indigo
                      Color(0xFF7C3AED), // Purple
                      Color(0xFFEC4899), // Pink
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 600;
                    final isTablet =
                        constraints.maxWidth >= 600 &&
                        constraints.maxWidth < 1024;
                    final isDesktop = constraints.maxWidth >= 1024;

                    // Dynamic description based on selected government
                    String? description;
                    if (widget.governMentName == "Sharm El Sheikh Tours") {
                      description =
                          "Discover the stunning beauty of Sharm El Sheikh with On The Go Excursions! Enjoy unforgettable tours including desert safaris, snorkeling, diving trips, and cultural excursions. Our professional local guides ensure an exceptional experience, with airport transfers and city transportation for your convenience. Perfect for UK and European travelers seeking adventure, relaxation, and luxury in Egyptian Red Sea destinations.";
                    } else if (widget.governMentName == "Luxor Tours") {
                      description =
                          "Experience the ancient wonders of Luxor with On The Go Excursions! Explore Valley of the Kings, Karnak Temple, Luxor Temple, and enjoy a relaxing Nile cruise. Our tours include airport transfers and city transportation, guided by professional locals providing detailed cultural insights. Ideal for UK and European travelers seeking a historical and cultural journey in Egypt.";
                    } else if (widget.governMentName == "Cairo Tours") {
                      description =
                          "Discover the vibrant city of Cairo with On The Go Excursions! Enjoy tours to the Pyramids of Giza, Sphinx, Egyptian Museum, and Khan El Khalili Bazaar. Experience Egypt’s rich culture and history with ease, thanks to airport transfers and city transportation. Perfect for UK and European tourists looking for a comprehensive cultural and historical experience in Egypt’s capital.";
                    }

                    return Stack(
                      children: [
                        // Decorative circles
                        Positioned(
                          top: -50,
                          right: -50,
                          child: Opacity(
                            opacity: 0.1,
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -30,
                          left: -30,
                          child: Opacity(
                            opacity: 0.1,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),

                        SafeArea(
                          child: AnimatedBuilder(
                            animation: _slideAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, _slideAnimation.value),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 16 : 32,
                                    vertical: isMobile ? 20 : 40,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Icon container
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(
                                              0.3,
                                            ),
                                            width: 1,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.explore,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      ),
                                      const SizedBox(height: 24),

                                      // Title + animation
                                      ScaleTransition(
                                        scale: _scaleAnimation,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              widget.governMentName,
                                              maxLines: 1,
                                              minFontSize: 16,
                                              style: TextStyle(
                                                fontSize:
                                                    isMobile
                                                        ? 26
                                                        : isTablet
                                                        ? 32
                                                        : 38,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white,
                                                letterSpacing: -0.8,
                                                height: 1.1,
                                              ),
                                            ),
                                            const SizedBox(height: 10),

                                            if (widget.type != null)
                                              AutoSizeText(
                                                "With Category: ${widget.type}",
                                                style: TextStyle(
                                                  fontSize: isMobile ? 12 : 14,
                                                  color: Colors.white,
                                                ),
                                              ),

                                            const SizedBox(height: 10),

                                            AutoSizeText(
                                              'Explore breathtaking ${widget.governMentName.toLowerCase()} destinations',
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: isMobile ? 12 : 16,
                                                color: const Color.fromARGB(
                                                  255,
                                                  209,
                                                  203,
                                                  203,
                                                ),
                                                fontWeight: FontWeight.w500,
                                                height: 1.4,
                                              ),
                                            ),
                                            const SizedBox(height: 20),

                                            // Dynamic Description
                                            if (description != null)
                                              AutoSizeText(
                                                description!,
                                                maxLines: isMobile ? 5 : 6,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: isMobile ? 13 : 16,
                                                  color: const Color.fromARGB(
                                                    255,
                                                    209,
                                                    203,
                                                    203,
                                                  ),
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.4,
                                                ),
                                              ),

                                            const SizedBox(height: 20),

                                            // Animated underline
                                            AnimatedBuilder(
                                              animation: _controller,
                                              builder: (context, child) {
                                                return Container(
                                                  height: 4,
                                                  width:
                                                      (isMobile ? 60 : 80) *
                                                      _controller.value,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          2,
                                                        ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Content Section
              Transform.translate(
                offset: Offset(0, _slideAnimation.value),
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 226, 226),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4F46E5).withOpacity(0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Section Header
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Gradient dot
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF4F46E5),
                                    Color(0xFFEC4899),
                                  ],
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Featured Places',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            const Spacer(),
                            // Simple badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4F46E5).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Popular',
                                style: TextStyle(
                                  color: Color(0xFF4F46E5),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Grid View
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        child: CustomDiscoverPlacesByCategoryGridView(
                          currentTour: widget.tourModel,
                          governMentName: widget.governMentName,
                          type: widget.type,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100),
              const FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}
