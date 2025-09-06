import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HowPaySection extends StatelessWidget {
  const HowPaySection({super.key, required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 236, 236),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "How to Pay ?",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: Color(0xff1a73e8),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width < 700 ? 25 : 60),
              child: AutoSizeText(
                // maxLines: 3,
                textAlign: TextAlign.center,
                "We give you 3 options for payment then you can choose the best for you : \n1-	Book now and pay full amount by card to save your time and money while you are in your holiday in Sharm.\n2-	Book now and pay only 25% deposit by card and pay the balance in cash while you are in Sharm before your trips.\n 3-	Book now and pay the full amount in cash while you are in Sharm before your trips.",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff1a73e8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
