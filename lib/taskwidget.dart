import 'package:adishankara_calender/calender_widget.dart';
import 'package:adishankara_calender/providers/event_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class taskWidget extends StatefulWidget {
  const taskWidget({super.key});

  @override
  State<taskWidget> createState() => _taskWidgetState();
}

class _taskWidgetState extends State<taskWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOnselectedDate;

    var date = provider.selectedDate;
    var formattedDate = DateFormat.yMMMd().format(date);

    final filtered1 = selectedEvents
        .where((e) => DateFormat.yMMMd().format(e.from) == formattedDate)
        .toList();

    if (kDebugMode) {
      print("date onlt: " + formattedDate);
      selectedEvents.contains(provider.selectedDate);
      print("Calender: " + selectedEvents.toString());
      print("CAlender debug: " + filtered1.toString());
    }

    if (selectedEvents.isEmpty) {
      return Center(
        child: Text("hey nogg"),
      );
    }

    return Container(
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          title: const Icon(Icons.drag_handle),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 236, 245, 253),
        ),
        body: Scaffold(
          backgroundColor: const Color.fromARGB(255, 236, 245, 253),
          body: ListView.builder(
            itemCount: filtered1.length,
            itemBuilder: (BuildContext context, index) {
              return Container(
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  children: <Widget>[Text(filtered1[index].eventName)],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
