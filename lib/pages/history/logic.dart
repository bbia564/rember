import 'dart:collection';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../db/db_service.dart';
import '../../entity/day_history.dart';
import '../../entity/lens.dart';

class HistoryLogic extends GetxController {
  static HistoryLogic get to => Get.find<HistoryLogic>();
  final db = Get.find<DatabaseService>();
  final DateFormat formatterDay = DateFormat('yyyy/MM/dd');
  DateTime focusedDay = DateTime.now();

  del(String day) async {
    await db.deleteByDate(day);
    list.removeWhere((v) => v.day == day);
  }

  List<HistoryRecord> list = <HistoryRecord>[];
  List<TimeLensBean> todayList = <TimeLensBean>[];

  @override
  onInit() {
    super.onInit();
    getList();
  }

  getList() async {
    list = await db.getAllDay();
    todayList =
        list.firstWhereOrNull((v) => isSameDay(focusedDay, formatterDay.parse(v.day)))?.list ?? [];
    await sumTimeFF();
    update();
  }

  int totalTime = 0;
  int sumFun = 0;
  int sumMeal = 0;
  int sumRest = 0;
  int sumStudy = 0;

  sumTimeFF() async {
    String currentDay = formatterDay.format(focusedDay);
    totalTime = await db.calculateSum(currentDay);
    sumFun = await db.sumTimeByTag(currentDay, "Fun");
    sumMeal = await db.sumTimeByTag(currentDay, "Meal");
    sumRest = await db.sumTimeByTag(currentDay, "Rest");
    sumStudy = await db.sumTimeByTag(currentDay, "Study");
  }

  Future<void> onDaySelected(DateTime selectedDay, DateTime chioseDay) async {
    if (!isSameDay(focusedDay, chioseDay)) {
      focusedDay = chioseDay;
      todayList =
          list.firstWhereOrNull((v) => isSameDay(focusedDay, formatterDay.parse(v.day)))?.list ??
              [];
      await sumTimeFF();
      update();
    }
  }

  Future<void> onPageChanged(DateTime dd) async {
    focusedDay = dd;
    todayList =
        list.firstWhereOrNull((v) => isSameDay(focusedDay, formatterDay.parse(v.day)))?.list ??
            [];
    await sumTimeFF();
    update();
  }

  String convertTime(int minutes) {
    if (minutes == 0) {
      return "0h";
    }
    int hours = minutes ~/ 60; // 使用整数除法获取小时数
    int remainingMinutes = minutes % 60; // 使用取模运算获取剩余的分钟数

    // 使用字符串插值来格式化输出
    return '${hours}h ${remainingMinutes}m';
  }
}
