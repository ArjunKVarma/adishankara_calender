import 'package:adishankara_calender/models/meeting_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewEvent extends StatelessWidget {
  // In the constructor, require a Todo.
  const ViewEvent({super.key, required this.event});

  // Declare a field that holds the Todo.
  final List<Event> event;

  @override
  Widget build(BuildContext context) {
    final evt = event.toList();
    final name = evt[0].eventName.toUpperCase();
    final datereqf = evt[0].from;
    final datereqt = evt[0].to;
    final desc = evt[0].eventdesc;
    final sad = evt[0].background;
    final String date;
    var formattedFromdate = DateFormat.yMMMd().format(datereqf);
    var formattedTodate = DateFormat.yMMMd().format(datereqt);
    var toTime = DateFormat.H().format(datereqt);
    var fromTime = DateFormat.H().format(datereqf);
    if (formattedTodate == formattedFromdate) {
      date = formattedFromdate;
    } else {
      date = "$formattedFromdate - $formattedTodate";
    }
    return Scaffold(
        backgroundColor: sad,
        appBar: AppBar(
          backgroundColor: sad,
          title: Text(
            name,
            style: const TextStyle(color: Colors.white60, fontSize: 20),
          ),
        ),
        body: Scaffold(
          backgroundColor: sad,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/background_image.jpg'), // Replace with your background image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Event Date: $date',
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Event Time: $fromTime - $toTime',
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Description: $desc',
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
