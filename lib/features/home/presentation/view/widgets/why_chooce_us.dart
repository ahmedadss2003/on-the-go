import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WhyChooceUs extends StatelessWidget {
  const WhyChooceUs({super.key, required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 55, 9, 9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            AutoSizeText(
              "Why Choose Us ?",
              maxFontSize: 36,
              minFontSize: 20,
              style: TextStyle(
                // fontSize: 36,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width < 700 ? 25 : 60),
              child: AutoSizeText(
                "Trusted & Professional Egypt Tour Operator: We are a reliable and professional Egypt travel company, offering top-rated Egypt tours, Red Sea adventures, Nile cruises, and cultural tours in Cairo, Luxor, and Sharm El Sheikh.\n\n"
                "• Handpicked Experiences at the Best Prices: Our Egypt travel packages are carefully selected to provide affordable, high-quality tours for UK and European travelers exploring Egypt’s iconic destinations.\n\n"
                "• Honest, Transparent & Customer-Centered Services: We offer transparent Egypt tour services, ensuring no hidden fees, with a focus on exceptional customer satisfaction for every traveler.\n\n"
                "• Passionate Guides with Local Expertise: Our local guides in Cairo, Luxor, Sharm El Sheikh, and Hurghada deliver authentic Egyptian experiences, sharing history, culture, and insider tips to make every tour unique.\n\n"
                "• Unique Tours Designed for Unforgettable Memories: From visiting the Pyramids of Giza, Sphinx, and Luxor temples to Red Sea diving, desert safari adventures, and Nile cruises, we design tours that create life-long memories.",
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  height: 1.6, // يخلي المسافات بين السطور مريحة للعين
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
