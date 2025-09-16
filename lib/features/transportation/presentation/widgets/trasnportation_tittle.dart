import 'package:flutter/material.dart';

class TransportationTittle extends StatelessWidget {
  const TransportationTittle({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        "Transportation Services",
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w900,
          fontFamily: "Poppins",
        ),
      ),
    );
  }
}
