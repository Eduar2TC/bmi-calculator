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
        child: TweenAnimationBuilder(
          duration: const Duration(seconds: 2),
          tween: Tween(begin: 0.0, end: 1),
          curve: Curves.easeOutBack,
          builder: (context, value, _) => Transform.translate(
            offset: Offset((-400 + value.toDouble() * 400), 0),
            child: Text(
              'BMI Calculator',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ),
    );
  }
}
