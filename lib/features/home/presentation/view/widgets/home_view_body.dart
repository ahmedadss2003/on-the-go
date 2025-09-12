import 'package:flutter/material.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/custom_drawer.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/custom_home_appbar.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/home_content.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final GlobalKey _footerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: CustomAppBar(footerKey: _footerKey),
      ),
      endDrawer: width < 800 ? CustomDrawer(footerKey: _footerKey) : null,
      body: HomeContent(footerKey: _footerKey),
    );
  }
}
