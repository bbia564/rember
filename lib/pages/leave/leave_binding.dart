import 'package:get/get.dart';

import 'leave_logic.dart';

class LeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
