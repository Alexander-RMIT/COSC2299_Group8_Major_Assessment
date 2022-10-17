import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SelectedDoctor extends StatefulWidget {
  const SelectedDoctor({Key? key, required this.jwt, required this.docID}) : super(key: key);
  final String jwt;
  final int docID;

  @override
  State<StatefulWidget> createState() {
    return SelectedDoctorState(this.jwt, this.docID);
  }
}

class SelectedDoctorState extends State<SelectedDoctor> {
  final _formKey = GlobalKey<FormState>();

  final String jwt;
  final int docID;
  SelectedDoctorState(this.jwt, this.docID);

  late Map<String, dynamic> doctor;
  Future<Map<String, dynamic>> getDoctorInformation(BuildContext context, String jwt, int id) async {
    Uri urlDoc = Uri.parse("http://10.0.2.2:8080/doctor/retrieveAllDoctors");
    var list = <String>[];
    list.add(jwt);
    list.add(id.toString());
    var response = await http.post(urlDoc, body: list);

    print(response.body);

    final ret_doctor = json.decode(response.body);
    Map<String, dynamic> d = ret_doctor;

    if (response.statusCode == 200) {
      doctor = d;
      return d;
    } else {
      return d;
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Doctor Information')),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: FutureBuilder<Map<String, dynamic>>(
          future: getDoctorInformation(context, jwt, docID),
          builder: (jwt, context) {
            return Container(

            );
          }
        )
    );
  }

}