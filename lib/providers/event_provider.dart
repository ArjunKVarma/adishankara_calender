import 'package:adishankara_calender/models/meeting_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];

  List<Event> get events => _events;
  // Chenges the variable selected date to the date selected on calender
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;
  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOnselectedDate => _events;

  void addEvent(Event event) {
    _events.add(event);

    notifyListeners();
  }
}
