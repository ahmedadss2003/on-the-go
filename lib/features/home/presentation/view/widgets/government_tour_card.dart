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
  Color containerColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(
          DiscoverPlacesView.routeName,
          extra: {"governmentName": widget.governmentModel.name},
        );
      },
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            containerColor = Colors.grey[200]!;
          });
        },
        onExit: (event) {
          setState(() {
            containerColor = Colors.white;
          });
        },
        child: Container(
          width: 150,
          // margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.governmentModel.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Content section
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    AutoSizeText(
                      widget.governmentModel.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                        letterSpacing: -0.1,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Description
                    AutoSizeText(
                      maxLines: 2,
                      widget.governmentModel.description,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Color(0xFF5A6C7D),
                        letterSpacing: 0.1,
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
