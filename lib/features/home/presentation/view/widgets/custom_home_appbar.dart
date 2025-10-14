import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_the_go/features/about_us/presentation/pages/about_us_view.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/contact_us_button.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/destionation_button.dart';
import 'package:on_the_go/features/transportation/presentation/transporation_Booking_view.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
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
  @override
  Size get preferredSize => const Size.fromHeight(80);

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
    final width = MediaQuery.of(context).size.width;
    final double tabletMobileWidth = 1600;
    return AppBar(
      backgroundColor: Color.fromARGB(255, 22, 14, 78),
      leading: width > 600 ? const SizedBox() : null,
      title: Row(
        children: [
          if (width > 1000) const SizedBox(width: 100),
          Image.asset("assets/images/logo2.png", width: 100),
          const SizedBox(width: 30),
          if (width > tabletMobileWidth)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  HoverMenuDestinationButton(),
                  SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),

                    child: CustomAppBarButton(
                      onPressed: () {
                        _scrollToSection(context, howBookKey);
                      },
                      txt: "How Book With Us",
                    ),
                  ),
                  SizedBox(width: 30),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: CustomAppBarButton(
                      onPressed: () {
                        _scrollToSection(context, offersKey);
                      },
                      txt: "Offers",
                    ),
                  ),
                  SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: CustomAppBarButton(
                      onPressed: () {
                        _scrollToSection(context, favKey);
                      },
                      txt: "Favorites",
                    ),
                  ),
                  SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: CustomAppBarButton(
                      onPressed: () {
                        context.go(AboutUsView.routeName);
                      },
                      txt: "About Us",
                    ),
                  ),
                  SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: CustomAppBarButton(
                      onPressed: () {
                        context.go(TransporationBookingView.routeName);
                      },
                      txt: "Transportation",
                    ),
                  ),
                  SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: CustomAppBarButton(
                      onPressed: () {
                        _launchUrl();
                      },
                      txt: "Travel Blog",
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
