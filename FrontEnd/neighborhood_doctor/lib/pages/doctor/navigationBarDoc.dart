import 'package:flutter/material.dart';
import 'package:neighborhood_doctors/pages/doctor/chatDoc.dart';
import 'package:neighborhood_doctors/pages/doctor/patientHealthInfoDovView.dart';
import 'package:neighborhood_doctors/pages/doctor/editAvailability.dart';
import 'package:neighborhood_doctors/pages/doctor/viewAppointmentsDocView.dart';
import 'package:neighborhood_doctors/pages/doctor/editAvailability.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

class NavigationBarDoc extends StatefulWidget {
  final String jwt;
  NavigationBarDoc(this.jwt);

  @override
  State<StatefulWidget> createState() {
    return NavBarStateDoc(this.jwt);
  }
}

class NavBarStateDoc extends State<NavigationBarDoc> {
  final String jwt;
  NavBarStateDoc(this.jwt);

  // Set at runtime instead of compile time
  String _fname = "";

  Future<String> userFirstName(String jwt, BuildContext context) async {
    Uri urlDcotorName = Uri.parse("http://10.0.2.2:8080/doctor/firstname");

    var response = await http.post(urlDcotorName, body: jwt);
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
                        builder: (context) => ChatDoctor(
                              title: 'Chat',
                              jwt: jwt,
                            )));
              },
            ),
            ListTile(
              title: Text('View patient health information'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PatientHealthInfoDoctor(
                            title: 'Health Information', jwt: jwt)));
              },
            ),
            ListTile(
              title: Text('Edit availability'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorAvailability(jwt)));
              },
            ),
            ListTile(
                title: Text('Sign out'),
                onTap: () {
                  // Navigator.push(context,
                  //   MaterialPageRoute(builder: (context) => NavigationBarLanding()));
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                })
          ],
        ),
      ),
    );
  }
}
