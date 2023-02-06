import 'dart:convert';
import 'package:colab/models/progress_offline.dart';
import 'package:colab/models/snag_offline.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

import '../../models/all_offline_data.dart';
import '../../models/category_list.dart';
import '../../models/contractor_data_offline.dart';

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
         db.execute(
          ''' CREATE TABLE my_json_models3 (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            allOffline TEXT
            )
          ''',
        );
         db.execute(
          ''' CREATE TABLE my_json_models4 (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category TEXT
            )
          ''',
        );
         db.execute(
          ''' CREATE TABLE my_json_models5 (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            contractor TEXT
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
  
  Future<void> insertAllOfflineModel(var allOfflineData) async {
    try {
    final List<Map<String, dynamic>> existingRows = await _database.rawQuery(
        'SELECT id, allOffline FROM my_json_models3',
        );

    if (existingRows.isNotEmpty) {
      final Map<String, dynamic> existingRow = existingRows.first;
      final int id = existingRow['id'];
      await _database.rawUpdate(
        'UPDATE my_json_models3 SET allOffline = ? WHERE id = ?',
        [allOfflineData, id],
      );
    } else {
      await _database.rawInsert(
        'INSERT INTO my_json_models3 (allOffline) VALUES (?)',
        [allOfflineData],
      );
    }
    } catch (e) {
      if (kDebugMode) {
        print("Error in saving allOffline data => $e");
      }
    }
  }

   Future<void> insertCategoryModel(var categoryData) async {
    try {
    final List<Map<String, dynamic>> existingRows = await _database.rawQuery(
        'SELECT id, category FROM my_json_models4',
        );

    if (existingRows.isNotEmpty) {
      final Map<String, dynamic> existingRow = existingRows.first;
      final int id = existingRow['id'];
      await _database.rawUpdate(
        'UPDATE my_json_models4 SET category = ? WHERE id = ?',
        [categoryData, id],
      );
    } else {
      await _database.rawInsert(
        'INSERT INTO my_json_models4 (category) VALUES (?)',
        [categoryData],
      );
    }
    } catch (e) {
      if (kDebugMode) {
        print("Error in saving category data => $e");
      }
    }
  }

  Future<void> insertContractorModel(var contractorData) async {
    try {
    final List<Map<String, dynamic>> existingRows = await _database.rawQuery(
        'SELECT id, contractor FROM my_json_models5',
        );

    if (existingRows.isNotEmpty) {
      final Map<String, dynamic> existingRow = existingRows.first;
      final int id = existingRow['id'];
      await _database.rawUpdate(
        'UPDATE my_json_models5 SET contractor = ? WHERE id = ?',
        [contractorData, id],
      );
    } else {
      await _database.rawInsert(
        'INSERT INTO my_json_models5 (contractor) VALUES (?)',
        [contractorData],
      );
    }
    } catch (e) {
      if (kDebugMode) {
        print("Error in saving contractor data => $e");
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

   Future<CategoryList> getCategoryModel() async {
    await init();
    final List<Map<String, dynamic>> maps = await _database.query('my_json_models4');
      Map<String,dynamic> cData2=(jsonDecode(maps[0]['category']));
      return CategoryList.fromJson(cData2['data']);
  }

  Future<List<SnagDataOffline>> getSnagModel() async {
    await init();
    final List<Map<String, dynamic>> maps = await _database.query('my_json_models2');
    return List.generate(maps.length, (i) {
      return SnagDataOffline.fromJson(jsonDecode(maps[i]['snag']));
    });
  }

  Future<List<AllOffline>> getAllOfflineModel() async {
    await init();
    final List<Map<String, dynamic>> maps = await _database.query('my_json_models3');
    return List.generate(maps.length, (i) {
      return AllOffline.fromJson(jsonDecode(maps[i]['allOffline']));
    });
  }

  Future<List<ContractorDataOffline>> getContractorModel() async {
    await init();
    final List<Map<String, dynamic>> maps = await _database.query('my_json_models5');
    return List.generate(maps.length, (i) {
      return ContractorDataOffline.fromJson(jsonDecode(maps[i]['contractor']));
    });
  }
}
