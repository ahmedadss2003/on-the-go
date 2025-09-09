import 'package:flutter/material.dart';
import 'package:on_the_go/features/home/presentation/view/home_view.dart';

class UpArrow extends StatefulWidget {
  const UpArrow({super.key});

  @override
  State<UpArrow> createState() => _UpArrowState();
}

class _UpArrowState extends State<UpArrow> {
  bool isHover = false;

  void scrollToTop() {
    HomeView.globalScrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: GestureDetector(
          onTap: scrollToTop,
          child: AnimatedScale(
            scale: isHover ? 1.05 : 1,
            duration: const Duration(milliseconds: 250),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[700]!, Colors.blue[300]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow:
                    isHover
                        ? [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          ),
                        ]
                        : [],
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(
                Icons.arrow_upward,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
