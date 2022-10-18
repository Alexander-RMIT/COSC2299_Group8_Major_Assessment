import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:neighborhood_doctors/Model/AvailabilityModel.dart';

import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final AvailabilityModel model;

  const Event(this.title, this.model);

  @override
  String toString() => title;
}

Event availabilityToEvent(AvailabilityModel model) {
  String start = model.start;
  String end = model.end;
  Event event = Event("Available: $start - $end", model);
  return event;
}




Future<List<AvailabilityModel>> _GetAvailabilities() async {
  Uri uriReadAvailabilities = Uri.parse("https://neighborhood-doctors-backend.herokuapp.com/availability/readAvailability");

  var response = await http.get( uriReadAvailabilities,
    headers: <String, String>{"Content-Type": "application/json", },
  );
  String strResponse = response.body;

  print(strResponse);

  var parsedJson = jsonDecode(strResponse);

  int len = parsedJson.length;
  List<AvailabilityModel> AvailabilityList;
  AvailabilityList =(json.decode(response.body) as List).map((i) => AvailabilityModel.fromJson(i)).toList();

  print(AvailabilityList[1]);


  if (response.statusCode == 200) {
    return AvailabilityList;
  } else {
    return AvailabilityList;
  }
}






int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}
