import 'dart:convert';

import 'package:colab/models/progress_offline.dart';
import 'package:colab/models/snag_offline.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class DatabaseProvider {
  late Database _database;

  init() async {
    _database = await openDatabase(
      p.join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        db.execute(
          ''' CREATE TABLE my_json_models (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            progress TEXT
            )
          ''',
        );
        db.execute(
          ''' CREATE TABLE my_json_models2 (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            snag TEXT
            )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> insertMyJsonModel(var progressData) async {
    try {
    final List<Map<String, dynamic>> existingRows = await _database.rawQuery(
        'SELECT id, progress FROM my_json_models',
        );

    if (existingRows.isNotEmpty) {
      final Map<String, dynamic> existingRow = existingRows.first;
      final int id = existingRow['id'];
      await _database.rawUpdate(
        'UPDATE my_json_models SET progress = ? WHERE id = ?',
        [progressData, id],
      );
    } else {
      await _database.rawInsert(
        'INSERT INTO my_json_models (progress) VALUES (?)',
        [progressData],
      );
    }
    } catch (e) {
      if (kDebugMode) {
        print("Error in saving progress data => $e");
      }
    }
  }

  Future<void> insertSnagModel(var snagData) async {
    try {
    final List<Map<String, dynamic>> existingRows = await _database.rawQuery(
        'SELECT id, snag FROM my_json_models2',
        );

    if (existingRows.isNotEmpty) {
      final Map<String, dynamic> existingRow = existingRows.first;
      final int id = existingRow['id'];
      await _database.rawUpdate(
        'UPDATE my_json_models2 SET snag = ? WHERE id = ?',
        [snagData, id],
      );
    } else {
      await _database.rawInsert(
        'INSERT INTO my_json_models2 (snag) VALUES (?)',
        [snagData],
      );
    }
    } catch (e) {
      if (kDebugMode) {
        print("Error in saving snag data => $e");
      }
    }
  }


  Future<List<ProgressOffline>> getMyJsonModels() async {
    await init();
    final List<Map<String, dynamic>> maps = await _database.query('my_json_models');
    return List.generate(maps.length, (i) {
      return ProgressOffline.fromJson(jsonDecode(maps[i]['progress']));
    });
  }

  Future<List<SnagDataOffline>> getSnagModel() async {
    await init();
    final List<Map<String, dynamic>> maps = await _database.query('my_json_models2');
    return List.generate(maps.length, (i) {
      return SnagDataOffline.fromJson(jsonDecode(maps[i]['snag']));
    });
  }
}
