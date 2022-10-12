import 'package:flutter/material.dart';
import 'package:neighborhood_doctors/Model/SymptomModel.dart';
import 'selectedSymptom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:neighborhood_doctors/pages/patient/selectedSymptom.dart';

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

  //Need to get this to find patient ID
  // Future<int> getId(String jwt, BuildContext context) async {
  //   Uri urlViewPatients = Uri.parse("http://10.0.2.2:8080/auth/patient/id");
  //   // Return id for patient
  //   var response = await http.post(urlViewPatients, body: jwt);
  //   Map<String, dynamic> fin_response = jsonDecode(response.body);
  //   return (fin_response['patientId']);
  // }

  List<Map<String, dynamic>> symptoms = [
    {"name": ""}
  ];
  Future<List<Map<String, dynamic>>> allSymptoms(
      String token, BuildContext context) async {
    int patientId= 1; //Change one to getId(token, context) when its working
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
      if(cur["patientId"] == patientId) {
        symptom_list.add(cur);
      }
    }
    List<Map<String, dynamic>> r = symptom_list;
    if (response.statusCode == 200) {
      symptoms = r;
      return r;
    } else {
      return r;
    }
  }

  late List<SymptomModel> _symptomList;

  @override
  void initState() {
    _symptomList = [];

    super.initState();
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
    return Scaffold(
        appBar: AppBar(title: Text('Neighborhood Doctors Pages')),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: allSymptoms(jwt, context),
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
                                    'name',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'severity',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'note',
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
                              Navigator.push(
                                  this.context,
                                  MaterialPageRoute(
                                      builder: (context) => selectedSymptom(
                                          jwt: this.jwt,
                                          symID: element["id"]
                                      )));
                              // Retrieve elements details and open patient health info specific to patient
                              print(element["firstname"] + " has been pressed");

                            }
                          )))
                              .toList(),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Add Symptom'),
                      onPressed: () {
                        openAddDialog();
                      },
                    )
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
        "patientId": 1, //Change one to getId(token, context) when its working, //works when patientId is passed to it
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

// Not for M2
Future<void> updateSymptom(int patientId, int symptomId) async {
  Uri url = Uri.parse("http://10.0.2.2:8080/symptom/updateSymptom");
  var response = await http.post(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "name": symptomId,
        "patientId": patientId,
      }));
}