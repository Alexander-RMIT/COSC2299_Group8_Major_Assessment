import 'package:flutter/material.dart';
import 'package:neighborhood_doctors/pages/login.dart';
import 'package:neighborhood_doctors/pages/navigationBar.dart';
import 'package:neighborhood_doctors/pages/patient/chatPat.dart';
import 'package:neighborhood_doctors/Model/PatientModel.dart';
import 'package:neighborhood_doctors/pages/patient/medicationSymtpomsPatView.dart';
import 'package:neighborhood_doctors/pages/patient/patientHealthInfoPatView.dart';
import 'package:neighborhood_doctors/pages/patient/scheduleAppointment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

class NavigationBarLanding extends StatefulWidget {
  final String jwt;
  NavigationBarLanding(this.jwt);
  @override
  State<StatefulWidget> createState() {
    return NavBarLandingState(this.jwt);
  }
}

class NavBarLandingState extends State<NavigationBarLanding> {
  final String jwt;
  NavBarLandingState(this.jwt);

  // Set at runtime instead of compile time
  String _fname = "";

  Future<String> userFirstName(String jwt, BuildContext context) async {
    Uri urlPatientName = Uri.parse("https://neighborhood-doctors-backend.herokuapp.com/patient/firstname");

    var response = await http.post(urlPatientName, body: jwt);
    String strResponse = response.body;
    print("NAME:" + strResponse);
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
      appBar: AppBar(title: Text('Neighborhood Doctors Pages')),
      body: FutureBuilder<String>(
        future: userFirstName(jwt, context),
        builder: (firstname, context) {
          if (firstname != "") {
            String welcomeMsg = "Welcome to \nNeighborhood Doctors \n$_fname";
            return Center(child: Text(welcomeMsg, textAlign: TextAlign.center,
            style: TextStyle(
            fontSize: 15,
            foreground: Paint()
            ..shader = ui.Gradient.linear(
            const Offset(0, 20),
            const Offset(300, 20),
        <Color>[
          Color.fromARGB(255, 209, 16, 248),
          Color.fromARGB(223, 0, 195, 255),
        ],
      )
    ),));
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            chatPatient(title: 'Chat', jwt: jwt)));
              },
            ),
            ListTile(
              title: Text('View health information'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PatientHealthInfo(title: 'Health Information')));
              },
            ),
            ListTile(
              title: Text('View Symptoms'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MedicationSymptomsPatient(
                            title: 'Medication/Symptoms', jwt: jwt)));
              },
            ),
            ListTile(
              title: Text('Schedule Appointment'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => ScheduleAppointment.Schedule(1)));
              },
            ),
            ListTile(
                title: Text('Sign out'),
                onTap: () {
                  // Navigator.push(context,
                  //   MaterialPageRoute(builder: (context) => NavigationBarLanding()));
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                }
                ),

          ],
        ),
      ),
    );
  }
}
