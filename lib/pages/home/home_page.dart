import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:time_lens/pages/home/widget/method_item.dart';
import 'package:time_lens/pages/home/widget/pie_chart_item.dart';
import 'package:time_lens/widgets/empty_widget.dart';

import '../../entity/lens.dart';
import '../../res/style.dart';
import '../../widgets/pie_chart_painter.dart';
import 'home_logic.dart';

class HomePage extends GetView<LLHomeLogic> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LLHomeLogic>(builder: (_) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: context.mediaQueryPadding.top + 20, left: 20, right: 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Today's Usage Time",
                            style: AppStyle.titleStyles,
                          ),
                          Text(
                            controller.convertTime(controller.totalTime),
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: const Color(0xFF0F0F0F),
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            controller.add();
                          },
                          child: CircleAvatar(
                            backgroundColor: const Color(0xFFF53B57),
                            radius: 24,
                            child: Image.asset(
                              "assets/images/ic_add.png",
                              width: 30,
                            ),
                          ),
                        ))
                  ],
                ),
                28.verticalSpace, // 百分比或分数，总和应为100或1
                SizedBox(
                  height: 160,
                  width: 160,
                  child: CustomPaint(
                    painter: PieChartPainter(values: [
                      controller.sumFun / controller.totalTime,
                      controller.sumMeal / controller.totalTime,
                      controller.sumRest / controller.totalTime,
                      controller.sumStudy / controller.totalTime,
                    ], colors: const [
                      Color(0xFF575FCF),
                      Color(0xFFFFA801),
                      Color(0xFFF53B57),
                      Color(0xFF57C664)
                    ]),
                    size: Size.infinite, // 或者指定一个具体的尺寸
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 40,
                  childAspectRatio: 147 / 36,
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    PieChartItem(
                      tag: "Fun",
                      color: const Color(0xFF575FCF),
                      time: controller.convertTime(controller.sumFun),
                    ),
                    PieChartItem(
                      tag: "Meal",
                      color: const Color(0xFFFFA801),
                      time: controller.convertTime(controller.sumMeal),
                    ),
                    PieChartItem(
                      tag: "Rest",
                      color: const Color(0xFFF53B57),
                      time: controller.convertTime(controller.sumRest),
                    ),
                    PieChartItem(
                      tag: "Study",
                      color: const Color(0xFF57C664),
                      time: controller.convertTime(controller.sumStudy),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: REdgeInsets.symmetric(horizontal: 16, vertical: 15),
              padding: REdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 34,
                    child: Row(
                      children: [
                        23.horizontalSpace,
                        Expanded(
                            child: Text(
                          "Time",
                          style: AppStyle.minTipStyle,
                        )),
                        Expanded(
                            child: Text("Description",
                                style: AppStyle.minTipStyle, textAlign: TextAlign.center)),
                        Expanded(
                            child: Text(
                          "Type",
                          style: AppStyle.minTipStyle,
                          textAlign: TextAlign.end,
                        )),
                        11.horizontalSpace,
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  Expanded(child: _buildListView(context))
                ],
              ),
            ),
          )
        ],
      );
    });
  }

  Widget _buildListView(BuildContext context) {
    if (controller.list.isEmpty) {
      return const EmptyWidget();
    }
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: controller.list.length,
      itemBuilder: (context, index) {
        final recode = controller.list[index];
        return MethodItem(
          record: recode,
          editAction: (TimeLensBean record) {},
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 1,
        );
      },
    );
  }
}
