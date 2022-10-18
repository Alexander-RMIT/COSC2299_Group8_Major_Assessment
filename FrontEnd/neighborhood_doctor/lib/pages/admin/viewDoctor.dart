import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neighborhood_doctors/pages/admin/selectedDoctor.dart';

class DoctorInfo extends StatefulWidget {
  const DoctorInfo({Key? key, required this.title, required this.jwt}) : super(key: key);
  final String title;
  final String jwt;
  
  @override
  State<StatefulWidget> createState() {
    return DoctorInfoState(this.jwt);
  }
}

class DoctorInfoState extends State<DoctorInfo> {
  final _formKey = GlobalKey<FormState>();
  final String jwt;
  DoctorInfoState(this.jwt);



  List<Map<String, dynamic>> doctors = [{"firstname": ""}];
  Future<List<Map<String, dynamic>>> allDoctors(String jwt, BuildContext context) async {
    doctors.clear();
    Uri urlViewDoctors = Uri.parse("https://neighborhood-doctors-backend.herokuapp.com/doctor/retrieveAllDoctors");
    // Return list in json format
    var response = await http.post(urlViewDoctors, body: jwt);

    final entries = json.decode(response.body);
    List<dynamic> doctors_dynamic = entries;
    int num_doctors = doctors_dynamic.length;

    List<Map<String, dynamic>> doctor_list = [{"firstname": ""}];
    doctor_list.clear();
    for (int i = 0; i < num_doctors; i++) {
      Map<String, dynamic> cur = doctors_dynamic[i];
      doctor_list.add(cur);
    }
    List<Map<String, dynamic>> r = doctor_list;
    if (response.statusCode == 200) {
      doctors = r;
      return r;
    } else {
      return r;
    }
  }

  TextEditingController searchBarController = TextEditingController();
  String searchResult = "";
  List<Map<String, dynamic>> test = [{"firstname": "", "lastname": "", "email": "", "password": ""}];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Neighborhood Doctors Pages')
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body:
        FutureBuilder<List<Map<String, dynamic>>>(
          future: allDoctors(jwt, context),
          builder: (jwt, context) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Doctors',
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
                                    'Email',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'Password',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )
                              ),
                            ),
                          ],
                          showCheckboxColumn: false,
                          rows: doctors.map(
                              ((element) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(element["firstname"])),
                                    DataCell(Text(element["lastname"])),
                                    DataCell(Text(element["email"])),
                                    DataCell(Text(element["password"]))
                                  ],
                                  onSelectChanged: (value) {
                                    Navigator.push(
                                        this.context,
                                        MaterialPageRoute(
                                        builder: (context) => SelectedDoctor(
                                            jwt: this.jwt,
                                            docID: element["id"]
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