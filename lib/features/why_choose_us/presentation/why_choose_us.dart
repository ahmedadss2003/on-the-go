import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WhyChooseUsView extends StatelessWidget {
  const WhyChooseUsView({super.key});
  static const routeName = "/whychooseus";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light background for contrast
      appBar: AppBar(
        title: const Text(
          'Why Choose On The Go Excursions',
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
                    'https://images.unsplash.com/photo-1544552866-d1c8f40f7190?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80', // Nile River image
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
                  'Your Journey, Our Passion',
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
                    'Why Travel with Us?',
                    style: TextStyle(
                      fontSize: isMobile ? 24 : 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A3C34),
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10),
                  AutoSizeText(
                    'Discover why On The Go Excursions is the top choice for unforgettable Egypt adventures.',
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
                    'Trusted & Professional',
                    'We are a reliable and professional Egypt travel company, offering top-rated Egypt tours, Red Sea adventures, Nile cruises, and cultural tours in Cairo, Luxor, and Sharm El Sheikh.',
                    width,
                    icon: Icons.verified,
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    context,
                    'Best Value Experiences',
                    'Our Egypt travel packages are carefully selected to provide affordable, high-quality tours for UK and European travelers exploring Egypt’s iconic destinations.',
                    width,
                    icon: Icons.local_offer,
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    context,
                    'Transparent Services',
                    'We offer transparent Egypt tour services, ensuring no hidden fees, with a focus on exceptional customer satisfaction for every traveler.',
                    width,
                    icon: Icons.handshake,
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    context,
                    'Expert Local Guides',
                    'Our local guides in Cairo, Luxor, Sharm El Sheikh, and Hurghada deliver authentic Egyptian experiences, sharing history, culture, and insider tips to make every tour unique.',
                    width,
                    icon: Icons.tour,
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    context,
                    'Unforgettable Tours',
                    'From visiting the Pyramids of Giza, Sphinx, and Luxor temples to Red Sea diving, desert safari adventures, and Nile cruises, we design tours that create life-long memories.',
                    width,
                    icon: Icons.star,
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    context,
                    'Your Story-Worthy Journey',
                    'Join On The Go Excursions and let your Egypt travel experience be memorable, safe, comfortable, and truly extraordinary, tailored for UK and European tourists seeking the best Egypt holidays.',
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
