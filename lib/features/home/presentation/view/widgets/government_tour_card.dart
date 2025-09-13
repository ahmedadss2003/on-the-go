import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_the_go/features/discover/presentation/views/discover_places_view.dart';
import 'package:on_the_go/features/home/data/models/government_model.dart';

class GovernmentFilterTourCard extends StatefulWidget {
  const GovernmentFilterTourCard({super.key, required this.governmentModel});
  final GovernmentModel governmentModel;

  @override
  State<GovernmentFilterTourCard> createState() =>
      _GovernmentFilterTourCardState();
}

class _GovernmentFilterTourCardState extends State<GovernmentFilterTourCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final base =
            '${DiscoverPlacesView.routeName}/${widget.governmentModel.name}';
        final type = null;

        final path = type != null ? '$base?type=$type' : base;

        context.go(path);
      },

      child: MouseRegion(
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 160,
          decoration: BoxDecoration(
            color: isHover ? Colors.blue.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color:
                    isHover
                        ? Colors.blue.shade100.withOpacity(0.3)
                        : Colors.grey.shade200.withOpacity(0.2),
                spreadRadius: isHover ? 3 : 2,
                blurRadius: isHover ? 12 : 8,
                offset: Offset(0, isHover ? 6 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section with subtle overlay
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.governmentModel.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Subtle overlay for hover effect
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(isHover ? 0.15 : 0.1),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    // Subtle shimmer effect on hover
                    if (isHover)
                      AnimatedOpacity(
                        opacity: isHover ? 0.3 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.white.withOpacity(0.2),
                                Colors.transparent,
                              ],
                              begin: const Alignment(-1.5, -1.0),
                              end: const Alignment(1.5, 1.0),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Content section
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    AutoSizeText(
                      widget.governmentModel.name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E2A3C),
                        letterSpacing: -0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    // Description
                    AutoSizeText(
                      widget.governmentModel.description,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: const Color(0xFF4B5EAA).withOpacity(0.8),
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Explore Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: AnimatedOpacity(
                        opacity: isHover ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade600,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Explore',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
