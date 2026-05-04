import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final class DatabaseHelper {
  // シングルトンインスタンス
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  static Future<Database> init() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'stamp_rally.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE events (
        id INTEGER PRIMARY KEY,
        code TEXT,
        is_joined INTEGER,
        is_completed INTEGER
      );
    ''');

    await db.execute('''
      CREATE TABLE stamps (
        id INTEGER PRIMARY KEY,
        event_code TEXT,
        place_id TEXT,
        is_stamped INTEGER,
        stamped_date_list TEXT,
        FOREIGN KEY (event_code) REFERENCES events(code)
      );
    ''');
  }

  // 任意：データベースを閉じる処理
  static Future<void> close() async {
    if (_database == null) return;
    final db = _database;
    await db!.close();
    _database = null;
  }
}
