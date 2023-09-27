import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, this.iconData, this.onPress});
  final IconData? iconData;
  final Function()? onPress; //Function to be called when button is pressed
  @override
  Widget build(BuildContext context) {
    //final keyValue = (key as ValueKey).value;
    return TextButton(
      onPressed: () {
        onPress!();
      },
      style: const ButtonStyle(
        minimumSize: MaterialStatePropertyAll(
          Size(
            25.0,
            25.0,
          ),
        ),
        iconColor: MaterialStatePropertyAll(
          Colors.black,
        ),
        shape: MaterialStatePropertyAll(
          CircleBorder(),
        ),
        alignment: Alignment.center,
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
        backgroundColor: MaterialStatePropertyAll(
          Colors.white,
        ),
        elevation: MaterialStatePropertyAll(
          2.0,
        ),
      ),
      child: Icon(
        iconData,
      ),
    );
  }
}
