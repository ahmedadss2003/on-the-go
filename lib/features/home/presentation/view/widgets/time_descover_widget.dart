import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TimeToDiscoverContainer extends StatelessWidget {
  const TimeToDiscoverContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "It's time to discover",
            style: TextStyle(
              color: Color(0xFF1F3E66),
              fontSize: 34,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          AutoSizeText(
            "From cultural tours to safaris, private adventures, and sailing trips.",
            style: TextStyle(
              color: Color(0xFF1F3E66),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          AutoSizeText(
            "Discover the world your way – on a group tour, private adventure, safari, or sailing trip. From ancient wonders to wild landscapes and sun-soaked coasts, local guides help you uncover authentic experiences in over +70 destinations.",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
