import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Gender extends StatelessWidget {
  const Gender({super.key, this.isMan});
  final bool? isMan;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.directional(
          textDirection: isMan! ? TextDirection.ltr : TextDirection.rtl,
          start: -30,
          end: 60,
          top: 20,
          child: SvgPicture.asset(
            isMan! ? 'lib/assets/man012.svg' : 'lib/assets/woman012.svg',
            width: 120,
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
    );
  }
}
