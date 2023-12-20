import 'package:flutter/material.dart';

class Event {
  final String eventName;
  final String eventdesc;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
  const Event(
      {required this.eventName,
      required this.eventdesc,
      required this.from,
      required this.to,
      this.background = Colors.indigo,
      this.isAllDay = false});

  @override
  String toString() {
    return '{name: $eventName}, {fron: $from} , {to: $to}, {d: $isAllDay} {co: $background}';
  }
}
