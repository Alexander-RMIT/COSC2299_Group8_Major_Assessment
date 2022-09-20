import 'dart:convert';

SymptomModel symptomModelJson(String str) =>
    SymptomModel.fromJson(json.decode(str));

String symptomModelToJson(SymptomModel data) => json.encode(data.toJson());

class SymptomModel {
  int? id;
  String name;
  String patientId;
  String? severity;
  String? note;

  SymptomModel({
    this.id,
    required this.name,
    required this.patientId,
    this.severity,
    this.note,
  });

  factory SymptomModel.fromJson(Map<String, dynamic> json) => SymptomModel(
      name: json["name"],
      patientId: json["patientId"],
      id: json["id"],
      severity: json["severity"],
      note: json["note"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "patientId": patientId,
        "id": id,
        "severity": severity,
        "note": note
      };
  String get _name => name;
  String get _patientId => patientId;
  String? get _severity => severity;
  String? get _note => note;
}
