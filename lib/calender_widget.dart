import 'package:adishankara_calender/add_event.dart';
import 'package:adishankara_calender/asc_materialapp.dart';
import 'package:adishankara_calender/models/meeting_model.dart';
import 'package:adishankara_calender/providers/event_provider.dart';
import 'package:adishankara_calender/taskwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Widget _selectedWidget = const taskWidget();

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    String? user = _auth.currentUser!.email;
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(5, 89, 163, 1),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const ToggleWidget(),
            actions: <Widget>[
              IconButton(
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      "https://img.freepik.com/premium-vector/symbol-male-user-icon-circle-profile-icon-vector-illustration_276184-154.jpg?w=2000"),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Hey $user"),
                    ),
                  );
                },
              ),
            ]),
        body: SlidingUpPanel(
          color: Colors.transparent,
          minHeight: MediaQuery.of(context).size.height / 3,
          panelBuilder: (scrollController) =>
              sliderbuild(scrollController: scrollController),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: SfCalendar(
                    view: CalendarView.month,
                    dataSource: EventdataSource(events),
                    showDatePickerButton: true,
                    allowViewNavigation: false,
                    headerStyle: const CalendarHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    headerHeight: 50,
                    onLongPress: (details) {
                      final provider =
                          Provider.of<EventProvider>(context, listen: false);
                      provider.setDate(details.date!);
                    },
                    onTap: (details) {
                      final provider =
                          Provider.of<EventProvider>(context, listen: false);
                      provider.setDate(details.date!);
                      setState(() {
                        // ignore: prefer_const_constructors
                        _selectedWidget = taskWidget();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddEvent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget sliderbuild({required ScrollController scrollController}) {
    return Theme(
      data: ThemeData.light(),
      child: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: _selectedWidget,
        ),
      ),
    );
  }
}

class EventdataSource extends CalendarDataSource {
  EventdataSource(List<Event> appoinments) {
    this.appointments = appointments;
  }

  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).eventName;

  @override
  Color getColor(int index) => getEvent(index).background;

  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;
}
