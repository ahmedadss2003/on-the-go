import 'package:flutter/material.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/contact_us_button.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/destionation_button.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.footerKey});
  final GlobalKey footerKey;
  @override
  Size get preferredSize => const Size.fromHeight(80);

  void _scrollToFooter(BuildContext context) {
    Scrollable.ensureVisible(
      footerKey.currentContext!,
      alignment: 0.0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToHowBooking(BuildContext context) {
    Scrollable.ensureVisible(
      footerKey.currentContext!,
      alignment: 9.0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double tabletMobileWidth = 1041;
    return AppBar(
      backgroundColor: Color.fromARGB(255, 22, 14, 78),
      leading: width > 600 ? const SizedBox() : null,
      title: Row(
        children: [
          if (width > 1000) const SizedBox(width: 100),
          Image.asset("assets/images/logo.png", width: 100),
          const SizedBox(width: 30),
          if (width > tabletMobileWidth)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  HoverMenuDestinationButton(),
                  SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),

                    child: CustomAppBarButton(
                      onPressed: () {
                        _scrollToHowBooking(context);
                      },
                      txt: "How Book With Us",
                    ),
                  ),
                  SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CustomAppBarButton(
                      onPressed: () {
                        _scrollToFooter(context);
                      },
                      txt: "About Us",
                    ),
                  ),
                ],
              ),
            ),
          Spacer(),
          width > tabletMobileWidth
              ? CustomAppBarButton(
                onPressed: () {
                  _launchWhatsApp();
                },
                txt: "Contact Us",
              )
              : const SizedBox(),
        ],
      ),
      actions: [
        if (width < tabletMobileWidth)
          IconButton(
            padding: const EdgeInsets.only(right: 20, top: 15),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
      ],
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
