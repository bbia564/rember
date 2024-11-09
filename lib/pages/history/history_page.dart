import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:time_lens/widgets/empty_widget.dart';

import '../../entity/day_history.dart';
import '../../entity/lens.dart';
import '../../res/colors.dart';
import '../../res/style.dart';
import '../home/widget/method_item.dart';
import '../home/widget/pie_chart_item.dart';
import 'logic.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryPage extends GetView<HistoryLogic> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryLogic>(builder: (_) {
      return Column(
        children: [
          SizedBox(
            height: context.mediaQueryPadding.top + 20,
            width: double.infinity,
          ),
          Text(
            "History",
            style: AppStyle.titleStyles,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TableCalendar<HistoryRecord>(
              firstDay: DateTime.utc(2024, 5, 1),
              lastDay: DateTime.now(),
              focusedDay: controller.focusedDay,
              rowHeight: 40,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarFormat: CalendarFormat.month,
              rangeSelectionMode: RangeSelectionMode.toggledOff,
              eventLoader: (da) {
                return controller.list;
              },
              onDaySelected: controller.onDaySelected,
              onPageChanged: controller.onPageChanged,
              selectedDayPredicate: (day) => isSameDay(controller.focusedDay, day),
              calendarBuilders: CalendarBuilders(markerBuilder: (c, d, t) {
                for (var e in t) {
                  if (isSameDay(d, controller.formatterDay.parse(e.day))) {
                    return Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.themeColor,
                      ),
                    );
                  }
                }
                return const SizedBox();
              }),
              calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                      color: const Color(0xFF575FCF).withOpacity(0.2),
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  selectedDecoration: const BoxDecoration(
                    color: Color(0xFF575FCF),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    shape: BoxShape.rectangle,
                  ),
                  todayTextStyle:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white)),
              headerStyle: HeaderStyle(
                  titleCentered: true,
                  leftChevronMargin: EdgeInsets.zero,
                  rightChevronMargin: EdgeInsets.zero,
                  rightChevronPadding:  const EdgeInsets.symmetric(vertical: 12),
                  leftChevronPadding: const EdgeInsets.symmetric(vertical: 12),
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: const Color(0xFF575FCF),
                  ),
                  formatButtonVisible: false),
              headerVisible: true,
            ),
          ),
          Expanded(
            child: Container(
              margin: REdgeInsets.symmetric(
                horizontal: 16,
              ),
              padding: REdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  18.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.formatterDay.format(controller.focusedDay),
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        controller.convertTime(controller.totalTime),
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  15.verticalSpace,
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: GridView.count(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 19),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 40,
                      childAspectRatio: 147 / 36,
                      crossAxisCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        PieChartItem(
                          tag: "Fun",
                          color: const Color(0xFF575FCF),
                          showDivider: false,
                          time: controller.convertTime(controller.sumFun),
                        ),
                        PieChartItem(
                          tag: "Meal",
                          color: const Color(0xFFFFA801),
                          showDivider: false,
                          time: controller.convertTime(controller.sumMeal),
                        ),
                        PieChartItem(
                          tag: "Rest",
                          color: const Color(0xFFF53B57),
                          showDivider: false,
                          time: controller.convertTime(controller.sumRest),
                        ),
                        PieChartItem(
                          tag: "Study",
                          color: const Color(0xFF57C664),
                          showDivider: false,
                          time: controller.convertTime(controller.sumStudy),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: _buildListView()),
                ],
              ),
            ),
          ),
          40.verticalSpace,
        ],
      );
    });
  }

  Widget _buildListView() {
    if (controller.todayList.isEmpty) {
      return const EmptyWidget();
    }
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: controller.todayList.length,
      itemBuilder: (context, index) {
        final recode = controller.todayList[index];
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
