import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Themes {
  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.deepOrange[300],
  );
}

const headerTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 58.0,
  fontWeight: FontWeight.w300,
  letterSpacing: 3.0,
);

const actionButtonColor = Colors.deepOrange;
const actionButtonOnColor = Colors.deepOrange;

const actionButtonTextStyle = TextStyle(
  fontSize: 25.0,
  color: Colors.white,
  fontWeight: FontWeight.w300,
  letterSpacing: 0.5,
);

const wordScoreStyle = TextStyle(
  fontSize: 29.5,
  color: Colors.white,
  fontWeight: FontWeight.w900,
);

const wordButtonColor = Colors.deepOrange;

const wordButtonTextStyle = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 27,
);

const wordTextStyle = TextStyle(
  fontSize: 57,
  color: Colors.white,
  fontFamily: 'FiraMono',
  letterSpacing: 8,
);

const dialogButtonColor = Color(0x00000000);

final gameOverAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  animationDuration: const Duration(milliseconds: 450),
  backgroundColor: const Color(0xFF2C1E68),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  titleStyle: const TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 30.0,
    letterSpacing: 1.5,
  ),
  descStyle: const TextStyle(
    color: Colors.lightBlue,
    fontWeight: FontWeight.bold,
    fontSize: 25.0,
    letterSpacing: 1.5,
  ),
);

final failedAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  animationDuration: const Duration(milliseconds: 450),
  backgroundColor: Colors.orangeAccent,
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  titleStyle: const TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 30.0,
    letterSpacing: 1.5,
  ),
);

final successAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  animationDuration: const Duration(milliseconds: 500),
  backgroundColor: Colors.deepOrange[900],
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  titleStyle: const TextStyle(
    color: Color(0xFF00e676),
    fontWeight: FontWeight.bold,
    fontSize: 30.0,
    letterSpacing: 1.5,
  ),
);

const highScoreTableHeaders = TextStyle(
  color: Colors.white,
  fontSize: 30.0,
  fontWeight: FontWeight.w300,
  letterSpacing: 1.0,
);

const highScoreTableRowsStyle = TextStyle(
  color: Colors.white,
  fontSize: 27.0,
  fontWeight: FontWeight.w300,
  letterSpacing: 1.0,
);
