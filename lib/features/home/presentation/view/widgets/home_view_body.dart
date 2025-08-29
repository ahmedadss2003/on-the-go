import 'package:flutter/material.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/custom_drawer.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/custom_home_appbar.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/home_content.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppBar(),
        ),
        endDrawer: width < 800 ? const CustomDrawer() : null,
        body: HomeContent(),
      ),
    );
  }
}
