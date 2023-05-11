import 'package:hello_flutter/data/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  static Future<void> _createTables(Database db) async {
    await db.execute("""
      CREATE TABLE ${User.tableName} (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
""");
  }

  static Future<Database> createDb() async {
    return openDatabase(join(await getDatabasesPath(), "user_database.db"),
        version: 1, onCreate: (Database database, int version) async {
      await _createTables(database);
    });
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await createDb();
    return await db.query(User.tableName, orderBy: "id");
  }

  static Future<int> createUser(User user) async {
    final db = await createDb();
    return await db.insert(User.tableName, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getUser(int id) async {
    final db = await createDb();
    return await db.query(User.tableName,
        where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateUser(User user) async {
    final db = await createDb();
    return await db.update(User.tableName, user.toMap(),
        where: "id = ?", whereArgs: [user.id]);
  }

  static Future<int> deleteUser(int id) async {
    final db = await createDb();
    return await db.delete(User.tableName, where: "id = ?", whereArgs: [id]);
  }
}
