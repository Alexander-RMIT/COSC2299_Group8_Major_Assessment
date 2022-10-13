//import 'dart:html';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';

//import 'package:neighborhood_doctors/Model/AdminModel.dart';
import 'package:neighborhood_doctors/Model/AvailabilityModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:neighborhood_doctors/Model/AvailabilityModel.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'utils.dart';

import 'dart:developer';

class DoctorAvailability extends StatefulWidget {
  //const Availability({Key? key, required this.title}) : super(key: key);
  //final String title;
  final String jwt;
  DoctorAvailability(this.jwt);

  @override
  State<DoctorAvailability> createState() => AvailabilityState(this.jwt);
}

//List<AvailabilityModel> getAvailabilities (int date) {}

Future<AvailabilityModel> createAvailability(int id, int doctorId, String date,
    String status, String start, String end, BuildContext context) async {
  // Change to http://localhost/patient/createPatient for desktop
  // Change to http://10.0.2.2:8080/patient/createPatient for android emulator
  Uri url = Uri.parse("http://10.0.2.2:8080/availability/createAvailability");
  var response = await http.post(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "id": id,
        "doctorId": doctorId,
        "date": date,
        "status": status,
        "start": start,
        "end": end
      }));

  String strResponse = response.body;

  if (response.statusCode == 200) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return ResponseAlertDialog(
            title: 'Backend response', content: response.body);
      },
    );
  }
  AvailabilityModel availability = AvailabilityModel(
      id: id,
      doctorId: doctorId,
      date: date,
      status: status,
      start: start,
      end: end);
  return availability;
}


Future<AvailabilityModel> deleteAvailability(int? id, int doctorId, String date,
    String status, String start, String end, BuildContext context) async {
  // Change to http://localhost/availability/deleteAvailability for desktop
  // Change to http://10.0.2.2:8080/availability/deleteAvailability for android emulator
  Uri url = Uri.parse("http://10.0.2.2:8080/availability/deleteAvailability");
  var response = await http.delete(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "id": id,
        "doctorId": doctorId,
        "date": date,
        "status": status,
        "start": start,
        "end": end
      }));

  if (response.statusCode == 200) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return ResponseAlertDialog(
            title: 'Backend response', content: response.body);
      },
    );
  }
  AvailabilityModel availability = AvailabilityModel(
      id: id,
      doctorId: doctorId,
      date: date,
      status: status,
      start: start,
      end: end);
  return availability;
}


class AvailabilityState extends State<DoctorAvailability> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  TimeOfDay newStartTime = TimeOfDay.now();
  TimeOfDay newEndTime = TimeOfDay.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  late Future<List<AvailabilityModel>> availabilityList;
  late List<AvailabilityModel> _availabilityList;
  final minimumPadding = 5.0;
  int id = 1;

  final String jwt;
  AvailabilityState(this.jwt);

  @override
  void initState() {
    _availabilityList = [];

    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }


  Future<void> _getAvailabilities() async {
    Uri uriReadAvailabilities =
        Uri.parse("http://10.0.2.2:8080/availability/readAvailabilities");

    var response = await http.get(
      uriReadAvailabilities,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );
    String strResponse = response.body;

    var parsedJson = jsonDecode(strResponse);

    int len = parsedJson.length;
    List<AvailabilityModel> availabilityList;
    availabilityList = (json.decode(response.body) as List)
        .map((i) => AvailabilityModel.fromJson(i))
        .toList();

    _availabilityList = availabilityList;
  }

  List<Event> _getEventsForDay(DateTime day) {
    List<Event> events = <Event>[];

    String formattedDate = DateFormat('yyyy-MM-dd').format(_focusedDay);
    for (AvailabilityModel model in _availabilityList) {
      if (model.date == formattedDate && model.doctorId==id) {
        events.add(availabilityToEvent(model));
      }
    }

    return events;
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    _getAvailabilities();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        //FutureBuilder<String>(
          //future: _getAvailabilities(),

        //)
        child: Column(
          children: <Widget>[
            const Text(
              'Change Your Availability',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2010),
              lastDay: DateTime.utc(2030),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _onDaySelected,
              onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(
                child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: ListTile(
                        onTap: () => openDeleteDialog(value[index]),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                  itemCount: value.length,
                );
              },
            )),
            ElevatedButton(
              child: Text('Add Availability'),
              onPressed: () {
                openDialog();
              },
            )
          ],
        ),
      ),
    );
  }

  Future openDeleteDialog(Event event) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Delete Avaliability?'),
          content: Column(children: <Widget>[
            Text(
                '\"$event\"'
            ),
            ElevatedButton(
              child: Text('Confirm'),
              onPressed: () {
                deleteAvailability(event.model.id, event.model.doctorId, event.model.status, 'Available',
                    event.model.start, event.model.end, context);
              },
            )
          ]
          )
      )
  );



  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('New Avaliability'),
          content: Column(children: <Widget>[
            TextField(
              controller: startTimeController,
              decoration: InputDecoration(
                icon: Icon(Icons.timer),
                labelText: 'Enter Start Time',
              ),
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                if (pickedTime != null) {
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());
                  //converting to DateTime so that we can further format on different pattern.
                  String formattedTime = DateFormat('HH:mm').format(parsedTime);
                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                  setState(() {
                    startTimeController.text =
                        formattedTime; //set the value of text field.
                  });
                } else {
                  print("Time is not selected");
                }
              },
            ),
            TextField(
              controller: endTimeController,
              decoration: InputDecoration(
                icon: Icon(Icons.timer),
                labelText: 'Enter End Time',
              ),
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                if (pickedTime != null) {
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());
                  //converting to DateTime so that we can further format on different pattern.
                  String formattedTime = DateFormat('HH:mm').format(parsedTime);

                  setState(() {
                    endTimeController.text =
                        formattedTime; //set the value of text field.
                  });
                } else {
                  print("Time is not selected");
                }
              },
            ),
            ElevatedButton(
              child: Text('Add Availability'),
              onPressed: () {
                _getAvailabilities();
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(_focusedDay);
                String formattedStartTime = startTimeController.text;
                String formattedEndTime = endTimeController.text;

                createAvailability(1, id, formattedDate, 'Available',
                    formattedStartTime, formattedEndTime, context);
              },
            )
          ])));
}

class ResponseAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  ResponseAlertDialog({
    required this.title,
    required this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
      ),
      actions: this.actions,
      content: Text(
        this.content,
      ),
    );
  }
}
