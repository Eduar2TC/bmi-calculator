import 'package:bmi_calculator/custom_widgets/custom_app_bar.dart';
import 'package:bmi_calculator/pages/home/custom_widgets/box.dart';
import 'package:bmi_calculator/pages/home/custom_widgets/gender.dart';
import 'package:bmi_calculator/pages/home/custom_widgets/height_card.dart';
import 'package:flutter/material.dart';

//Button Colors
const activeButtonColor = Color(0xFF4F7DF9);
const activeTextColor = Colors.white;

enum Gender { male, female }

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool maleSelected = false;
  bool femaleSelected = false;

  void genderSelected(Gender genderSelected) {
    femaleSelected = genderSelected == Gender.male ? false : true;
    maleSelected = genderSelected == Gender.female ? false : true;
  }

  @override
  Widget build(BuildContext context) {
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
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          genderSelected(Gender.male);
                        });
                      },
                      child: Box(
                        isGenderContainer: maleSelected,
                        internalWidget: const gender(
                          isMan: true,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          genderSelected(Gender.female);
                        });
                      },
                      child: Box(
                        isGenderContainer: femaleSelected,
                        internalWidget: const gender(
                          isMan: false,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 5500,
              child: Box(
                isGenderContainer: false,
                internalWidget: HeightCard(),
              ),
            ),
            Expanded(
              flex: 4000,
              child: Row(
                children: const [
                  Expanded(
                    child: Box(isGenderContainer: false),
                  ),
                  Expanded(
                    child: Box(isGenderContainer: false),
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
