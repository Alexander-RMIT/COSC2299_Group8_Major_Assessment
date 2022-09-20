import 'dart:convert';

SymptomModel symptomModelJson(String str) =>
    SymptomModel.fromJson(json.decode(str));

String symptomModelToJson(SymptomModel data) => json.encode(data.toJson());

class SymptomModel {
  int? id;
  String name;
  String patientId;

  SymptomModel({
    this.id,
    required this.name,
    required this.patientId,
  });

  factory SymptomModel.fromJson(Map<String, dynamic> json) => SymptomModel(
      name: json["name"], patientId: json["patientId"], id: json["id"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "patientId": patientId,
        'id': id,
      };
  String get _name => name;
  String get _patientId => patientId;
}
