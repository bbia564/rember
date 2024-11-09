import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entity/day_history.dart';
import '../entity/lens.dart';
import 'cons.dart';

class DatabaseService extends GetxService {
  late Database db;
  final faker = Faker();

  Future<DatabaseService> init() async {
    await initDB();
    return this;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'timeLens_db.db');

    db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await createTable(db);
      await createDefaultData(db);
    });
  }

  createTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS timeLens (id INTEGER PRIMARY KEY,name TEXT,time INTEGER,tag TEXT,created_day TEXT,created_at TEXT)');
  }

  final DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm');
  final DateFormat formatterDay = DateFormat('yyyy/MM/dd');

  createDefaultData(Database db) async {
    for (var i = 0; i < 10; i++) {
      var time = faker.randomGenerator.integer(180, min: 10);
      var tag = faker.randomGenerator.element<String>(Cons.tags);
      // 生成一个随机的日期
      var cuDate = DateTime.now();
      DateTime randomDate =
          faker.date.dateTimeBetween(cuDate.subtract(const Duration(days: 5)), cuDate);
      // 格式化日期和时间

      String formattedDateTime = formatter.format(randomDate);

      String fateTime = formatterDay.format(randomDate);
      var count = await db.insert('timeLens', {
        'name': tag,
        'time': time,
        'tag': tag,
        'created_day': fateTime,
        'created_at': formattedDateTime,
      });
    }
  }

  add(String name, int time, String? tag, DateTime createdAt) async {
    await db.insert('timeLens', {
      'name': name,
      'time': time,
      'tag': tag,
      'created_day': formatterDay.format(createdAt),
      'created_at': formatter.format(createdAt),
    });
  }

  delete(int id) {
    db.delete('timeLens', where: 'id = ?', whereArgs: [id]);
  }

  update(int volume, String time) {
    db.rawUpdate('UPDATE timeLens SET volume = ? WHERE created_at= ?', [volume, time]);
  }

  deleteByDate(String createdDay) {
    db.delete('timeLens', where: 'created_day = ?', whereArgs: [createdDay]);
  }

  clean() async {
    await db.delete('timeLens');
  }

  closer() async {
    await db.close();
  }

  Future<List<TimeLensBean>> getAll(String day) async {
    var result = await db.query('timeLens', orderBy: 'created_at DESC');
    return result.map((e) => TimeLensBean.fromJson(e)).toList();
  }

  // SELECT SUM(time) as total_timeLens FROM your_table_name WHERE created_day = '2024-06-20';

  Future<int> calculateSum(String day) async {
    List<Map<String, Object?>> result =
        await db.rawQuery('SELECT SUM(time) as total FROM timeLens WHERE created_day ="$day"');
    if (result.isNotEmpty) {
      if (result.first['total'] != null) {
        return result.first['total'] as int;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  Future<int> sumTimeByTag(String day, String tag) async {
    List<Map<String, Object?>> result = await db.rawQuery(
        'SELECT SUM(time) as total FROM timeLens WHERE created_day ="$day" AND tag = "$tag"');
    if (result.isNotEmpty) {
      if (result.first['total'] != null) {
        return result.first['total'] as int;
      } else {
        return 0;
      }
    } else {
      // 如果没有数据，返回0或其他适当的值
      return 0;
    }
  }

  Future<List<HistoryRecord>> getAllDay() async {
    var result = await db.query('timeLens',
        distinct: true, columns: ['created_day'], orderBy: 'created_at DESC');
    List<HistoryRecord> list = [];
    await Future.wait(result.map((e) async {
      String day = e['created_day'].toString();
      List<TimeLensBean> dayRecords = await getByDay(day);
      list.add(HistoryRecord(day, dayRecords));
    }));
    return list;
  }

  Future<List<TimeLensBean>> getByDay(String day) async {
    var result = await db.query('timeLens',
        where: 'created_day = ?', whereArgs: [day], orderBy: 'created_at DESC');
    return result.map((e) => TimeLensBean.fromJson(e)).toList();
  }
}
