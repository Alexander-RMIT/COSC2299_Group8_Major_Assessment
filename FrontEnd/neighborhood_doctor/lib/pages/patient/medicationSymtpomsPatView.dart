import 'package:flutter/material.dart';
import 'package:neighborhood_doctors/Model/SymptomModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:neighborhood_doctors/pages/navigationBar.dart';

// https://flutterawesome.com/login-ui-made-with-flutter/
// https://github.com/hawier-dev/flutter-login-ui/blob/main/lib/main.dart

class MedicationSymptomsPatient extends StatefulWidget {
  const MedicationSymptomsPatient(
      {Key? key, required this.title, required this.jwt})
      : super(key: key);
  final String title;
  final String jwt;
  @override
  State<StatefulWidget> createState() {
    return MedicationSymptomsPatientState(this.jwt, this.title);
  }
}

class MedicationSymptomsPatientState extends State<MedicationSymptomsPatient> {
  final String jwt;
  final String title;
  MedicationSymptomsPatientState(this.jwt, this.title);

  late List<SymptomModel> _symptomList;

  @override
  void initState() {
    _symptomList = [];

    super.initState();
  }

  Future<void> readSymptoms(int patientId) async {
    Uri uriReadSymptoms =
        Uri.parse("http://10.0.2.2:8080/symptom/readSymptoms");

    var response = await http.get(
      uriReadSymptoms,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );
    String strResponse = response.body;

    var parsedJson = jsonDecode(strResponse);

    int len = parsedJson.length;
    List<SymptomModel> symptomList;
    symptomList = (json.decode(response.body) as List)
        .map((i) => SymptomModel.fromJson(i))
        .toList();

    _symptomList = symptomList;
  }

  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  //TextEditingController nameOtherController = TextEditingController();
  TextEditingController symptomController = TextEditingController();
  TextEditingController severityController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //read all symptoms into symptoms
    readSymptoms(1);
    return Scaffold(
        appBar: AppBar(title: Text('Neighborhood Doctors Pages')),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Text('Add Symptom'),
                    onPressed: () {
                      openAddDialog();
                    },
                  )
                  // ElevatedButton(
                  //     onPressed: addSymptom(),
                  //     child: const Text("add Symptom")),
                ])));
  }

  Future openAddDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text("New Symptom"),
          content: Column(children: <Widget>[
            TextField(
                controller: symptomController,
                decoration: InputDecoration(
                  icon: Icon(Icons.timer),
                  labelText: 'Enter Symptom Name',
                )),
            TextField(
                controller: severityController,
                decoration: InputDecoration(
                  icon: Icon(Icons.timer),
                  labelText: 'Enter severity',
                )),
            TextField(
              controller: notesController,
              decoration: InputDecoration(
                icon: Icon(Icons.timer),
                labelText: 'Enter notes here',
              ),
            ),
            ElevatedButton(
              child: Text('Add Symptom'),
              onPressed: () {
                addSymptom(jwt, symptomController.text, severityController.text,
                    notesController.text);
              },
            )
          ])));
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

Future<void> addSymptom(
    String token, String symptom, String severity, String notes) async {
  Uri url = Uri.parse("http://10.0.2.2:8080/symptom/createSymptom");
  var response = await http.post(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "name": symptom,
        "jwt": token,
        "severity": severity,
        "note": notes,
      }));
}
//Not for M2
// Future<void> deleteSymptom(int patientId, String symptom) async {
//   Uri url = Uri.parse("http://10.0.2.2:8080/symptom/deleteSymptom");
//   var response = await http.post(url,
//       headers: <String, String>{
//         "Content-Type": "application/json",
//       },
//       body: jsonEncode(<String, dynamic>{
//         "name": symptom,
//         "patientId": patientId,
//       }));
// }

//Not for M2
// Future<void> updateSymptom(int patientId, String symptom) async {
//   Uri url = Uri.parse("http://10.0.2.2:8080/symptom/updateSymptom");
//   var response = await http.post(url,
//       headers: <String, String>{
//         "Content-Type": "application/json",
//       },
//       body: jsonEncode(<String, dynamic>{
//         "name": symptom,
//         "patientId": patientId,
//       }));
// }

