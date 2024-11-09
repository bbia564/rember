import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TimeLensBean {
  int id;
  String? name;
  int time;
  String tag;
  DateTime createdAt;

  TimeLensBean(
    this.id,
    this.name,
    this.time,
    this.tag,
    this.createdAt,
  );

  factory TimeLensBean.fromJson(Map<String, dynamic> json) {
    var dateFormat = DateFormat("yyyy/MM/dd HH:mm");
    return TimeLensBean(
      json['id'],
      json['name'],
      json['time'],
      json['tag'],
      dateFormat.parse(json['created_at']),
    );
  }

  get day {
    return DateFormat('yyyy/MM/dd').format(createdAt);
  }

  get hm {
    return DateFormat('HH:mm').format(createdAt);
  }
}
