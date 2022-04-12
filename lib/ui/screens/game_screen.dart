import 'package:flutter/material.dart';
import 'package:hangman/services/words_service.dart';
import 'package:hangman/ui/themes.dart';
import 'package:hangman/ui/widgets/word_button.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<WordsService>().initWords();

    return Scaffold(
      body: SafeArea(
        child: Consumer<WordsService>(
          builder: (context, value, child) {
            return Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6.0, 8.0, 6.0, 35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 0.5),
                                  child: IconButton(
                                    onPressed: () {},
                                    iconSize: 39,
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    icon: const Icon(Icons.favorite),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.7, 7.9, 0, 0.8),
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 38.0,
                                    width: 38.0,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          value.lives == 1
                                              ? "I"
                                              : value.lives.toString(),
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              value.wordCount == 1 ? "I" : '${value.wordCount}',
                              style: wordScoreStyle,
                            ),
                            IconButton(
                              onPressed: value.hintStatus || value.attempts < 2
                                  ? () {
                                      value.hintText(context);
                                    }
                                  : null,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              iconSize: 35.0,
                              icon: const Icon(
                                Icons.lightbulb,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: FittedBox(
                            child: Image.asset(
                              "assets/images/${value.hangState}.png",
                              height: 1001,
                              width: 991,
                              gaplessPlayback: true,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 35.0),
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              value.hiddenWord.toUpperCase(),
                              style: wordTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10.0, 2.0, 8.0, 10.0),
                  child: Table(
                    defaultVerticalAlignment:
                        TableCellVerticalAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: _createButton(0),
                          ),
                          TableCell(
                            child: _createButton(1),
                          ),
                          TableCell(
                            child: _createButton(2),
                          ),
                          TableCell(
                            child: _createButton(3),
                          ),
                          TableCell(
                            child: _createButton(4),
                          ),
                          TableCell(
                            child: _createButton(5),
                          ),
                          TableCell(
                            child: _createButton(6),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: _createButton(7),
                          ),
                          TableCell(
                            child: _createButton(8),
                          ),
                          TableCell(
                            child: _createButton(9),
                          ),
                          TableCell(
                            child: _createButton(10),
                          ),
                          TableCell(
                            child: _createButton(11),
                          ),
                          TableCell(
                            child: _createButton(12),
                          ),
                          TableCell(
                            child: _createButton(13),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: _createButton(14),
                          ),
                          TableCell(
                            child: _createButton(15),
                          ),
                          TableCell(
                            child: _createButton(16),
                          ),
                          TableCell(
                            child: _createButton(17),
                          ),
                          TableCell(
                            child: _createButton(18),
                          ),
                          TableCell(
                            child: _createButton(19),
                          ),
                          TableCell(
                            child: _createButton(20),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: _createButton(21),
                          ),
                          TableCell(
                            child: _createButton(22),
                          ),
                          TableCell(
                            child: _createButton(23),
                          ),
                          TableCell(
                            child: _createButton(24),
                          ),
                          TableCell(
                            child: _createButton(25),
                          ),
                          const TableCell(
                            child: Text(''),
                          ),
                          const TableCell(
                            child: Text(''),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _createButton(index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 6.0),
      child: Center(
        child: WordButton(
          onPress: context.read<WordsService>().buttonStatus[index]
              ? () {
                  context.read<WordsService>().wordPress(index, context);
                  if (context.read<WordsService>().finished) {
                    context.read<WordsService>().initWords();
                  }
                }
              : null,
          buttonTitle: context
              .read<WordsService>()
              .englishAlphabet
              .alphabet[index]
              .toUpperCase(),
          buttonStatus: context.read<WordsService>().buttonStatus[index],
        ),
      ),
    );
  }
}
