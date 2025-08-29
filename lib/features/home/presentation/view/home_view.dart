import 'package:flutter/material.dart';
import 'package:on_the_go/features/home/presentation/view/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return HomeViewBody();
  }
}
