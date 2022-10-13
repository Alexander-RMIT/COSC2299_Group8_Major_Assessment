import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:neighborhood_doctors/Model/AvailabilityModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:table_calendar/table_calendar.dart';
import '../../Model/AppointmentModel.dart';
import 'utils.dart';

import 'dart:developer';

class ScheduleAppointment extends StatefulWidget {
  //const Availability({Key? key, required this.title}) : super(key: key);
  //final String title;
  final int id;
  const ScheduleAppointment.Schedule(this.id, {super.key});

  @override
  State<ScheduleAppointment> createState() => ScheduleAppointmentState(this.id);
}

//List<AvailabilityModel> getAvailabilities (int date) {}

Future<AppointmentModel> createAppointment(int id, String date, String description, int doctor_id,
    int patient_id, String time_end, String time_start, BuildContext context) async {
  // Change to http://localhost/patient/createPatient for desktop
  // Change to http://10.0.2.2:8080/patient/createPatient for android emulator
  Uri url = Uri.parse("http://10.0.2.2:8080/appointment/createAppointment");

  var response = await http.post(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "date": date,
        "timeStart": time_start,
        "timeEnd": time_end,
        "doctorId": doctor_id,
        "patientId": patient_id,
        "description": description
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
  AppointmentModel appointment = AppointmentModel(
      id: id,
      date: date,
      description: description,
      doctorId: doctor_id,
      patientId: patient_id,
      timeEnd: time_end,
      timeStart: time_start);
  return appointment;
}


Future<AppointmentModel> deleteAppointment(int id, String date, String description, int doctor_id,
    int patient_id, String time_end, String time_start, BuildContext context) async {
  // Change to http://localhost/availability/deleteAvailability for desktop
  // Change to http://10.0.2.2:8080/availability/deleteAvailability for android emulator
  Uri url = Uri.parse("http://10.0.2.2:8080/appointment/deleteAppointment");
  var response = await http.delete(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "id": id,
        "date": date,
        "description": description,
        "doctor_id": doctor_id,
        "patient_id": patient_id,
        "time_end": time_end,
        "time_start": time_start
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
  AppointmentModel appointment = AppointmentModel(
      id: id,
      date: date,
      description: description,
      doctorId: doctor_id,
      patientId: patient_id,
      timeEnd: time_end,
      timeStart: time_start);
  return appointment;
}


class ScheduleAppointmentState extends State<ScheduleAppointment> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  TimeOfDay newStartTime = TimeOfDay.now();
  TimeOfDay newEndTime = TimeOfDay.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  late Future<List<AvailabilityModel>> availabilityList;
  late List<AvailabilityModel> _availabilityList;
  late List<AppointmentModel> _appointmentList;
  final minimumPadding = 5.0;
  int _activeDoctor = 1;

  var doctors = [
    'Doctor 1',
    'Doctor 2',
    'Doctor 3'
  ];

  final int id;
  ScheduleAppointmentState(this.id);

  @override
  void initState() {
    _availabilityList = [];
    _appointmentList = [];

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


    List<AvailabilityModel> availabilityList;
    availabilityList = (json.decode(response.body) as List)
        .map((i) => AvailabilityModel.fromJson(i))
        .toList();

    _availabilityList = availabilityList;
  }

  Future<void> _getAppointments() async {
    Uri uriReadAvailabilities =
    Uri.parse("http://10.0.2.2:8080/appointment/readAppointments");

    var response = await http.get(
      uriReadAvailabilities,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );
    String strResponse = response.body;

    List<AppointmentModel> appointmentList;
    appointmentList = (json.decode(response.body) as List)
        .map((i) => AppointmentModel.fromJson(i))
        .toList();

    _appointmentList = appointmentList;
  }



  List<Event> _getEventsForDay(DateTime day) {
    List<Event> events = <Event>[];

    String formattedDate = DateFormat('yyyy-MM-dd').format(_focusedDay);
    for (AvailabilityModel model in _availabilityList) {
      if (model.date == formattedDate && model.doctorId==_activeDoctor) {
        events.add(availabilityToEvent(model));
      }
    }

    for (AppointmentModel model in _appointmentList) {
      if (model.date == formattedDate && model.doctorId==_activeDoctor && model.patientId == id) {
        events.add(appointmentToEvent(model));
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
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
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
    _getAppointments();
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
              'Book an Appointment',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Flexible(
                      flex: 2,
                      child: Text(
                          'Select Doctor: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )
                      )
                  ),
                  Flexible(
                    flex: 2,
                    child: DropdownButton(

                      // Initial Value
                      value: doctors[_activeDoctor-1],

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: doctors.map((String doctors) {
                        return DropdownMenuItem(
                          value: doctors,
                          child: Text(doctors),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          _activeDoctor = doctors.indexOf(newValue!)+1;
                        });
                      },
                    ),
                  )
                ]
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
                            onTap: () => newAppointment(),
                            title: Text('${value[index]}'),
                          ),
                        );
                      },
                      itemCount: value.length,
                    );
                  },
                )),
            ElevatedButton(
              child: const Text('Add Appointment'),
              onPressed: () {
                newAppointment();
              },
            )
          ],
        ),
      ),
    );
  }

  Future newAppointment() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('New Appointment'),
          content: Column(children: <Widget>[
            TextField(
              controller: startTimeController,
              decoration: const InputDecoration(
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
            const Text(
              'Duration: 30 min'
            ),
            ElevatedButton(
              child: const Text('Add Appointment'),
              onPressed: () {
                _getAvailabilities();
                String formattedDate =
                DateFormat('yyyy-MM-dd').format(_focusedDay);
                String formattedStartTime = startTimeController.text;
                String formattedEndTime = "30";

                createAppointment(1, formattedDate, "Placeholder Description", _activeDoctor!,
                    id, formattedEndTime, formattedStartTime, context);
              },
            )
          ])));



  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('New Availability'),
          content: Column(children: <Widget>[
            TextField(
              controller: startTimeController,
              decoration: const InputDecoration(
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
              decoration: const InputDecoration(
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
              child: const Text('Add Availability'),
              onPressed: () {
                _getAvailabilities();
                String formattedDate =
                DateFormat('yyyy-MM-dd').format(_focusedDay);
                String formattedStartTime = startTimeController.text;
                String formattedEndTime = endTimeController.text;

                createAppointment(1, formattedDate, "Placeholder Description", _activeDoctor!,
                    id, formattedEndTime, formattedStartTime, context);
              },
            )
          ])));
}

class ResponseAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const ResponseAlertDialog({super.key,
    required this.title,
    required this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
      ),
      actions: actions,
      content: Text(
        content,
      ),
    );
  }
}
