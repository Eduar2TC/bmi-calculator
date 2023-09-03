import 'package:bmi_calculator/custom_widgets/custom_app_bar.dart';
import 'package:bmi_calculator/pages/home/custom_widgets/box.dart';
import 'package:bmi_calculator/pages/home/custom_widgets/gender.dart';
import 'package:bmi_calculator/pages/home/custom_widgets/height_card.dart';
import 'package:bmi_calculator/pages/home/custom_widgets/weight.dart';
import 'package:flutter/material.dart';

import '../../helpers/sizes_helpers.dart';

//Button Colors
const activeButtonColor = Color(0xFF4F7DF9);
const activeTextColor = Colors.white;

enum GenderOption { male, female }

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool maleSelected = false;
  bool femaleSelected = false;

  void genderSelected(GenderOption genderSelected) {
    femaleSelected = genderSelected == GenderOption.male ? false : true;
    maleSelected = genderSelected == GenderOption.female ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    displayHeight(context);
    displayWidth(context);
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const CustomAppBar(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 3000,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Box(
                      onPress: () {
                        setState(() {
                          genderSelected(GenderOption.male);
                        });
                      },
                      isSelected: maleSelected,
                      internalWidget: const Gender(
                        isMan: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Box(
                      onPress: () {
                        setState(() {
                          genderSelected(GenderOption.female);
                        });
                      },
                      isSelected: femaleSelected,
                      internalWidget: const Gender(
                        isMan: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 5500,
              child: Box(
                internalWidget: HeightCard(),
              ),
            ),
            const Expanded(
              flex: 4000,
              child: Row(
                children: [
                  Expanded(
                    child: Box(
                      internalWidget: Weight(),
                    ),
                  ),
                  Expanded(
                    child: Box(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2000,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: activeButtonColor,
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Calculate BMI',
                        style: TextStyle(
                          color: activeTextColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
