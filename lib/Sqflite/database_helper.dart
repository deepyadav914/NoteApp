import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // create database and initialized that.
  static Future<Database> dbHelper() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'note.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Notes(id INTEGER  PRIMARY KEY AUTOINCREMENT , title TEXT, description TEXT)',
        );
      },
      version: 1,
    );

    return database;
  }
}
