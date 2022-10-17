import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neighborhood_doctors/pages/doctor/selectedPatient.dart';

class PatientInfo extends StatefulWidget {
  const PatientInfo({Key? key, required this.title, required this.jwt}) : super(key: key);
  final String title;
  final String jwt;
  
  @override
  State<StatefulWidget> createState() {
    return PatientInfoState(this.jwt);
  }
}

class PatientInfoState extends State<PatientInfo> {
  final _formKey = GlobalKey<FormState>();
  final String jwt;
  PatientInfoState(this.jwt);



  List<Map<String, dynamic>> patients = [{"firstname": ""}];
  Future<List<Map<String, dynamic>>> allPatients(String jwt, BuildContext context) async {
    patients.clear();
    Uri urlViewPatients = Uri.parse("http://10.0.2.2:8080/patient/retrieveAllPatients");
    // Return list in json format
    var response = await http.post(urlViewPatients, body: jwt);

    // Convert to list of maps
    //https://stackoverflow.com/questions/51601519/how-to-decode-json-in-flutter

    final entries = json.decode(response.body);
    List<dynamic> patients_dynamic = entries;
    int num_patients = patients_dynamic.length;

    List<Map<String, dynamic>> patient_list = [{"firstname": ""}];
    patient_list.clear();
    for (int i = 0; i < num_patients; i++) {
      Map<String, dynamic> cur = patients_dynamic[i];
      patient_list.add(cur);
    }
    List<Map<String, dynamic>> r = patient_list;
    if (response.statusCode == 200) {
      patients = r;
      return r;
    } else {
      return r;
    }
  }

  TextEditingController searchBarController = TextEditingController();
  String searchResult = "";
  List<Map<String, dynamic>> test = [{"firstname": "", "lastname": "", "nameother": "", "gender": "", "age": 0}];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Neighborhood Doctors Pages')
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body:
        FutureBuilder<List<Map<String, dynamic>>>(
          future: allPatients(jwt, context),
          builder: (jwt, context) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Patients',
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
                                    'Firstname',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'Lastname',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'Name/other',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'Gender',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'Age',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )
                              ),
                            ),
                          ],
                          showCheckboxColumn: false,
                          rows: patients.map(
                              ((element) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(element["firstname"])),
                                    DataCell(Text(element["lastname"])),
                                    DataCell(Text(element["nameother"])),
                                    DataCell(Text(element["gender"])),
                                    DataCell(Text(element["age"].toString()))
                                  ],
                                  onSelectChanged: (value) {
                                    Navigator.push(
                                        this.context,
                                        MaterialPageRoute(
                                        builder: (context) => SelectedPatient(
                                            jwt: this.jwt,
                                            patID: element["id"]
                                        )));
                                    // Retrieve elements details and open patient health info specific to patient
                                    print(element["firstname"] + " has been pressed");

                                  }))).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
    );
  }
}
