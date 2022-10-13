import 'dart:convert';

AppointmentModel AppointmentModelJson(String str) =>
    AppointmentModel.fromJson(json.decode(str));

String AppointmentModelToJson(AppointmentModel data) => json.encode(data.toJson());

class AppointmentModel {
  int? id;
  String date;
  String description;
  int doctorId;
  int patientId;
  String timeEnd;
  String timeStart;

  AppointmentModel({this.id, required this.date, required this.description, required this.doctorId,
              required this.patientId, required this.timeEnd, required this.timeStart});

  factory AppointmentModel.fromJson(Map<String, dynamic> json) => AppointmentModel(
      description: json["description"],
      patientId: json["patientId"],
      doctorId: json["doctorId"],
      timeEnd: json["timeEnd"],
      timeStart: json["timeStart"],
      date: json["date"],
      id: json["id"]);

  Map<String, dynamic> toJson() => {
        "description": description,
        "patientId": patientId,
        "doctorId": doctorId,
        "timeEnd": timeEnd,
        "timeStart": timeStart,
        "date": date,
        'id': id
      };
  String get _timeStart => timeStart;
  String get _timeEnd => timeEnd;
  int get _patientId => patientId;
  int get _doctorId => doctorId;
  String get _description => description;
  String get _date => date;
  int? get _id => id;
}
