import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

abstract class IModel {
  String id;

  Map<String, dynamic> toMap();
}

class DatabaseHelper {
  String dbName = "database.db";
  Map<String, String> tables = {
    "table1": "QUERY",
    "table2": "QUERY",
    "table3": "QUERY",
  };

  static DatabaseHelper databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (databaseHelper == null) {
      databaseHelper = DatabaseHelper._createInstance();
    }
    return databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + dbName;

    var noteDatabase =
        await openDatabase(path, version: 1, onCreate: _createTable);
    return noteDatabase;
  }

  void _createTable(Database db, int newVersion) async {
    tables.forEach((String key, String value) async {
      await db.execute(value);
    });
  }

  Future<List<Map<String, dynamic>>> getMapList(String tableName) async {
    Database db = await this.database;
    var result = await db.query(tableName);
    return result;
  }

  Future<int> insert(String tableName, IModel model) async {
    Database db = await this.database;
    var result = await db.insert(tableName, model.toMap());
    return result;
  }

  Future<int> update(String tableName, IModel model) async {
    var db = await this.database;
    var result = await db.update(tableName, model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
    return result;
  }

  Future<int> delete(String tableName, int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tableName WHERE $id = $id');
    return result;
  }

  Future<int> deleteAll(String tableName) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tableName');
    return result;
  }

//  Future<List<Meter>> getMeterList() async {
//    var meterMapList = await getMeterMapList();
//    int count = meterMapList.length;
//
//    List<Meter> meterList = List<Meter>();
//
//    for (int i = 0; i < count; i++) {
//      Meter meter = Meter(
//          id: meterMapList[i]['id'],
//          unit: meterMapList[i]['unit'],
//          totalAmount: meterMapList[i]['totalAmount'],
//          date: meterMapList[i]['date']);
//      meterList.add(meter);
//    }
//    return meterList;
//  }

}
