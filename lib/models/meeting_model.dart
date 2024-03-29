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

  //json conversion for event for usecases
  Map<String, dynamic> toJson() {
    return {
      'eventName': eventName,
      'eventdesc': eventdesc,
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'background': background.value,
      'isAllDay': isAllDay,
    };
  }

  //json retrive code
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventName: json['eventName'],
      eventdesc: json['eventdesc'],
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json['to']),
      background: Color(json['background']),
      isAllDay: json['isAllDay'],
    );
  }
}
