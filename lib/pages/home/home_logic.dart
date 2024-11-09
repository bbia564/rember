import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../db/cons.dart';
import '../../db/db_service.dart';
import '../../entity/lens.dart';

class LLHomeLogic extends GetxController {
  static LLHomeLogic get to => Get.find<LLHomeLogic>();
  final db = Get.find<DatabaseService>();
  String currentDay = "";
  int totalTime = 0;
  int sumFun = 0;
  int sumMeal = 0;
  int sumRest = 0;
  int sumStudy = 0;
  DateTime currentDateTime = DateTime.now();

  add() {
    Get.toNamed('/addT');
  }

  del() async {
    await db.deleteByDate(currentDay);
    list.removeWhere((v) => v.day == currentDay);
  }

  List<TimeLensBean> list = <TimeLensBean>[];
  final DateFormat formatterDay = DateFormat('yyyy/MM/dd');

  @override
  onInit() {
    super.onInit();
    currentDay = formatterDay.format(currentDateTime);
    initDate();
  }

  initDate() async {
    await createDefaultData();
    getList();
  }

  createDefaultData() async {
    var defList = await db.getByDay(currentDay);
    if (defList != null && defList.isNotEmpty) {
      return;
    }
    // 生成一个随机的日期
    var cuDate = DateTime.now();
    for (var i = 0; i < 3; i++) {
      var value = faker.randomGenerator.integer(180, min: 10);
      var tag = faker.randomGenerator.element<String>(Cons.tags);
      var model = i;
      DateTime randomDate =
          faker.date.dateTimeBetween(cuDate.subtract(const Duration(hours: 3)), cuDate);
      var count = await db.add(tag, value, tag, randomDate);
    }
  }

  @override
  onClose() {
    db.closer();
  }

  getTODAYData(DateTime date) {
    currentDay = formatterDay.format(date);
    getList();
  }

  sumTimeFF() async {
    totalTime = await db.calculateSum(currentDay);
    sumFun = await db.sumTimeByTag(currentDay, "Fun");
    sumMeal = await db.sumTimeByTag(currentDay, "Meal");
    sumRest = await db.sumTimeByTag(currentDay, "Rest");
    sumStudy = await db.sumTimeByTag(currentDay, "Study");
  }

  getList() async {
    list = await db.getByDay(currentDay);
    await sumTimeFF();
    update();
  }

  String convertTime(int minutes) {
    if(minutes == 0){
      return "0h";
    }
    int hours = minutes ~/ 60; // 使用整数除法获取小时数
    int remainingMinutes = minutes % 60; // 使用取模运算获取剩余的分钟数

    // 使用字符串插值来格式化输出
    return '${hours}h ${remainingMinutes}m';
  }

  void clear() {
    list.clear();
    totalTime =0;
    sumFun = 0;
    sumMeal = 0;
    sumRest = 0;
    sumStudy = 0;
    update();
  }
}
