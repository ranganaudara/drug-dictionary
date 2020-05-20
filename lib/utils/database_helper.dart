import 'dart:io';

import 'package:drug_dictionary/src/models/drug_model.dart';
import 'package:drug_dictionary/src/models/history_item_model.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  var database;
  static final DatabaseHelper _databaseHelper = DatabaseHelper._internal();

  factory DatabaseHelper() => _databaseHelper;

  DatabaseHelper._internal() {
    this.database = loadDatabase();
  }

  Future<Database> loadDatabase() async {
    var dbInstance;
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "demo_asset_example.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "drug_database.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    // open the database
    dbInstance = await openDatabase(path, readOnly: false);

    return dbInstance;
  }

  //Get all drugs
  Future<List<Drug>> getAllDrugs() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('tbl_drugs');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Drug.fromMap(maps[i]);
    });
  }

  //update history
  addHistoryItem(String name) async {
    final db = await database;
    var res;
    var isAvailable = await db.rawQuery(
        "SELECT count(*) as isAvailable FROM tbl_history WHERE name = '$name'");

    if (isAvailable.first["isAvailable"] < 1) {
      var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM tbl_history");

      int id = table.first["id"];

      res = await db.rawInsert(
          "INSERT Into tbl_history (id,name)"
          " VALUES (?,?)",
          [id, name]);
    } else {
      print("Already available in history!");
    }
    print(res.toString());
    return res;
  }

  updateFavourites(String name) async {
    final db = await database;
    var boolRes = await checkFavourite(name);
    if (boolRes) {
      return await db
          .rawUpdate("UPDATE tbl_drugs SET favourite = 0 WHERE name = '$name'");
    } else {
      return await db
          .rawUpdate("UPDATE tbl_drugs SET favourite = 1 WHERE name = '$name'");
    }
  }

  checkFavourite(String name) async {
    final db = await database;
    var result = await db.rawQuery("SELECT * FROM tbl_drugs WHERE name = '$name'");
    Drug d = Drug.fromMap(result.first);
    if(d.favourite > 0){
      return true;
    } else {
      return false;
    }
  }

  Future<List<Drug>> getFavouritesList() async {

    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('tbl_drugs', where: 'favourite = 1');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Drug.fromMap(maps[i]);
    });
  }

  Future<List<Drug>> getHistoryDrugs() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('tbl_history');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Drug.fromMap(maps[i]);
    });
  }

  Future<Drug> getDrugDetails(String name) async {
    final db = await database;
    var result = await db.rawQuery("SELECT * FROM tbl_drugs WHERE name = '$name'");
    Drug d = Drug.fromMap(result.first);

    return d;
  }
}
