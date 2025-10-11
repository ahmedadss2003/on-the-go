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
            "we transform every trip into an unforgettable story.We are a trusted and licensed tour company in Egypt, offering tailor-made journeys that blend ancient wonders, modern adventures, and authentic local experiences.",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
