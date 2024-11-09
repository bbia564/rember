import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../res/style.dart';
import 'add_time_logic.dart';

class AddTimeSpentPage extends GetView<AddTimeLogic> {
  const AddTimeSpentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: AppStyle.defDecoration,
              margin: REdgeInsets.all(16),
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 14),
                      child: Text(
                        "Name",
                        style: AppStyle.tipStyles.copyWith(height: 1),
                      ),
                    ),
                    TextField(
                      controller: controller.nameTEC,
                      style: TextStyle(fontSize: 14.sp),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                          hintText: "Input Name",
                          hintStyle: AppStyle.hintStyles),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 14),
                      child: Text(
                        "Usage Time（min）",
                        style: AppStyle.tipStyles.copyWith(height: 1),
                      ),
                    ),
                    TextField(
                      controller: controller.timeTEC,
                      style: TextStyle(fontSize: 14.sp),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                          hintText: "Input Usage Time",
                          hintStyle: AppStyle.hintStyles),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 14),
                      child: Text(
                        "Select Tags ",
                        style: AppStyle.tipStyles.copyWith(height: 1),
                      ),
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 12,
                      childAspectRatio: 147 / 36,
                      crossAxisCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _typeItem("Fun", const Color(0xFF575FCF), false),
                        _typeItem("Meal", const Color(0xFFFFA801), true),
                        _typeItem("Rest", const Color(0xFFF53B57), false),
                        _typeItem("Study", const Color(0xFF57C664), false),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          controller.addData();
                        },
                        style: ButtonStyle(
                          side: WidgetStateProperty.all(
                            const BorderSide(color: Color(0xFFDEDEDE), width: 1.0), // 设置边框颜色和宽度
                          ),
                          backgroundColor: WidgetStateProperty.all(
                            const Color(0xFFF7F7F7),
                            // 设置边框颜色和宽度
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            // 设置边框颜色和宽度
                          ),
                        ),
                        child: Text(
                          "Add",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff3E3E3E)),
                        ),
                      ),
                    ),
                    20.verticalSpace
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _typeItem(String title, Color color, bool isCheck) {
    return InkWell(
      onTap: () {
        controller.tag.value = title;
      },
      child: Obx(() => Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                ),
              ),
              if (controller.tag.value == title)
                const Positioned(
                    left: 10,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    )),
            ],
          )),
    );
  }
}
