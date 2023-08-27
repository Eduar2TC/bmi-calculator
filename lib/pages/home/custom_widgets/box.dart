import 'package:bmi_calculator/pages/home/custom_widgets/constants/colours.dart';
import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  const Box({
    super.key,
    this.internalWidget,
    this.isGenderContainer,
  });

  final Widget? internalWidget;

  final bool? isGenderContainer;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: double.infinity,
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: activeBoxColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isGenderContainer!
              ? activeBoxBorderColor
              : inactiveBoxBorderColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: boxShadowColor,
            offset: const Offset(-6, 8),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: internalWidget,
    );
  }
}
