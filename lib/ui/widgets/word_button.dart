import 'package:flutter/material.dart';
import 'package:hangman/ui/themes.dart';

class WordButton extends StatelessWidget {
  final Function()? onPress;
  final String buttonTitle;
  final bool buttonStatus;

  const WordButton({
    Key? key,
    required this.onPress,
    required this.buttonTitle,
    required this.buttonStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(
        buttonTitle,
        style: wordButtonTextStyle,
        textAlign: TextAlign.center,
      ),
      style: ElevatedButton.styleFrom(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(4.0),
        primary: buttonStatus ? wordButtonColor : Colors.black,
      ),
    );
  }
}
