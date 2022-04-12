import 'package:flutter/material.dart';
import 'package:hangman/ui/themes.dart';

class MyButton extends StatelessWidget {
  final Function() onPress;
  final String buttonTitle;

  const MyButton({
    Key? key,
    required this.onPress,
    required this.buttonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        primary: actionButtonColor,
        onPrimary: actionButtonOnColor,
      ),
      onPressed: onPress,
      child: Text(
        buttonTitle,
        style: actionButtonTextStyle,
      ),
    );
  }
}
