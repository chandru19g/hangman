import 'package:flutter/material.dart';
import 'package:hangman/models/score_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ScoreService extends ChangeNotifier {
  dynamic _queryResult;

  dynamic get queryResult => _queryResult;

  Future<Database> openDB() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'scores_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE scores(id INTEGER PRIMARY KEY AUTOINCREMENT, scoreDate TEXT, userScore INTEGER)",
        );
      },
      version: 1,
    );
    return database;
  }

  Future<void> insertScore(Score score, final database) async {
    final Database db = await database;

    await db.insert(
      'scores',
      score.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<Score>> scores(final database) async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'scores',
      orderBy: 'userScore DESC',
    );

    return List.generate(maps.length, (i) {
      return Score(
        id: maps[i]['id'],
        scoreDate: maps[i]['scoreDate'],
        userScore: maps[i]['userScore'],
      );
    });
  }

  Future<void> updateScore(Score score, final database) async {
    final db = await database;

    await db.update(
      'scores',
      score.toMap(),
      where: "id = ?",
      whereArgs: [score.id],
    );
  }

  Future<void> deleteScore(int id, final database) async {
    final db = await database;

    await db.delete(
      'scores',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  void manipulateDatabase(Score scoreObject, final database) async {
    await insertScore(scoreObject, database);
  }
}
