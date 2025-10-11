import 'package:flutter/material.dart';
import 'package:on_the_go/core/widgets/up_arrow.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/custom_drawer.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/custom_home_appbar.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/home_content.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final GlobalKey footerKey = GlobalKey();
  final GlobalKey howBookKey = GlobalKey();
  final GlobalKey offersKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey favKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: CustomAppBar(
          footerKey: footerKey,
          howBookKey: howBookKey,
          offersKey: offersKey,
          aboutKey: aboutKey,
          favKey: favKey,
        ),
      ),
      endDrawer:
          width < 1600
              ? CustomDrawer(
                favKey: favKey,
                footerKey: footerKey,
                howBookKey: howBookKey,
                offersKey: offersKey,
                aboutKey: aboutKey,
              )
              : null,
      body: Stack(
        children: [
          SelectableRegion(
            focusNode: FocusNode(),
            selectionControls: MaterialTextSelectionControls(),
            child: HomeContent(
              favKey: favKey,
              footerKey: footerKey,
              howBookKey: howBookKey,
              offersKey: offersKey,
              aboutKey: aboutKey,
            ),
          ),
          const UpArrow(),
        ],
      ),
    );
  }
}
