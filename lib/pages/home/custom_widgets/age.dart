import 'package:bmi_calculator/pages/home/custom_widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class Age extends StatefulWidget {
  const Age({super.key});

  @override
  State<Age> createState() => _AgeState();
}

class _AgeState extends State<Age> {
  int age = 35;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(
          height: 13,
        ), //TODO: make dynamic responsive
        Text(
          'Age',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
            color: Theme.of(context).textTheme.bodyMedium!.color,
            fontWeight: FontWeight.normal,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedButton(
                key: const Key('age_minus'),
                iconData: Icons.remove,
                onPress: () {
                  setState(
                    () {
                      age >= 1 ? age-- : age = 0;
                    },
                  );
                },
              ),
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    age.toString(),
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                      color: const Color(0xFF3D4852),
                    ),
                  ),
                  Text(
                    'yrs',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                    ),
                  )
                ],
              ),
              RoundedButton(
                key: const Key('age_plus'),
                iconData: Icons.add,
                onPress: () {
                  setState(
                    () {
                      age < 100 ? age++ : age = 100;
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          width: 100, //TODO: make dynamic responsive
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFF4F7DF9),
                width: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
