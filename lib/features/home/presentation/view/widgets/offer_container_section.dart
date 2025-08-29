import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OfferContainerSection extends StatelessWidget {
  const OfferContainerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(color: Color.fromRGBO(223, 56, 56, 1)),
      child: Center(
        child: AutoSizeText(
          maxLines: 3,
          "Global Getaways 2025: Up To 50% Off – Limited Availability, Book Today!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
