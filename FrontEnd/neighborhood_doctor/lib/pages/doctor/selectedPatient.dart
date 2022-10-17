import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SelectedPatient extends StatefulWidget {
  const SelectedPatient({Key? key, required this.jwt, required this.patID}) : super(key: key);
  final String jwt;
  final int patID;

  @override
  State<StatefulWidget> createState() {
    return SelectedPatientState(this.jwt, this.patID);
  }
}

class SelectedPatientState extends State<SelectedPatient> {
  final _formKey = GlobalKey<FormState>();

  final String jwt;
  final int patID;
  SelectedPatientState(this.jwt, this.patID);


  List<Map<String, dynamic>> symptoms = [
    {"name": ""}
  ];

  Future<List<Map<String, dynamic>>> allSymptoms(
      String token, BuildContext context) async {
    var patientId = patID; //
    symptoms.clear();
    Uri urlViewSymptoms =
    Uri.parse("http://10.0.2.2:8080/symptoms/retrieveAllSymptoms");
    // Return list in json format
    var response = await http.post(urlViewSymptoms, body: token);
    debugPrint(response.body);
    // Convert to list of maps
    //https://stackoverflow.com/questions/51601519/how-to-decode-json-in-flutter
    final entries = json.decode(response.body);
    List<dynamic> symptoms_dynamic = entries;
    int num_symptoms = symptoms_dynamic.length;

    List<Map<String, dynamic>> symptom_list = [
      {"name": ""}
    ];
    symptom_list.clear();
    for (int i = 0; i < num_symptoms; i++) {
      Map<String, dynamic> cur = symptoms_dynamic[i];
      if (cur["patientId"] == patientId) {
        symptom_list.add(cur);
      }
    }
    List<Map<String, dynamic>> r = symptom_list;

    var wait = await allPrescriptions(token, context, patientId);
    if (response.statusCode == 200) {
      symptoms = r;
      return r;
    } else {
      return r;
    }
  }

  List<Map<String, dynamic>> prescriptions = [
    {"name": ""}
  ];
  Future<List<Map<String, dynamic>>> allPrescriptions(
      String token, BuildContext context, int? patientId) async {
    prescriptions.clear();
    Uri urlViewPrescriptions = Uri.parse(
        "http://10.0.2.2:8080/prescriptions/retrieveAllprescriptions");
    var response = await http.post(urlViewPrescriptions, body: token);

    debugPrint(response.body);

    final entries = json.decode(response.body);
    List<dynamic> prescriptions_dynamic = entries;
    int num_prescriptions = prescriptions_dynamic.length;

    List<Map<String, dynamic>> prescription_list = [
      {"date": ""}
    ];
    prescription_list.clear();
    for (int i = 0; i < num_prescriptions; i++) {
      Map<String, dynamic> cur = prescriptions_dynamic[i];
      if (cur["patientId"] == patientId) {
        prescription_list.add(cur);
      }
    }
    List<Map<String, dynamic>> p = prescription_list;
    if (response.statusCode == 200) {
      prescriptions = p;
      return p;
    } else {
      return p;
    }
  }

  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController updatedescriptionController = TextEditingController();
  TextEditingController updatenameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    //read all symptoms into symptoms
    return Scaffold(
        appBar: AppBar(title: Text('Neighborhood Doctors Pages')),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: FutureBuilder<List<List<Map<String, dynamic>>>>(
          future: Future.wait([allSymptoms(jwt, context)]),
          builder: (jwt, context) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Symptoms',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Form(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'Name',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'Severity',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'Note',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )),
                            )
                          ],
                          showCheckboxColumn: false,
                          rows: symptoms
                              .map(((element) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(element["name"])),
                                DataCell(Text(element["severity"])),
                                DataCell(Text(element["note"])),
                              ],
                              onSelectChanged: (value) {
                                openInfoDialog(element["name"], element["severity"], element["note"]);
                              })))
                              .toList(),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 60,
                    ),
                    Form(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'Name',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'Prescribed on',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'Description',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )),
                            )
                          ],
                          showCheckboxColumn: false,
                          rows: prescriptions
                              .map(((element) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(element["name"])),
                                DataCell(Text(element["date"])),
                                DataCell(Text(element["description"])),
                              ],
                              onSelectChanged: (value) {
                                openUpdateDialog(
                                    element["id"]);
                              })))
                              .toList(),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Add Prescription'),
                      onPressed: () {
                        openAddDialog();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }


  Future openAddDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text("Add Prescription"),
          content: Column(children: <Widget>[
            TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Enter Prescription Name',
                )),
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Enter description',
                )),
            ElevatedButton(
              child: Text('Add Prescription'),
              onPressed: () async {
                addPrescription(jwt, nameController.text, descriptionController.text,);
                Navigator.of(context, rootNavigator: true).pop('dialog');
                await new Future.delayed((const Duration(milliseconds: 1)));
                setState(() {});
                },
            )
          ])));

  Future openInfoDialog(
      String name, String severity, String note) =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: Text("Symptom Details"),
              content: Text("Symptom: " +
                  name +
                  "\nSeverity: " +
                  severity +
                  "\nAdditional Notes: " +
                  note)));

  Future openUpdateDialog(int id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text("Update Prescription"),
          content: Column(children: <Widget>[
            TextField(
                controller: updatenameController,
                decoration: InputDecoration(
                  labelText: 'Enter Prescription Name',
                )),
            TextField(
                controller: updatedescriptionController,
                decoration: InputDecoration(
                  labelText: 'Enter description',
                )),
            ElevatedButton(
              child: Text('Edit Prescription'),
              onPressed: () {
                updatePrescription(id, jwt, updatedescriptionController.text,
                    updatenameController.text);
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            )
          ])));

}
Future<String> getId(String jwt) async {
  Uri urlViewPatients = Uri.parse("http://10.0.2.2:8080/patient/getId");
  // Return id for patient
  var response = await http.post(urlViewPatients, body: jwt);
  String tempStr = response.body;
  tempStr = tempStr.substring(1, tempStr.length - 1);
  final fin_response = json.decode(tempStr);
  print(tempStr);
  dynamic dyn_response = fin_response;
  Map<String, dynamic> responseMap = dyn_response;
  print(responseMap["id"].toString());
  if (response.statusCode == 200) {
    return (responseMap["id"].toString()); //{"id": 1}
  } else {
    return "";
  }
}

Future<void> addPrescription(
    String token, String name, String description) async {
  var tempId = await getId(token);
  var patientId = int.tryParse(
      tempId);
  Uri url = Uri.parse("http://10.0.2.2:8080/prescription/createPrescription");
  var response = await http.post(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "patientId": patientId,
        "description": description,
        "name": name,
      }));
}

// Not for M2
Future<void> updatePrescription(int presId, String token, String description,
    String name) async {
  var tempId = await getId(token);
  var patientId = int.tryParse(
      tempId);
  print("ALL STATS" + presId.toString() + patientId.toString() + description + name);
  Uri url = Uri.parse("http://10.0.2.2:8080/prescription/updatePrescription");
  debugPrint("PRESSED");
  var response = await http.put(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "id": presId,
        "description": description,
        "name": name,
      }));
}