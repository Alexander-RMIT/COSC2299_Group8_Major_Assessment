import 'package:flutter/material.dart';
import 'package:neighborhood_doctors/pages/login.dart';
import 'package:neighborhood_doctors/pages/patient/chatPat.dart';
import 'package:neighborhood_doctors/pages/patient/patientHealthInfoPatView.dart';

// Navigation bar specific to the general landing page that doesnt have user heirarchy

class NavigationBarLanding extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return NavBarLandingState();
  }
}

class NavBarLandingState extends State<NavigationBarLanding> {
  final minimumPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Neighborhood Doctors Pages')
      ),
      body: Center(child: Text('Welcome to the Neighborhood Doctors website')),
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
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Login(title: 'Login')));
              }
            )
          ],
        ),
      ),
    );
  }
}
