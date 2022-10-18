import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class selectedSymptom extends StatefulWidget {
  const selectedSymptom({Key? key, required this.jwt, required this.symID}) : super(key: key);
  final String jwt;
  final int symID;

  @override
  State<StatefulWidget> createState() {
    return selectedSymptomState(this.jwt, this.symID);
  }
}

class selectedSymptomState extends State<selectedSymptom> {
  final _formKey = GlobalKey<FormState>();

  final String jwt;
  final int symID;
  selectedSymptomState(this.jwt, this.symID);

  late Map<String, dynamic> symptom;
  Future<Map<String, dynamic>> getSymptomInfo(BuildContext context, String jwt, int id) async {
    Uri urlPat = Uri.parse("https://neighborhood-doctors-backend.herokuapp.com/symptom/getSymptom");
    var list = <String>[];
    list.add(jwt);
    list.add(id.toString());
    var response = await http.post(urlPat, body: 1);

    print(response.body);

    final ret_symptom = json.decode(response.body);
    Map<String, dynamic> s = ret_symptom;
    if (response.statusCode == 200) {
      symptom = s;
      return s;
    } else {
      return s;
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Symptom Information')),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: FutureBuilder<Map<String, dynamic>>(
            future: getSymptomInfo(context, jwt, symID),
            builder: (jwt, context) {
              return Container(


                child: ElevatedButton(
                  child: Text('Edit Symptom'),
              onPressed: () {
              openUpdateDialog();
              },
              )


              );
            }
        )
    );
  }


  Future openUpdateDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text("New Symptom"),
          content: Column(children: <Widget>[
            // TextField(
            //     controller: symptomController,
            //     decoration: InputDecoration(
            //       icon: Icon(Icons.timer),
            //       labelText: 'Enter Symptom Name',
            //     )),
            // TextField(
            //     controller: severityController,
            //     decoration: InputDecoration(
            //       icon: Icon(Icons.timer),
            //       labelText: 'Enter severity',
            //     )),
            // TextField(
            //   controller: notesController,
            //   decoration: InputDecoration(
            //     icon: Icon(Icons.timer),
            //     labelText: 'Enter notes here',
            //   ),
            // ),
            ElevatedButton(
              child: Text('Update Symptom'),
              onPressed: () {
                // addSymptom(jwt, symptomController.text, severityController.text,
                //     notesController.text);
              },
            )
          ])));
}