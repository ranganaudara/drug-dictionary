//import 'dart:io';
//import 'package:path/path.dart';
//import 'dart:typed_data';
//import 'package:flutter/services.dart';


//class DBProvider{
//  DBProvider._();
//  static final DBProvider db = DBProvider._();
//
//  static Database _database;
//
//  Future<Database> get database async {
//
//    var databasesPath = await getDatabasesPath();
//    var path = join(databasesPath, "demo_asset_example.db");
//
//    if (_database != null)
//      return _database;
//
//    // if _database is null we instantiate it
//    _database = await initDB();
//    return _database;
//  }
//
//  initDB() async {
//    Directory documentsDirectory = await getApplicationDocumentsDirectory();
//    String path = join(documentsDirectory.path, "TestDB.db");
//    return await openDatabase(path, version: 1, onOpen: (db) {
//    }, onCreate: (Database db, int version) async {
//      await db.execute("CREATE TABLE Client ("
//          "id INTEGER PRIMARY KEY,"
//          "first_name TEXT,"
//          "last_name TEXT,"
//          "blocked BIT"
//          ")");
//    });
//  }
//}