import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../db/db_service.dart';
import 'home_logic.dart';

class AddTimeLogic extends GetxController {
  static AddTimeLogic get to => Get.find<AddTimeLogic>();
  final db = Get.find<DatabaseService>();
  TextEditingController nameTEC = TextEditingController();
  TextEditingController timeTEC = TextEditingController();
  var tag = "".obs;

  @override
  onInit() {
    super.onInit();
  }

  addData() async {

    if (nameTEC.text.isEmpty) {
      EasyLoading.showToast("Please input 'Name' ");
      return;
    }
    if (timeTEC.text.isEmpty) {
      EasyLoading.showToast("Please input 'Usage Time' ");
      return;
    }
    if (tag.value.isEmpty) {
      EasyLoading.showToast("Please Select Tags");
      return;
    }
    EasyLoading.show();
    var currentTime = DateTime.now();
    await db.add(nameTEC.text, int.parse(timeTEC.text), tag.value,currentTime);
    LLHomeLogic.to.getTODAYData(currentTime);
    Future.delayed(const Duration(seconds: 1)).then((v) {
      EasyLoading.dismiss();
      Get.back();
    });
  }
}
