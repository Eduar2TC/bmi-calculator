import 'package:bmi_calculator/helpers/image_animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Gender extends StatelessWidget {
  const Gender({super.key, this.isMan});
  final bool? isMan;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 3),
      curve: Curves.easeInOutCubic,
      builder: (context, value, child) => Stack(
        children: [
          Positioned.directional(
            textDirection: isMan! ? TextDirection.ltr : TextDirection.rtl,
            start: -60 * value,
            end: 60,
            top: 20,
            child: Opacity(
              opacity: value,
              child: ImageAnimator(
                key: Key(isMan! ? 'man' : 'woman'),
                child: SvgPicture.asset(
                  isMan! ? 'lib/assets/man012.svg' : 'lib/assets/woman012.svg',
                  width: 120,
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              width: double.infinity,
              child: Text(
                isMan! ? 'Male' : 'Female',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
