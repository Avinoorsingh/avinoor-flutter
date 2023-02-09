import 'dart:convert';
import 'package:colab/models/progress_offline.dart';
import 'package:colab/models/progress_trade_data.dart';
import 'package:colab/models/snag_offline.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

import '../../models/all_offline_data.dart';
import '../../models/category_list.dart';
import '../../models/clientEmployee.dart';
import '../../models/contractor_data_offline.dart';
import '../../models/labour_attendance.dart';
import '../../models/progress_contractor.dart';

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
        db.execute(
          ''' CREATE TABLE my_json_models6 (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            employee TEXT
            )
          ''',
        );
        db.execute(
          ''' CREATE TABLE my_json_models8 (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            contractorDebit TEXT
            )
          ''',
        );
         db.execute(
          ''' CREATE TABLE my_json_models9 (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            labour TEXT
            )
          ''',
        );
         db.execute(
          ''' CREATE TABLE my_json_models7 (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            trade TEXT
            )
          ''',
        );
        db.execute(
          ''' CREATE TABLE form_data (
            id INTEGER PRIMARY KEY, 
            snagData TEXT
            )
          ''');
        db.execute(
          ''' CREATE TABLE progress_data (
            id INTEGER PRIMARY KEY, 
            progressData TEXT
            )
        ''');
        db.execute(
          ''' CREATE TABLE upcoming_data (
            id INTEGER PRIMARY KEY, 
            upcomingData TEXT
            )
        ''');
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

   Future<void> insertTrade(var tradeData) async {
    try {
    final List<Map<String, dynamic>> existingRows = await _database.rawQuery(
        'SELECT id, trade FROM my_json_models7',
        );

    if (existingRows.isNotEmpty) {
      final Map<String, dynamic> existingRow = existingRows.first;
      final int id = existingRow['id'];
      await _database.rawUpdate(
        'UPDATE my_json_models7 SET trade = ? WHERE id = ?',
        [tradeData, id],
      );
    } else {
      await _database.rawInsert(
        'INSERT INTO my_json_models7 (trade) VALUES (?)',
        [tradeData],
      );
    }
    } catch (e) {
      if (kDebugMode) {
        print("Error in saving trade data => $e");
      }
    }
  }

   Future<void> insertContractorForDebit(var contractorForDebitData) async {
    try {
    final List<Map<String, dynamic>> existingRows = await _database.rawQuery(
        'SELECT id, contractorDebit FROM my_json_models8',
        );

    if (existingRows.isNotEmpty) {
      final Map<String, dynamic> existingRow = existingRows.first;
      final int id = existingRow['id'];
      await _database.rawUpdate(
        'UPDATE my_json_models8 SET contractorDebit = ? WHERE id = ?',
        [contractorForDebitData, id],
      );
    } else {
      await _database.rawInsert(
        'INSERT INTO my_json_models8 (contractorDebit) VALUES (?)',
        [contractorForDebitData],
      );
    }
    } catch (e) {
      if (kDebugMode) {
        print("Error in saving contractorForDebitData data => $e");
      }
    }
  }

  Future<void> insertLabourAttendanceToday(var labourData) async {
    try {
    final List<Map<String, dynamic>> existingRows = await _database.rawQuery(
        'SELECT id, labour FROM my_json_models9',
        );

    if (existingRows.isNotEmpty) {
      final Map<String, dynamic> existingRow = existingRows.first;
      final int id = existingRow['id'];
      await _database.rawUpdate(
        'UPDATE my_json_models9 SET labour = ? WHERE id = ?',
        [labourData, id],
      );
    } else {
      await _database.rawInsert(
        'INSERT INTO my_json_models9 (labour) VALUES (?)',
        [labourData],
      );
    }
    } catch (e) {
      if (kDebugMode) {
        print("Error in saving labour data => $e");
      }
    }
  }

  Future<void> insertEmployeeModel(var employeeData) async {
    try {
    final List<Map<String, dynamic>> existingRows = await _database.rawQuery(
        'SELECT id, employee FROM my_json_models6',
        );

    if (existingRows.isNotEmpty) {
      final Map<String, dynamic> existingRow = existingRows.first;
      final int id = existingRow['id'];
      await _database.rawUpdate(
        'UPDATE my_json_models6 SET employee = ? WHERE id = ?',
        [employeeData, id],
      );
    } else {
      await _database.rawInsert(
        'INSERT INTO my_json_models6 (employee) VALUES (?)',
        [employeeData],
      );
    }
    } catch (e) {
      if (kDebugMode) {
        print("Error in saving employee data => $e");
      }
    }
  }

  Future<void> insertSnagFormData(var formData) async {
    String serializedFormData = json.encode(formData);
    await _database.insert('form_data', {'snagData':serializedFormData});
  }

  Future<void> insertProgressFormData(var formData) async {
    String serializedFormData = json.encode(formData);
    await _database.insert('progress_data', {'progressData':serializedFormData});
  }

   Future<void> insertUpcomingInsideOnGoingFormData(var formData) async {
    String serializedFormData = json.encode(formData);
    await _database.insert('upcoming_data', {'upcomingData':serializedFormData});
  }

  Future<List<Map<String, dynamic>>> getSnagFormData() async {
    final List<Map<String, dynamic>> formDataRows = await _database.query('form_data');
    List<Map<String, dynamic>> formDataList = [];
    for (var formDataRow in formDataRows) {
      formDataList.add(jsonDecode(formDataRow['snagData']));
    }
    return formDataList;
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

  Future<ContractorDataOffline> getContractorModel() async {
    await init();
    final List<Map<String, dynamic>> maps = await _database.query('my_json_models5');
      return ContractorDataOffline.fromJson(jsonDecode(maps[0]['contractor']));
    }

  Future<ClientEmployee> getEmployeeModel() async {
    await init();
    final List<Map<String, dynamic>> maps = await _database.query('my_json_models6');
      return ClientEmployee.fromJson(jsonDecode(maps[0]['employee']));
    }
  
  Future<ProgressTrade> getTradeModel() async {
    await init();
    final List<Map<String, dynamic>> maps = await _database.query('my_json_models7');
      return ProgressTrade.fromJson(jsonDecode(maps[0]['trade']));
    }
   
  Future<ProgressContractor> getContractorForDebitModel() async {
    await init();
    final List<Map<String, dynamic>> maps = await _database.query('my_json_models8');
      return ProgressContractor.fromJson(jsonDecode(maps[0]['contractorDebit']));
    }

  Future<LabourAttendance> getLabourAttendanceModel() async {
    await init();
    final List<Map<String, dynamic>> maps = await _database.query('my_json_models9');
      return LabourAttendance.fromJson(jsonDecode(maps[0]['labour']));
    }
}
