import 'package:morty_guessr/models/score.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ScoreDatabase {
  static final ScoreDatabase instance = ScoreDatabase._init();
  static Database? _database;

  ScoreDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('scores.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE scores(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      points INTEGER NOT NULL,
      date TEXT NOT NULL
    )
    ''');
  }

  Future<int> addScore(Score score) async {
    final db = await instance.database;
    final newScore = await db.insert('scores', score.toMap());

    //Zachowaj tylko top 5 wyników.
    await db.rawDelete('''
      DELETE FROM scores
      WHERE id NOT IN (
        SELECT id FROM scores
        ORDER BY points DESC
        LIMIT 5
      )
      ''');

    return newScore;
  }

  Future<List<Score>> fetchScores() async {
    final db = await instance.database;
    final result = await db.query(
      'scores',
      orderBy: 'points DESC',
    );
    return result.map((map) => Score.fromMap(map)).toList();
  }

  Future<void> clearScores() async {
    final db = await instance.database;
    await db.delete('scores');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
