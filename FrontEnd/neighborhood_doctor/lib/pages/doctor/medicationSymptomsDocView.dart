import 'package:flutter/material.dart';
import 'package:neighborhood_doctors/Model/SymptomModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// https://flutterawesome.com/login-ui-made-with-flutter/
// https://github.com/hawier-dev/flutter-login-ui/blob/main/lib/main.dart

class MedicationSymptomsDoctor extends StatefulWidget {
  const MedicationSymptomsDoctor(
      {Key? key, required this.title, required this.id})
      : super(key: key);
  final String title;
  final int id;
  @override
  State<StatefulWidget> createState() {
    return MedicationSymptomsDoctorState(this.id, this.title);
  }
}

class MedicationSymptomsDoctorState extends State<MedicationSymptomsDoctor> {
  final int id;
  final String title;
  MedicationSymptomsDoctorState(this.id, this.title);

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
    readSymptoms(0);
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
                    children: _symptomList.map((symptom) {
                      //display data dynamically from namelist List.
                      return TableRow(//return table row in every loop
                          children: [
                        //table cells inside table row
                        TableCell(
                            child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(symptom.id.toString()))),
                        TableCell(
                            child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(symptom.name))),
                        // TableCell(
                        //     child: Padding(
                        //         padding: EdgeInsets.all(5),
                        //         child: Text(symptom.severity))),
                        // TableCell(
                        //     child: Padding(
                        //         padding: EdgeInsets.all(5),
                        //         child: Text(symptom.notes))),
                      ]);
                    }).toList(),
                  ),
                  // ElevatedButton(
                  //     onPressed: addSymptom(),
                  //     child: const Text("add Symptom")),
                ])));
  }
}

class ResponseAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const ResponseAlertDialog({
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

Future<void> addSymptom(int doctorId, String symptom) async {
  Uri url = Uri.parse("http://10.0.2.2:8080/symptom/createSymptom");
  var response = await http.post(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "name": symptom,
        "doctorId": doctorId,
      }));
}

Future<void> deleteSymptom(int doctorId, String symptom) async {
  Uri url = Uri.parse("http://10.0.2.2:8080/symptom/deleteSymptom");
  var response = await http.post(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "name": symptom,
        "doctorId": doctorId,
      }));
}

Future<void> updateSymptom(int doctorId, String symptom) async {
  Uri url = Uri.parse("http://10.0.2.2:8080/symptom/updateSymptom");
  var response = await http.post(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "name": symptom,
        "doctorId": doctorId,
      }));
}

Future<void> readSymptoms(int patientId) async {
  List<SymptomModel> symptoms = [];

  //get list of symptoms
  Uri url = Uri.parse("http://10.0.2.2:8080/symptom/getLength");
  var length = await http.post(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{}));

  if (int.parse(length.body) != 0) {
    for (int i = 0; i < int.parse(length.body); i++) {
      Uri url = Uri.parse("http://10.0.2.2:8080/symptom/readSymptoms");
      var response = await http.post(url,
          headers: <String, String>{
            "Content-Type": "application/json",
          },
          body: jsonEncode(
              <String, dynamic>{"patientId": patientId, "symptomId": i}));
      SymptomModel curSymptom =
          SymptomModel(name: response.body, patientId: response.body);
      //add response to list
      symptoms.add(curSymptom);
    }
  }
  //_symptomList = symptoms;
}

int getMaxId() {
  return 0;
}
