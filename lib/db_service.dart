import 'dart:convert';

import 'package:flutter_app/debug.dart';
import 'package:flutter_app/models/model_base.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import 'models/person.dart';
// OnDatabaseOpenFn(
//
// )

/// This class is used to store app data in an
/// sqllite database
class DBService {
  DBService._privateConstructor();
  Database? database;

  DBService() {
    init();
  }

  static final DBService _instance = DBService._privateConstructor();
  static DBService get instance => _instance;

  /// add any tables you want to store in the database here
  init() async {
    database = await openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'app_database.db'),
        // When the database is first created, create a table to store dogs.
        onCreate: (db, version) async {
          // Run the CREATE TABLE statement on the database.
          await db.execute(
              "CREATE TABLE appstate (id INTEGER PRIMARY KEY, hasNotifications INTEGER);");

          await db.execute(
            'CREATE TABLE users(id INTEGER PRIMARY KEY, Role TEXT, data TEXT);',
          );
        },

        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 1,
        onOpen: (Database db) {
          Debug.log("Opened db");
        });
  }

  /// used to add rows to tables in the database
  Future<void> addToDb(ModelBase model, {bool clear = false}) async {
    if (database == null) {
      await init();
    }
    if (clear) {
      await deleteTableEntries(model.tableName());
    }
    await database!.insert(
      model.tableName(),
      model.toDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Person?> getUser() async {
    if (database == null) {
      await init();
    }
    final List<Map<String, dynamic>> maps =
        await database!.query("users", where: 'id = ?', whereArgs: [1]);
    // print(maps);
    if (maps.isEmpty) return null;
    var object = jsonDecode(maps.first["data"]);

    return Person.fromJson(object);
  }

  Future<bool> deleteTableEntries(String tableName) async {
    bool result = false;
    if (database == null) {
      await init();
    }
    Debug.log("Deleting all $tableName");
    var count = await database!.delete(tableName);
    result = count > 1;
    Debug.log("Deleted $count entries from $tableName");

    return result;
  }
}
