import 'dart:convert';

DoctorModel doctorModelJson(String str) =>
    DoctorModel.fromJson(json.decode(str));

String doctorModelToJson(DoctorModel data) => json.encode(data.toJson());

class DoctorModel {
  int? id;
  String firstname;
  String lastname;
  String email;
  String password;

  DoctorModel({this.id, required this.firstname, required this.lastname, required this.email, required this.password});

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
      firstname: json["firstname"], lastname: json["lastname"],
      email: json["email"],
      password: json["password"],
      id: json["id"]);

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        'id': id,
      };
  String get _firstname => firstname;
  String get _lastname => lastname;
  String get _email => email;
  String get _password => password;
}