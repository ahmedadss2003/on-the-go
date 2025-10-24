import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_the_go/features/about_us/presentation/pages/about_us_view.dart';
import 'package:on_the_go/features/contact_us/presentation/pages/contact_us.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/contact_us_button.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/destionation_button.dart';
import 'package:on_the_go/features/transportation/presentation/transporation_Booking_view.dart';
import 'package:on_the_go/features/why_choose_us/presentation/why_choose_us.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,

    required this.howBookKey,
    required this.offersKey,

    required this.favKey,
  });

  final GlobalKey howBookKey;
  final GlobalKey offersKey;
  final GlobalKey favKey;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  void _scrollToSection(BuildContext context, GlobalKey sectionKey) {
    if (sectionKey.currentContext != null) {
      Scrollable.ensureVisible(
        sectionKey.currentContext!,
        alignment: 0.0,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: const Color.fromARGB(255, 22, 14, 78),
      leading: width > 600 ? const SizedBox() : null,
      title: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;

          return Row(
            children: [
              Image.asset("assets/images/logo2.png", width: 100),
              const SizedBox(width: 20),
              if (width > 1200)
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HoverMenuDestinationButton(),
                        const SizedBox(width: 20),
                        CustomAppBarButton(
                          onPressed:
                              () => _scrollToSection(context, howBookKey),
                          txt: "How Book With Us",
                        ),
                        const SizedBox(width: 20),
                        CustomAppBarButton(
                          onPressed: () => _scrollToSection(context, offersKey),
                          txt: "Offers",
                        ),
                        const SizedBox(width: 20),
                        CustomAppBarButton(
                          onPressed: () => _scrollToSection(context, favKey),
                          txt: "Favorites",
                        ),
                        const SizedBox(width: 20),
                        CustomAppBarButton(
                          onPressed: () => context.go(AboutUsView.routeName),
                          txt: "About Us",
                        ),
                        const SizedBox(width: 20),
                        CustomAppBarButton(
                          onPressed:
                              () => context.go(WhyChooseUsView.routeName),
                          txt: "Why Choose Us",
                        ),
                        const SizedBox(width: 20),
                        CustomAppBarButton(
                          onPressed:
                              () => context.go(
                                TransporationBookingView.routeName,
                              ),
                          txt: "Transportation",
                        ),
                        const SizedBox(width: 20),
                        CustomAppBarButton(
                          onPressed: _launchUrl,
                          txt: "Travel Blog",
                        ),
                        const SizedBox(width: 20),
                        CustomAppBarButton(
                          onPressed: () {
                            context.go(ContactUsView.routeName);
                          },
                          txt: "Contact Us",
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      actions: [
        if (width < 1200)
          IconButton(
            padding: const EdgeInsets.only(right: 20, top: 15),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
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
    final Uri url = Uri.parse("https://onthegoexcursions.medium.com/");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint("Could not launch URL");
    }
  }
}
