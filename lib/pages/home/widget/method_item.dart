import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:time_lens/db/cons.dart';

import '../../../entity/lens.dart';

class MethodItem extends StatelessWidget {
  const MethodItem({super.key, required this.record, required this.editAction});

  final TimeLensBean record;
  final ValueChanged<TimeLensBean> editAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 14.sp, color: const Color(0xFF0F0F0F)),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                   CircleAvatar(
                    radius: 5,
                    backgroundColor: Cons.statusColors[record.tag],
                  ),
                  10.horizontalSpace,
                  Text(
                    "${record.time} min",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                record.name??"",
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                record.tag,
                textAlign: TextAlign.end,
                style: TextStyle(color: Cons.statusColors[record.tag],),
              ),
            ),
            11.horizontalSpace,
          ],
        ),
      ),
    );
  }
}
