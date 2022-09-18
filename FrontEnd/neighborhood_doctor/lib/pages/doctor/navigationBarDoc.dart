import 'package:flutter/material.dart';
import 'package:neighborhood_doctors/pages/doctor/chatDoc.dart';
import 'package:neighborhood_doctors/pages/doctor/patientHealthInfoDovView.dart';
import 'package:neighborhood_doctors/pages/doctor/editAvailability.dart';
import 'package:neighborhood_doctors/pages/doctor/viewAppointmentsDocView.dart';
import 'package:neighborhood_doctors/pages/doctor/editAvailability.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NavigationBarDoc extends StatefulWidget{
  final int id;
  NavigationBarDoc(this.id);

  @override
  State<StatefulWidget> createState() {
    return NavBarStateDoc(this.id);
  }
}

class NavBarStateDoc extends State<NavigationBarDoc> {
  final int id;
  NavBarStateDoc(this.id);

  // Set at runtime instead of compile time
  String _fname = "";

  Future<String> userFirstName(int id, BuildContext context) async {
    Uri urlDcotorName = Uri.parse("http://10.0.2.2:8080/doctor/firstname");

    var response = await http.post(urlDcotorName,
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
      body: FutureBuilder<String>(
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
                        builder: (context) => ChatDoctor(title: 'Chat')));
              },
            ),
            ListTile(
              title: Text('View patient health information'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => PatientHealthInfoDoctor(title: 'Health Information')));
              },
            ),
            ListTile(
              title: Text('Edit availability'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => DoctorAvailability(title: 'Edit availability')));
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
