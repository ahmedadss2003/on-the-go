import 'package:flutter/material.dart';

class CustomBookingContainer extends StatelessWidget {
  const CustomBookingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 101, 119, 133),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Transportation Booking",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Text(
            "Let's Book To Enjoy With Comfort & Style ",
            style: TextStyle(
              fontSize: 12,
              color: const Color.fromARGB(255, 199, 199, 199),
            ),
          ),
        ],
      ),
    );
  }
}
