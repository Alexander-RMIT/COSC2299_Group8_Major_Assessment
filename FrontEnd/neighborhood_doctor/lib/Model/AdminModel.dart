import 'dart:convert';

AdminModel adminModelJson(String str) =>
    AdminModel.fromJson(json.decode(str));

String adminModelToJson(AdminModel data) => json.encode(data.toJson());

class AdminModel {
  int? id;
  String username;
  String password;
  String email;

  AdminModel({this.id, required this.username, required this.password, required this.email});

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
      username: json["username"], password: json["password"],
      email: json["email"],
      id: json["id"]);

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
        'id': id,
      };
  String get _username => username;
  String get _password => password;
  String get _email => email;
}