import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hangman/models/score_model.dart';
import 'package:hangman/routes/routes.dart';
import 'package:hangman/services/alphabet.dart';
import 'package:hangman/services/score_service.dart';
import 'package:hangman/ui/themes.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WordsService extends ChangeNotifier {
  int _wordCounter = 0;
  List<int> _usedNumbers = [];
  List<String> _words = [];
  Random? _rand;
  int _wordLength = 0;
  int _randNumber = 0;
  bool _notUnique = true;
  String _hiddenWord = "";
  String _word = "";
  Alphabet englishAlphabet = Alphabet();
  int _lives = 5;
  List<String> _wordList = [];
  List<int> _hintLetters = [];
  List<bool> _buttonStatus = [];
  bool _hintStatus = false;
  int _hangState = 0;
  int _wordCount = 0;
  bool _finishedGame = false;
  bool _resetGame = false;
  int _attempts = 0;
  final databaseHelper = ScoreService().openDB();

  int get lives => _lives;

  int get attempts => _attempts;

  List<String> get wordList => _wordList;

  List<int> get hintLetters => _hintLetters;

  List<bool> get buttonStatus => _buttonStatus;

  bool get hintStatus => _hintStatus;

  int get hangState => _hangState;

  int get wordCount => _wordCount;

  bool get finished => _finishedGame;

  bool get resetGame => _resetGame;

  String get word => _word;

  int get wordLength => _wordLength;

  int get randNumber => _randNumber;

  bool get notUnique => _notUnique;

  String get hiddenWord => _hiddenWord;

  int get wordCounter => _wordCounter;

  List<int> get usedNumbers => _usedNumbers;

  List<String> get words => _words;

  Future<void> readWords() async {
    String fileText =
        await rootBundle.loadString('assets/res/hangman_words.txt');
    _words = fileText.split("\n");

    notifyListeners();
  }

  void resetWords() {
    _wordCounter = 0;
    _usedNumbers = [];
    englishAlphabet = Alphabet();
    _lives = 5;
    _wordCount = 0;
    _finishedGame = false;
    _resetGame = false;
    _attempts = 0;

    notifyListeners();
  }

  String getWord() {
    _wordCounter++;

    _rand = Random();

    _wordLength = _words.length;
    _randNumber = _rand!.nextInt(_wordLength);
    _notUnique = true;
    if (_wordCounter - 1 == _words.length) {
      _notUnique = false;
    }
    while (_notUnique) {
      if (!_usedNumbers.contains(_randNumber)) {
        _notUnique = false;
        _usedNumbers.add(_randNumber);
        _word = _words[_randNumber];
      } else {
        _randNumber = _rand!.nextInt(_wordLength);
      }
    }
    return _word;
  }

  void getHiddenWord() {
    _hiddenWord = "";
    for (int i = 0; i < _word.length; i++) {
      _hiddenWord += '_';
    }
  }

  void initWords() {
    _finishedGame = false;
    _resetGame = false;
    _hintStatus = true;
    _hangState = 0;
    _attempts = 0;
    _buttonStatus = List.generate(26, (index) {
      return true;
    });
    _wordList = [];
    _hintLetters = [];

    _word = getWord();

    if (_word.isNotEmpty) {
      getHiddenWord();
      _hiddenWord = _hiddenWord;
    }

    for (int i = 0; i < _word.length; i++) {
      _wordList.add(_word[i]);
      _hintLetters.add(i);
    }

    // notifyListeners();
  }

  returnHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, RouteManager.homeScreen);
  }

  void wordPress(int index, BuildContext context) {
    if (_lives == 0) {
      returnHomePage(context);
    }

    if (_finishedGame) {
      _resetGame = true;
      resetWords();
      return;
    }

    bool _check = false;

    for (int i = 0; i < _wordList.length; i++) {
      if (_wordList[i] == englishAlphabet.alphabet[index]) {
        _check = true;
        _wordList[i] = '';
        _hiddenWord = _hiddenWord.replaceFirst(RegExp('_'), _word[i], i);
      }
    }

    for (int i = 0; i < _wordList.length; i++) {
      if (_wordList[i] == '') {
        _hintLetters.remove(i);
      }
    }
    if (!_check) {
      _hangState++;
    }

    if (_hangState == 6) {
      _lives--;
      if (_lives < 1) {
        if (_wordCount > 0) {
          Score score = Score(
              id: 1,
              scoreDate: DateTime.now().toString(),
              userScore: _wordCount);
          ScoreService().manipulateDatabase(score, databaseHelper);
        }
        Alert(
            style: gameOverAlertStyle,
            context: context,
            title: "Game Over!",
            desc: "Your score is $wordCount",
            buttons: [
              DialogButton(
//                  width: 20,
                onPressed: () {
                  resetWords();
                  returnHomePage(context);
                },
                child: const Icon(
                  Icons.home,
                  size: 30.0,
                ),
                color: dialogButtonColor,
              ),
              DialogButton(
//                  width: 20,
                onPressed: () {
                  resetWords();
                  initWords();
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.refresh,
                  size: 30.0,
                ),
                color: dialogButtonColor,
              ),
            ]).show();
      } else {
        _finishedGame = true;
        Alert(
          context: context,
          style: failedAlertStyle,
          type: AlertType.error,
          title: word,
//            desc: "You Lost!",
          buttons: [
            DialogButton(
              radius: BorderRadius.circular(10),
              child: const Icon(
                Icons.arrow_back,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              width: 127,
              color: dialogButtonColor,
              height: 52,
            ),
          ],
        ).show();
      }
    }

    _buttonStatus[index] = false;
    if (_hiddenWord == _word) {
      _wordCount++;
      Alert(
        context: context,
        style: successAlertStyle,
        type: AlertType.success,
        title: word,
//          desc: "You guessed it right!",
        buttons: [
          DialogButton(
            radius: BorderRadius.circular(10),
            child: const Icon(
              Icons.arrow_back,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            width: 127,
            color: dialogButtonColor,
            height: 52,
          )
        ],
      ).show();
      initWords();
    }

    notifyListeners();
  }

  void hintText(BuildContext context) {
    int rand = Random().nextInt(_hintLetters.length);
    wordPress(
      englishAlphabet.alphabet.indexOf(_wordList[_hintLetters[rand]]),
      context,
    );
    _hintStatus = false;
    if (_word.length > 5) {
      _attempts++;
    } else {
      _attempts = 2;
    }
  }
}
