import 'package:flutter/material.dart';
import 'package:neighborhood_doctors/pages/doctor/chatDoc.dart';
import 'package:neighborhood_doctors/pages/doctor/patientHealthInfoDovView.dart';
import 'package:neighborhood_doctors/pages/doctor/editAvailability.dart';
import 'package:neighborhood_doctors/pages/doctor/viewAppointmentsDocView.dart';
import 'package:neighborhood_doctors/pages/doctor/editAvailability.dart';

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
