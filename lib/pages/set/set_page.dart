import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:time_lens/res/colors.dart';

import '../../res/style.dart';
import 'logic.dart';

class SetPage extends GetView<SettingLogic> {
  const SetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.mediaQueryPadding.top + 20,
          width: double.infinity,
        ),
        Text(
          "Other",
          style: AppStyle.titleStyles,
        ),
        Container(
          margin: REdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            color: Colors.white,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              ListTile(
                leading: Image.asset(
                  "assets/images/ic_del.png",
                  width: 19,
                ),
                minLeadingWidth: 19,
                title: Text(
                  'Clean Data',
                  style: AppStyle.tipStyles,
                ),
                onTap: () {
                  controller.onCleanData();
                },
              ),
              const Divider(
                height: 0,
              ).paddingOnly(left: 17, right: 17),
              ListTile(
                leading: Image.asset(
                  "assets/images/ic_i.png",
                  width: 19,
                ),
                minLeadingWidth: 19,
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'About',
                        style: AppStyle.tipStyles,
                      ),
                    ),
                    Obx(() => Text(
                      "V${controller.version.value}",
                      style: TextStyle(
                        color: AppColors.themeColor,
                        fontSize: 14.sp,
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
