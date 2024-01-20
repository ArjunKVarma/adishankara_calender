import 'package:adishankara_calender/models/meeting_model.dart';
import 'package:adishankara_calender/pages/viewevent.dart';
import 'package:adishankara_calender/providers/event_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    // var date1 = date.toLocal().toString().split(' ')[0];
    // DateTime select_date = new DateFormat("yyyy-MM-dd").parse(date1);
    var formattedDate = DateFormat.yMMMd().format(date);
    final filtered1 = selectedEvents
        .where((e) => DateFormat.yMMMd().format(e.from) == formattedDate)
        .toList();

    if (kDebugMode) {
      print("date onlt: $formattedDate");
      print("Calender: $date");
      print("CAlender debug: $filtered1");
    }

    // code for retriving firestore data
    Stream<List<Event>> eventsStream = FirebaseFirestore.instance
        .collection('events')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => Event.fromJson(doc.data()))
          .toList();
    });

    //stream state

    //end of code
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
                child: StreamBuilder<List<Event>>(
                  stream: eventsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Event> events = snapshot.data!;
                      return ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          Event event = events[index];
                          if (event.from.isAfter(date)) {
                            print("The event is ${event.eventName}");
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
                                      builder: (context) =>
                                          ViewEvent(event: event),
                                    ),
                                  );
                                },
                                subTitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      filtered1[index].eventdesc,
                                      style: const TextStyle(
                                          color: Colors.white60),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: Text(
                                        "${event.from} to ${event.to}",
                                        style: const TextStyle(
                                            color: Colors.white60),
                                      ),
                                    )
                                  ],
                                ),
                                color: filtered1[index].background);
                          }
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ))),
      ),
    );
  }
}
