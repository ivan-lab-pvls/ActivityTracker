import 'package:activity_tracker/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  const Activity({
    required this.name,
    required this.colorCode,
    required this.iconPath,
    required this.time,
    required this.startDate,
    required this.endDate,
  });

  final String name;
  final String colorCode;
  final String iconPath;
  final Duration time;
  final DateTime startDate;
  final DateTime endDate;

  Color get color {
    final fullCode = '0xFF$colorCode';
    final intCode = int.tryParse(fullCode);
    if (intCode == null) {
      return MyTheme.grey;
    }

    return Color(intCode);
  }

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}

String formatDuration(Duration duration) {
  final String hours = duration.inHours.toString().padLeft(2, '0');
  final String minutes =
      duration.inMinutes.remainder(60).floor().toString().padLeft(2, '0');
  final String seconds =
      duration.inSeconds.remainder(60).floor().toString().padLeft(2, '0');

  return '$hours:$minutes:$seconds';
}

String colorToCode(Color color) {
  final c = color.toString();
  final code = c.split('0xff').last;
  final colorCode = code.substring(0, code.length - 1);
  return colorCode;
}
