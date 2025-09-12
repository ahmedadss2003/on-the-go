import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HowBookSection extends StatelessWidget {
  const HowBookSection({super.key, required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: const Color.fromARGB(255, 115, 29, 29)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AutoSizeText(
              "How to Book with us ?",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width < 700 ? 25 : 60),
              child: AutoSizeText(
                // maxLines: 3,
                textAlign: TextAlign.center,
                "The Booking With Us is very easy, There are Two Ways To Booking\n1-	On Whatsapp By Click On Contact Us Button Or Whatsapp Icon\n2-	By Filling The Booking Form (Exist in details of place) And Click On Book Now Button , Then contact With You \n",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
