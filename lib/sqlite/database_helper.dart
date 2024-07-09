import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer';

class ChatDB {
  static Database? _database;
  final String databaseName = 'db1';
  final String chatTableName = 'chat1';
  final String userTableName = 'user1';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    _database = await openDatabase(
      join(databasePath, databaseName),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $userTableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            phone TEXT
          );
        ''');
        await db.execute('''
          CREATE TABLE $chatTableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sender TEXT,
            receiver TEXT,
            text TEXT
          );
        ''');
      },
      version: 1,
    );
    log(databasePath);
    log(databaseName);
    return database;
  }

  Future<int> insertChat(Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert(chatTableName, row);
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    await deleteAllUsers();
    final db = await database;
    return await db.insert(userTableName, row);
  }

  Future<int> deleteAllChats() async {
    final db = await database;
    return await db.delete(chatTableName);
  }

  Future<int> deleteAllUsers() async {
    final db = await database;
    return await db.delete(userTableName);
  }

  Future<List<Map<String, dynamic>>> findAllChats() async {
    final db = await database;
    return await db.query(chatTableName);
  }

  Future<List<Map<String, dynamic>>> findUser() async {
    final db = await database;
    return await db.query(userTableName);
  }

  Future<List<Map<String, dynamic>>> findChatByID(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      chatTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps;
  }

  Future<List<Map<String, dynamic>>> findChatBySender(String sender) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      chatTableName,
      where: 'sender = ?',
      whereArgs: [sender],
    );
    return maps;
  }

  Future<List<Map<String, dynamic>>> findChatByReceiver(String receiver) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      chatTableName,
      where: 'receiver = ?',
      whereArgs: [receiver],
    );
    return maps;
  }

  Future<int> updateUserTable(Map<String, dynamic> row) async {
    final db = await database;
    return await db.update(
      userTableName,
      row,
      where: 'id = ?',
      whereArgs: [row['id']],
    );
  }

  Future<int> deleteUserByID(int id) async {
    final db = await database;
    return await db.delete(
      chatTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
