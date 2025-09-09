import 'package:flutter/material.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/destionation_button.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
                child: Image.asset("assets/images/logo.png", width: 120),
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
            _buildDrawerItem(context, Icons.info_outline, "About", () {
              Navigator.pop(context);
              // Add About navigation
            }),
            _buildDrawerItem(context, Icons.room_service, "Services", () {
              Navigator.pop(context);
              // Add Services navigation
            }),
            _buildDrawerItem(context, Icons.contact_mail, "Contact", () {
              _launchWhatsApp();

              Navigator.pop(context);
              // Add Contact navigation
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
    final Uri whatsapp = Uri.parse("https://wa.me/+201120919120");
    if (await canLaunchUrl(whatsapp)) {
      await launchUrl(whatsapp);
    } else {
      debugPrint("Could not launch WhatsApp");
    }
  }
}
