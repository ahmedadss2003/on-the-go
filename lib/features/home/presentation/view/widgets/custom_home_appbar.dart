import 'package:flutter/material.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/contact_us_button.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/destionation_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double tabletMobileWidth = 1041;
    return AppBar(
      backgroundColor: Color.fromARGB(255, 22, 14, 78),
      leading: width > 1000 ? const SizedBox() : null,
      title: Row(
        children: [
          if (width > 1000) const SizedBox(width: 100),
          Image.asset("assets/images/logo.png", width: 100),
          const SizedBox(width: 30),
          if (width > tabletMobileWidth)
            Row(
              children: List.generate(
                4,
                (_) => const Padding(
                  padding: EdgeInsets.only(right: 30, top: 15),
                  child: HoverMenuDestinationButton(),
                ),
              ),
            ),
          Spacer(),
          width > tabletMobileWidth
              ? CustomContactButton(onPressed: () {})
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
}
