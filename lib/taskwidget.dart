import 'package:adishankara_calender/pages/viewevent.dart';
import 'package:adishankara_calender/providers/event_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:getwidget/getwidget.dart';

// ignore: camel_case_types
class taskWidget extends StatefulWidget {
  const taskWidget({super.key});

  @override
  State<taskWidget> createState() => _taskWidgetState();
}

// ignore: camel_case_types
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
      print("date onlt: $formattedDate");
      print("Calender: $selectedEvents");
      print("CAlender debug: $filtered1");
    }

    if (filtered1.isEmpty) {
      return Container(
        color: Colors.transparent,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            title: const Icon(Icons.drag_handle),
            leading: null,
            centerTitle: true,
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 236, 245, 253),
          ),
          body: Scaffold(
            backgroundColor: const Color.fromARGB(255, 236, 245, 253),
            body: ListView.builder(
              itemCount: filtered1.length,
              itemBuilder: (BuildContext context, index) {
                return const Center(
                  child: Text("No Events"),
                );
              },
            ),
          ),
        ),
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
            body: Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: filtered1.length,
                itemBuilder: (BuildContext context, index) {
                  final datereq = filtered1[index].from;
                  final dateto = filtered1[index].to;
                  var toTime = DateFormat.H().format(dateto);
                  var fromTime = DateFormat.H().format(datereq);
                  return GFListTile(
                      shadow: const BoxShadow(
                        color: Color.fromARGB(167, 255, 255, 255),
                        offset: Offset.zero,
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ),
                      title: Text(
                        filtered1[index].eventName,
                        style: const TextStyle(
                            color: Colors.white60, fontSize: 20),
                      ),
                      onTap: () {
                        final event = selectedEvents
                            .where((e) =>
                                DateFormat.yMMMd().format(e.from) ==
                                formattedDate)
                            .toList();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewEvent(event: event),
                          ),
                        );
                      },
                      subTitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            filtered1[index].eventdesc,
                            style: const TextStyle(color: Colors.white60),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              "$fromTime - $toTime",
                              style: const TextStyle(color: Colors.white60),
                            ),
                          )
                        ],
                      ),
                      color: filtered1[index].background);
                },
              ),
            )),
      ),
    );
  }
}
