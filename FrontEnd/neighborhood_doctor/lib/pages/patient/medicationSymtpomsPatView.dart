import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
//import 'package:neighborhood_doctors/Model/AdminModel.dart';
import 'package:neighborhood_doctors/Model/PatientModel.dart';
import 'package:neighborhood_doctors/pages/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// https://flutterawesome.com/login-ui-made-with-flutter/
// https://github.com/hawier-dev/flutter-login-ui/blob/main/lib/main.dart

class MedicationSymptomsPatient extends StatefulWidget {
  const MedicationSymptomsPatient({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return MedicationSymptomsPatientState();
  }
}

Future<PatientModel> userMedicationSymptomsPatient(
    String firstname,
    String lastname,
    String nameother,
    int age,
    String gender,
    String address,
    String phonenumber,
    String email,
    String password,
    BuildContext context) async {
  Uri url = Uri.parse("http://localhost:8080/patient/createSymptom");
  var response = await http.post(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "firstname": firstname,
        "lastname": lastname,
        "nameother": nameother,
        "age": age,
        "gender": gender,
        "address": address,
        "phoneNumber": phonenumber,
        "email": email,
        "password": password,
      }));

  String strResponse = response.body;

  if (response.statusCode == 200) {
    // PatientModel patient = PatientModel(firstname: firstname, lastname: lastname, nameother: nameother, age: age, gender: gender, address: address, phonenumber: phonenumber, email: email, password: password);
    // return patient;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return ResponseAlertDialog(
            title: 'Backend response', content: response.body);
      },
    );
  } else {
    throw "Unable to get a backend response.";
  }

  throw NullThrownError();
}

class MedicationSymptomsPatientState extends State<MedicationSymptomsPatient> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  //TextEditingController nameOtherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Neighborhood Doctors Pages')),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Table(
                    border: TableBorder.all(color: Colors.white),
                    children: [
                      TableRow(children: [
                        Text('Symptom'),
                        Text('Severity'),
                        Text('Notes'),
                      ]),
                      TableRow(children: [
                        Text('Cough'),
                        Text('4'),
                        Text('none'),
                      ]),
                    ],
                  ),
                ])));
  }
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
