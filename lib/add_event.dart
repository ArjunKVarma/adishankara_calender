import 'package:adishankara_calender/models/meeting_model.dart';
import 'package:adishankara_calender/providers/event_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  final Event? event;

  const AddEvent({
    Key? key,
    this.event,
  }) : super(key: key);
  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  // initialising variable for form creation -------------------------------------------------------------------------
  final _formkey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  // End of variable initialisation -----------------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        actions: [
          ElevatedButton.icon(
            onPressed: savevent,
            icon: const Icon(Icons.done),
            label: const Text("Save"),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildTitle(),
                const SizedBox(height: 12),
                buildDateTimePickers(),
                const SizedBox(height: 12),
                buildDesc(),
              ],
            )),
      ));

  // Contents on display --------------------------------------------------------------------------------------------
  buildTitle() {
    return TextFormField(
      style: const TextStyle(fontSize: 24),
      decoration: const InputDecoration(
          border: UnderlineInputBorder(), hintText: "Add Title"),
      onFieldSubmitted: (_) {},
      validator: (title) =>
          title != null && title.isEmpty ? "Title cannot be empty" : null,
      controller: titleController,
    );
  }

  buildDesc() {
    return TextFormField(
      style: const TextStyle(fontSize: 24),
      decoration: const InputDecoration(
          border: UnderlineInputBorder(), hintText: "Add Description"),
      onFieldSubmitted: (_) {},
      controller: descController,
      maxLines: 3,
    );
  }

  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(),
          buildTo(),
        ],
      );

  Widget buildFrom() => buildHeader(
        header: "From",
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdown(
                  text: Util.toDate(fromDate),
                  onClicked: () => pickFromDateTime(pickdate: true)),
            ),
            Expanded(
              child: buildDropdown(
                text: Util.toTime(fromDate),
                onClicked: () => pickFromDateTime(pickdate: false),
              ),
            )
          ],
        ),
      );

  Widget buildHeader({required String header, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child,
        ],
      );
  Widget buildTo() {
    return buildHeader(
      header: "To",
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: buildDropdown(
              text: Util.toDate(toDate),
              onClicked: () => pickToDateTime(pickdate: true),
            ),
          ),
          Expanded(
            child: buildDropdown(
              text: Util.toTime(toDate),
              onClicked: () => pickToDateTime(pickdate: false),
            ),
          )
        ],
      ),
    );
  }

  buildDropdown({required String text, required VoidCallback onClicked}) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Future pickFromDateTime({required bool pickdate}) async {
    final date = await pickDateTime(fromDate, pickdate: pickdate);
    if (date == null) return;
    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() => fromDate = date);
  }
  // End of Displayable contents --------------------------------------------------------------------------------------------

  // Function for Saving event to database when save button is pressed ----------------------------
  Future savevent() async {
    final isValid = _formkey.currentState!.validate();
    Color colorARGB = Color.fromARGB(
      255,
      math.Random().nextInt(200),
      math.Random().nextInt(200),
      math.Random().nextInt(200),
    );

    if (isValid) {
      final event = Event(
          eventName: titleController.text,
          eventdesc: descController.text,
          from: fromDate,
          to: toDate,
          background: colorARGB,
          isAllDay: false);

      // Code block for adding event to State managment
      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.addEvent(event);

      //code block for adding event to firebase
      Map<String, dynamic> eventData = event.toJson();
      FirebaseFirestore.instance.collection('events').add(eventData);
      // End of adding event to firebase

      Navigator.of(context).pop();
    }
  }
  // End of savefunction ----------------------------------------------------

  // Code block for datepickers ------------------------------------------------------------------------
  Future<DateTime?> pickDateTime(DateTime initDate,
      {required bool pickdate, DateTime? firstDate}) async {
    if (pickdate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initDate,
        firstDate: firstDate ?? DateTime(2022, 1),
        lastDate: DateTime(2100),
      );

      if (date == null) return null;
      final time = Duration(hours: initDate.hour, minutes: initDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initDate));

      if (timeOfDay == null) return null;
      final date = DateTime(initDate.year, initDate.month, initDate.day);

      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Future pickToDateTime({required bool pickdate}) async {
    final date = await pickDateTime(toDate,
        pickdate: pickdate, firstDate: pickdate ? fromDate : null);
    if (date == null) return null;

    setState(() => toDate = date);
  }
}
// End of datepicker codeblock ----------------------------------------------------------------------------------------

//Utility function to convert Date and time formats
class Util {
  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);

    return date;
  }

  static String toTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);

    return time;
  }
}
// End of utility functions
