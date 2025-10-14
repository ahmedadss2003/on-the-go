import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});
  static const routeName = "/aboutus";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light background for contrast
      appBar: AppBar(
        title: const Text(
          'About On The Go Excursions',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFF1A3C34), // Deep teal for Egyptian vibe
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Image Section
            Container(
              width: double.infinity,
              height: isMobile ? 200 : 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://media.istockphoto.com/id/2194070027/photo/the-great-pyramid-with-camel-in-giza-egypt.webp?a=1&b=1&s=612x612&w=0&k=20&c=q2Oj1zkEAuqp_EZdr-2Iecbn92JWa_XV7l_hzJWGOTE=",
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black26,
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Center(
                child: AutoSizeText(
                  'Discover Egypt with Us',
                  style: TextStyle(
                    fontSize: isMobile ? 28 : 40,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1.0,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Main Content
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: isMobile ? 30 : 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Intro Title
                  AutoSizeText(
                    'Who We Are',
                    style: TextStyle(
                      fontSize: isMobile ? 24 : 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A3C34),
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10),
                  AutoSizeText(
                    'At On The Go Excursions, we craft unforgettable journeys through Egypt’s rich history and vibrant culture.',
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 18,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 30),
                  // Sections as Cards
                  _buildSectionCard(
                    context,
                    'Our Journey',
                    'Started from Scratch in Egypt Tourism: We began On The Go Excursions from humble beginnings, becoming one of the best Egypt tour companies for travelers seeking Egypt tours, Red Sea adventures, Nile cruises, and cultural experiences in Cairo, Luxor, and Sharm El Sheikh.',
                    width,
                    icon: Icons.explore,
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    context,
                    'Feel at Home in Egypt',
                    'Every traveler is treated like a friend, enjoying personalized Egypt tours, airport transfers in Cairo, Luxor, and Sharm El Sheikh, and comfortable city transportation.',
                    width,
                    icon: Icons.home,
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    context,
                    'Unforgettable Memories',
                    'Our Egypt tours are designed to provide life-changing experiences, including visits to the Pyramids of Giza, Sphinx, Valley of the Kings, Luxor temples, and Red Sea diving in Sharm El Sheikh and Hurghada.',
                    width,
                    icon: Icons.star,
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    context,
                    'Attention to Every Detail',
                    'From Nile River cruises to desert safari tours in Sharm El Sheikh, we ensure perfectly organized Egypt tours with every detail handled for UK and European tourists.',
                    width,
                    icon: Icons.check_circle,
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    context,
                    'Passion for Egypt’s Heritage',
                    'We specialize in Egypt cultural tours, Egypt historical trips, and sightseeing tours in Cairo, Alexandria, Luxor, and Aswan, giving travelers authentic Egyptian experiences.',
                    width,
                    icon: Icons.history,
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    context,
                    'Tailor-Made for You',
                    'Whether it’s Red Sea adventures, Nile cruises, or sightseeing in Cairo and Luxor, our Egypt travel packages are crafted for European tourists and UK travelers looking for the best Egypt vacation.',
                    width,
                    icon: Icons.map,
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    context,
                    'Comfort, Safety & Luxury',
                    'Every tour includes airport transfers, city transportation, private guides, and luxury travel services, ensuring safe, comfortable, and unforgettable Egypt tours.',
                    width,
                    icon: Icons.security,
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    context,
                    'Your Ultimate Egypt Experience',
                    'At On The Go Excursions, we provide top Egypt tours, Red Sea diving trips, Nile cruises, Luxor sightseeing tours, Cairo cultural tours, and Sharm El Sheikh safari adventures for European and UK travelers seeking memorable Egypt holidays.',
                    width,
                    icon: Icons.flight_takeoff,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context,
    String title,
    String text,
    double width, {
    required IconData icon,
  }) {
    final isMobile = width < 600;
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 800),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Icon(
                icon,
                size: isMobile ? 30 : 40,
                color: const Color(0xFFD4A017), // Gold accent
              ),
              const SizedBox(width: 15),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      title,
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A3C34),
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 10),
                    AutoSizeText(
                      text,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade800,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.start,
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
