import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hangman/routes/routes.dart';
import 'package:hangman/services/words_service.dart';
import 'package:hangman/ui/themes.dart';
import 'package:hangman/ui/widgets/my_button.dart';
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkVersion();
  }

  Future<void> _checkVersion() async {
    final newVersion = NewVersion(
      androidId: "com.chandru.hangman",
    );

    final status = await newVersion.getVersionStatus();

    if (status!.canUpdate) {
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: "UPDATE",
        dismissButtonText: "close",
        dialogText:
            "A new version of the App is available in play store.\nDownload Now",
        dismissAction: () {
          SystemNavigator.pop();
        },
        updateButtonText: "Update",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    context.read<WordsService>().readWords();
    return Scaffold(
      body: SafeArea(
        child: Consumer<WordsService>(
          builder: (context, value, child) {
            return Column(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 1.0),
                    child: const Text("HANGMAN", style: headerTextStyle),
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/images/gallow.png",
                    height: height * 0.49,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 64.0,
                          child: MyButton(
                            buttonTitle: "Start",
                            onPress: value.words.isNotEmpty
                                ? () => Navigator.pushNamed(
                                    context, RouteManager.gameScreen)
                                : () {},
                          ),
                        ),
                        const SizedBox(
                          height: 18.0,
                        ),
                        SizedBox(
                          height: 64.0,
                          child: MyButton(
                            buttonTitle: "High Scores",
                            onPress: () => Navigator.pushNamed(
                                context, RouteManager.loadScreen),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
