import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, this.iconData, this.onPress});
  final IconData? iconData;
  final Function()? onPress; //Function to be called when button is pressed
  @override
  Widget build(BuildContext context) {
    //final keyValue = (key as ValueKey).value;
    double width = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: () {
        onPress!();
      },
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll(
          Colors.blue.withOpacity(0.2),
        ),
        animationDuration: const Duration(
          milliseconds: 5000,
        ),
        minimumSize: MaterialStatePropertyAll(
          Size(
            width * 0.1,
            width * 0.1,
          ),
        ),
        maximumSize: MaterialStatePropertyAll(
          Size(
            width * 0.15,
            width * 0.15,
          ),
        ),
        iconColor: const MaterialStatePropertyAll(
          Colors.black,
        ),
        shape: const MaterialStatePropertyAll(
          CircleBorder(),
        ),
        alignment: Alignment.center,
        padding: const MaterialStatePropertyAll(EdgeInsets.zero),
        backgroundColor: const MaterialStatePropertyAll(
          Colors.white,
        ),
        elevation: const MaterialStatePropertyAll(
          2.0,
        ),
      ),
      child: Icon(
        iconData,
      ),
    );
  }
}
