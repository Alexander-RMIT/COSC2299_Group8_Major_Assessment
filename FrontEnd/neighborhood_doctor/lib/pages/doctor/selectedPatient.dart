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

  late Map<String, dynamic> patient;
  Future<Map<String, dynamic>> getPatientInformation(BuildContext context, String jwt, int id) async {
    Uri urlPat = Uri.parse("http://10.0.2.2:8080/patient/retrieveAllPatients");
    var list = <String>[];
    list.add(jwt);
    list.add(id.toString());
    var response = await http.post(urlPat, body: list);

    print(response.body);

    final ret_patient = json.decode(response.body);
    Map<String, dynamic> p = ret_patient;

    if (response.statusCode == 200) {
      patient = p;
      return p;
    } else {
      return p;
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Patient Information')),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: FutureBuilder<Map<String, dynamic>>(
          future: getPatientInformation(context, jwt, patID),
          builder: (jwt, context) {
            return Container(

            );
          }
        )
    );
  }

}