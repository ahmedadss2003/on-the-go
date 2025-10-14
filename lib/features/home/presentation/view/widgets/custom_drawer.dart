import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_the_go/features/about_us/presentation/pages/about_us_view.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/destionation_button.dart';
import 'package:on_the_go/features/transportation/presentation/transporation_Booking_view.dart';
import 'package:on_the_go/features/why_choose_us/presentation/why_choose_us.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.footerKey,
    required this.howBookKey,
    required this.offersKey,
    required this.aboutKey,
    required this.favKey,
  });

  final GlobalKey footerKey;
  final GlobalKey howBookKey;
  final GlobalKey offersKey;
  final GlobalKey aboutKey;
  final GlobalKey favKey;
  void _scrollToSection(BuildContext context, GlobalKey sectionKey) {
    if (sectionKey.currentContext != null) {
      Scrollable.ensureVisible(
        sectionKey.currentContext!,
        alignment: 0.0, // Always start from top of the section
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromRGBO(5, 44, 106, 0.9),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF052C6A)),
              child: Center(
                child: Image.asset("assets/images/logo2.png", width: 120),
              ),
            ),
            Row(
              children: [
                SizedBox(width: 16),
                Icon(Icons.menu, color: Colors.white),
                SizedBox(width: 10),
                HoverMenuDestinationButton(),
              ],
            ),
            SizedBox(height: 6),
            _buildDrawerItem(context, Icons.info_outline, "About Us", () {
              context.go(AboutUsView.routeName);
              Navigator.pop(context);
            }),
            _buildDrawerItem(context, Icons.info_outline, "Why Choose Us", () {
              context.go(WhyChooseUsView.routeName);
              Navigator.pop(context);
            }),
            _buildDrawerItem(context, Icons.local_offer, "Offers", () {
              _scrollToSection(context, offersKey);
              Navigator.pop(context);
            }),
            _buildDrawerItem(context, Icons.room_service, "Favorites", () {
              _scrollToSection(context, favKey);
              Navigator.pop(context);
            }),
            _buildDrawerItem(context, Icons.room_service, "How to Book", () {
              _scrollToSection(context, howBookKey);
              Navigator.pop(context);
            }),

            _buildDrawerItem(context, Icons.contact_mail, "Contact", () {
              _launchWhatsApp();
              Navigator.pop(context);
            }),
            _buildDrawerItem(context, Icons.contact_mail, "Transportation", () {
              context.go(TransporationBookingView.routeName);
              Navigator.pop(context);
            }),
            _buildDrawerItem(context, Icons.contact_mail, "Travel Blog", () {
              _launchUrl();
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  void _launchWhatsApp() async {
    final Uri whatsapp = Uri.parse("https://wa.me/+201004536956");
    if (await canLaunchUrl(whatsapp)) {
      await launchUrl(whatsapp);
    } else {
      debugPrint("Could not launch WhatsApp");
    }
  }

  void _launchUrl() async {
    final Uri whatsapp = Uri.parse("https://onthegoexcursions.medium.com/");
    if (await canLaunchUrl(whatsapp)) {
      await launchUrl(whatsapp);
    } else {
      debugPrint("Could not launch WhatsApp");
    }
  }
}
