import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:on_the_go/features/discover/presentation/views/widgets/discover_places_gridview.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/footer_section.dart';

class DiscoverPlacesViewBody extends StatefulWidget {
  const DiscoverPlacesViewBody({
    super.key,
    required this.governMentName,
    this.type,
  });
  final String governMentName;
  final String? type;

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
                height: 320,
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
                child: Stack(
                  children: [
                    // Background pattern - subtle
                    Positioned(
                      top: -50,
                      right: -50,
                      child: Opacity(
                        opacity: 0.1,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
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
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                      ),
                    ),
                    // Content
                    SafeArea(
                      child: AnimatedBuilder(
                        animation: _slideAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _slideAnimation.value),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  // Icon with simple glow
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.explore,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  // Main Title
                                  ScaleTransition(
                                    scale: _scaleAnimation,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          maxLines: 1,
                                          maxFontSize: 38,

                                          minFontSize: 12,
                                          widget.governMentName,
                                          style: const TextStyle(
                                            fontSize: 38,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                            letterSpacing: -0.8,
                                            height: 1.1,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        widget.type != null
                                            ? AutoSizeText(
                                              "With Category: ${widget.type}",
                                            )
                                            : Text(""),
                                        const SizedBox(height: 12),
                                        AutoSizeText(
                                          maxLines: 1,
                                          'Explore breathtaking ${widget.governMentName.toLowerCase()} destinations',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
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
                                        // Simple animated line
                                        AnimatedBuilder(
                                          animation: _controller,
                                          builder: (context, child) {
                                            return Container(
                                              height: 4,
                                              width: 80 * _controller.value,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(2),
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
