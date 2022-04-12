import 'package:flutter/material.dart';
import 'package:hangman/routes/routes.dart';
import 'package:hangman/services/words_service.dart';
import 'package:hangman/ui/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => WordsService(),
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hangman',
            theme: Themes.dark.copyWith(
              textTheme:
                  Theme.of(context).textTheme.apply(fontFamily: 'PatrickHand'),
            ),
            initialRoute: RouteManager.splashScreen,
            onGenerateRoute: RouteManager.generateRoute,
          );
        });
  }
}
