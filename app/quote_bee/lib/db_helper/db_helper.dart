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

  static Future<List<Map<String, dynamic>>> selectRandom() async {
    final db = await DBHelper.database();

    return db.rawQuery("SELECT * from quotes ORDER BY RANDOM() LIMIT 20");
  }

  // display most liked data
  static Future<List<Map<String, dynamic>>> selectMostLiked() async {
    final db = await DBHelper.database();

    return db
        .rawQuery('SELECT * FROM quotes ORDER BY "Like Count" DESC LIMIT 50');
  }

  // display most retweeted data
  static Future<List<Map<String, dynamic>>> selectMostRetweeted() async {
    final db = await DBHelper.database();

    return db.rawQuery(
        'SELECT * FROM quotes ORDER BY "Retweet Count" DESC LIMIT 50');
  }

  // display most retweeted data
  static Future<List<Map<String, dynamic>>> selectFavourites() async {
    final db = await DBHelper.database();

    return db.rawQuery(
        'SELECT * FROM quotes WHERE "Favourite" = 1 ORDER BY "index"');
  }

  static Future insertFav(String url, int oldFavStatus) async {
    final db = await DBHelper.database();

    //! index is a keyword in sqlite so we use some other column
    //! for filtering results
    // * ideally, the database should have had index col named
    // * as something else
    if (oldFavStatus == 0) {
      return db.rawUpdate('''
                      UPDATE quotes 
                      SET Favourite = ? 
                      WHERE URL = ?
                    ''', [1, url]);
    } else {
      return db.rawUpdate('''
                      UPDATE quotes 
                      SET Favourite = ? 
                      WHERE URL = ?
                    ''', [0, url]);
    }
  }
}
