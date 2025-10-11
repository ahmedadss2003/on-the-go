import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key, required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 104, 103, 103),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: Column(
          children: [
            AutoSizeText(
              "About Us",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width < 700 ? 25 : 60),
              child: AutoSizeText(
                // maxLines: 3,
                textAlign:
                    TextAlign
                        .start, // بدل center عشان القراءة تكون مريحة ومنسقة
                " We began On The Go Excursions from humble beginnings, becoming one of the best Egypt tour companies for travelers seeking Egypt tours, Red Sea adventures, Nile cruises, and cultural experiences in Cairo, Luxor, and Sharm El Sheikh.\n"
                "• Feel at Home in Egypt: Every traveler is treated like a friend, enjoying personalized Egypt tours, airport transfers in Cairo, Luxor, and Sharm El Sheikh, and comfortable city transportation.\n"
                "• Create Unforgettable Egyptian Memories: Our Egypt tours are designed to provide life-changing experiences, including visits to the Pyramids of Giza, Sphinx, Valley of the Kings, Luxor temples, and Red Sea diving in Sharm El Sheikh and Hurghada.\n"
                "• Attention to Every Detail: From Nile River cruises to desert safari tours in Sharm El Sheikh, we ensure perfectly organized Egypt tours with every detail handled for UK and European tourists.\n"
                "• Passion for Egypt’s History & Culture: We specialize in Egypt cultural tours, Egypt historical trips, and sightseeing tours in Cairo, Alexandria, Luxor, and Aswan, giving travelers authentic Egyptian experiences.\n"
                "• Comfort, Safety & Luxury: Every tour includes airport transfers, city transportation, private guides, and luxury travel services, ensuring safe, comfortable, and unforgettable Egypt tours.",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  height: 1.6, // تباعد مريح بين السطور
                  letterSpacing: 0.3, // يخلي الخط متناسق
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
