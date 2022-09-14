import 'dart:convert';

PatientModel patientModelJson(String str) =>
    PatientModel.fromJson(json.decode(str));

String patientModelToJson(PatientModel data) => json.encode(data.toJson());

class PatientModel {
  int? id;
  String firstname;
  String lastname;
  String nameother;
  int age;
  String gender;
  String address;
  String phonenumber;
  String email;
  String password;

  PatientModel({this.id, required this.firstname, required this.lastname, required this.nameother, 
              required this.age, required this.gender, required this.address, required this.phonenumber, required this.email, required this.password});

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
      firstname: json["firstname"], lastname: json["lastname"],
      nameother: json["nameother"],
      age: json["age"],
      gender: json["gender"],
      address: json["address"],
      phonenumber: json["phonenumber"],
      email: json["email"],
      password: json["password"],
      id: json["id"]);

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "nameother": nameother,
        "age": age,
        "gender": gender,
        "address": address,
        "phoneNumber": phonenumber,
        "email": email,
        "password": password,
        'id': id,
      };
  String get _firstname => firstname;
  String get _lastname => lastname;
  String get _nameother => nameother;
  int get _age => age;
  String get _gender => gender;
  String get _address => address;
  String get _phonenumber => phonenumber;
  String get _email => email;
  String get _password => password;
}
