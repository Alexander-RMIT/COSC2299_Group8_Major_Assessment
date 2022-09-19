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
  const MedicationSymptomsPatient({Key? key, required this.id})
      : super(key: key);
  final int id;

  @override
  State<StatefulWidget> createState() {
    return MedicationSymptomsPatientState();
  }
}

class MedicationSymptomsPatientState extends State<MedicationSymptomsPatient> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  //TextEditingController nameOtherController = TextEditingController();
  TextEditingController symptomController = TextEditingController();
  TextEditingController severityController = TextEditingController();
  TextEditingController notesController = TextEditingController();

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
                      TableRow(children: [
                        ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String symptom = symptomController.text;

                          print(symptom);
                          print("has been pressed");

                          var createSymptom = addSymptom(id, symptom);

                        symptomController.text = '';
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      ),
                      child: const Text(
                        'Add symptom',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ])
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


Future<void> addSymptom(int patientId, String symptom) async{
  Uri url = Uri.parse("http://10.0.2.2:8080/symptom/createSymptom");
  var response = await http.post(
      url, 
      headers: <String, String>{"Content-Type": "application/json", },
      body: jsonEncode(<String, dynamic>{
        "name" : symptom,
        "patientId" : patientId,
  }));

}

Future<void> deleteSymptom(int patientId, String symptom) async {
  Uri url = Uri.parse("http://10.0.2.2:8080/symptom/deleteSymptom");
  var response = await http.post(
      url, 
      headers: <String, String>{"Content-Type": "application/json", },
      body: jsonEncode(<String, dynamic>{
        "name" : symptom,
        "patientId" : patientId,
  }));
}

Future<void> updateSymptom(int patientId, String symptom) async {
  Uri url = Uri.parse("http://10.0.2.2:8080/symptom/updateSymptom");
  var response = await http.post(
      url, 
      headers: <String, String>{"Content-Type": "application/json", },
      body: jsonEncode(<String, dynamic>{
        "name" : symptom,
        "patientId" : patientId,
  }));
}