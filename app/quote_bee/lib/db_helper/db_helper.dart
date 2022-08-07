import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class DBHelper {
  static const quotes = "quotes";

  static void initDb() async {
    // initalize  --- read and make a copy of asset db to local db
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "quotes.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets/db/", "quotes.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    }
  }

  // open database
  static Future<Database> database() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, "quotes.db");

    return await openDatabase(path);
  }

  // display inserted data
  static Future<List<Map<String, dynamic>>> selectAll() async {
    final db = await DBHelper.database();

    return db.rawQuery("SELECT * FROM quotes LIMIT 500");
  }

  static Future insertFav(String table, Map<String, int> data) async {
    final db = await DBHelper.database();

    var favStatus =
        await db.rawQuery('SELECT * FROM quotes WHERE id ?', [data['id']]);

    print(favStatus);
    // todo
    // ? first get done with the ui for home*
    // ? *card - buttons on bottom right - share, mark favorite
    // ? then start debugging this
    // if(int.parse(favStatus) == 0){
    // db.rawUpdate('UPDATE quotes SET favourite = ? WHERE id = ?', [1, data['id']]);
  }

  // without query insert
  // return db.insert(table, data);

}
