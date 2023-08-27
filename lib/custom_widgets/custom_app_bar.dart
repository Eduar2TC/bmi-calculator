import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Text(
          'BMI Calculator',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
