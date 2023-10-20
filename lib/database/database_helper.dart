import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/user_model.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'users.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        desc TEXT
      )
    ''');
  }

  Future<int> insertUser(UserModel user) async {
    Database? db = await database;
    return await db!.insert('users', user.toMap());
  }

  Future<List<UserModel>> getUsers() async {
    Database? db = await database;
    List<Map<String, dynamic>> maps = await db!.query('users');
    return List.generate(maps.length, (i) {
      return UserModel.fromMap(maps[i]);
    });
  }

  Future<int> updateUser(UserModel user) async {
    Database? db = await database;
    return await db!.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    Database? db = await database;
    return await db!.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
