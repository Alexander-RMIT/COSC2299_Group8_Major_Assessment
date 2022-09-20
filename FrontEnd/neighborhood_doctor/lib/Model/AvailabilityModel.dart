import 'dart:convert';

AvailabilityModel AvailabilityModelJson(String str) =>
    AvailabilityModel.fromJson(json.decode(str));

String AvailabilityModelToJson(AvailabilityModel data) => json.encode(data.toJson());

class AvailabilityModel {
  int? id;
  int doctorId;
  String date;
  String status;
  String start;
  String end;

  AvailabilityModel({this.id, required this.doctorId, required this.date, required this.status, 
              required this.start, required this.end});

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) => AvailabilityModel(
      end: json["end"],
      start: json["start"],
      status: json["status"],
      date: json["date"],
      doctorId: json["doctorId"],
      id: json["id"]);

  Map<String, dynamic> toJson() => {
        "end": end,
        "start": start,
        "status": status,
        "date": date,
        "doctorId": doctorId,
        'id': id,
      };
  String get _end => end;
  String get _start => start;
  String get _status => status;
  String get _date => date;
  int get _doctorId => doctorId;
}
