import 'package:flutter/material.dart';
import 'package:neighborhood_doctors/pages/login.dart';
import 'package:neighborhood_doctors/pages/navigationBar.dart';
import 'package:neighborhood_doctors/pages/patient/chatPat.dart';
import 'package:neighborhood_doctors/Model/PatientModel.dart';
import 'package:neighborhood_doctors/pages/patient/patientHealthInfoPatView.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class NavigationBarLanding extends StatefulWidget{
  final int id;
  NavigationBarLanding(this.id);
  @override
  State<StatefulWidget> createState() {
    return NavBarLandingState(this.id);
  }
}

class NavBarLandingState extends State<NavigationBarLanding> {
  final int id;
  NavBarLandingState(this.id);

  // Set at runtime instead of compile time
  String _fname = "";

  Future<String> userFirstName(int id, BuildContext context) async {
    Uri urlPatientName = Uri.parse("http://10.0.2.2:8080/patient/firstname");

    var response = await http.post(urlPatientName,
        headers: <String, String>{"Content-Type": "application/json", },
        body: jsonEncode(<String, dynamic>{
          "id": id,
        }));
    String strResponse = response.body;

    if (response.statusCode == 200) {
      _fname = strResponse;
      return strResponse;
    } else {
      return strResponse;
    }
  }


  final minimumPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Neighborhood Doctors Pages')
      ),
      body:
          FutureBuilder<String>(
            future: userFirstName(id, context),
            builder: (firstname, context) {
              if (firstname != "") {
                String welcomeMsg = "Welcome to \nNeighborhood Doctors \n$_fname";
                return Center(child: Text(welcomeMsg, textAlign: TextAlign.center));
              } else {
                return Center(child: Text("Welcome to Neighborhood Doctors"));
              }
            },
          ),
          //Center(child: Text(welcomeMsg)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
          children: <Widget>[
            const SizedBox(
              height: 84,
              child: DrawerHeader(
                child: Text('Neighborhood Doctor management'),
                decoration: BoxDecoration(
                  color: Colors.purple,
                ),
              ),
            ),
            ListTile(
              title: Text('Chat'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => ChatPatient(title: 'Chat')));
              },
            ),
            ListTile(
              title: Text('View health information'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => PatientHealthInfo(title: 'Health Information')));
              },
            ),
            ListTile(
              title: Text('Sign out'),
              onTap: () {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => NavigationBarLanding()));
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);

              }
            )
          ],
        ),
      ),
    );
  }
}


