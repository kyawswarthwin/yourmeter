import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:your_meter/model/meter.dart';

class DatabaseHelper {
  String tableName = 'MeterRecord';
  String id = 'id';
  String unit = 'unit';
  String totalAmount = 'totalAmount';
  String date = 'date';

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
    String path = directory.path + 'your-meter.db';
    var noteDatabase =
        await openDatabase(path, version: 1, onCreate: _createDB);
    return noteDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT, $unit INTEGER, $totalAmount INTEGER, $date TEXT)');
  }

  Future<List<Map<String, dynamic>>> getMeterMapList(String order) async {
    Database db = await this.database;
    var result = await db.query(tableName, orderBy: '$date $order');
    return result;
  }

  Future<List<Meter>> getMeterList(String order) async {
    var meterMapList = await getMeterMapList(order);
    int count = meterMapList.length;

    List<Meter> meterList = List<Meter>();

    for (int i = 0; i < count; i++) {
      Meter meter = Meter(
          id: meterMapList[i]['id'],
          unit: meterMapList[i]['unit'],
          totalAmount: meterMapList[i]['totalAmount'],
          date: meterMapList[i]['date']);
      meterList.add(meter);
    }
    return meterList;
  }

  Future<List<Map<String, dynamic>>> getLastMeterMapList(int limit) async {
    Database db = await this.database;
    var result = await db.query(
      tableName,
      limit: limit,
      orderBy: '$date DESC',
    );
    return result;
  }

  Future<List<Meter>> getLastMeterList(int limit) async {
    var meterMapList = await getLastMeterMapList(limit);
    int count = meterMapList.length;

    List<Meter> meterList = List<Meter>();

    for (int i = 0; i < count; i++) {
      Meter meter = Meter(
          id: meterMapList[i]['id'],
          unit: meterMapList[i]['unit'],
          totalAmount: meterMapList[i]['totalAmount'],
          date: meterMapList[i]['date']);
      meterList.add(meter);
    }
    return meterList;
  }

  Future<bool> hasData(String year, String month) async {
    Database db = await this.database;
    var result = await db.query(tableName,
        where:
            "strftime('%Y', $date)='$year' AND strftime('%m', $date)='$month'");
    return result.length > 0;
  }

  Future<int> insertMeter(Meter meter) async {
    Database db = await this.database;
    var result = await db.insert(tableName, meter.toMap());
    return result;
  }

  Future<int> deleteMeter(int meterId) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $tableName WHERE $id = $meterId');
    return result;
  }

  Future<int> deleteAllMeter() async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tableName');
    return result;
  }

  Future<int> updateMeter(Meter meter) async {
    var db = await this.database;
    var result = await db.update(tableName, meter.toMap(),
        where: '$id = ?', whereArgs: [meter.id]);
    return result;
  }
}
