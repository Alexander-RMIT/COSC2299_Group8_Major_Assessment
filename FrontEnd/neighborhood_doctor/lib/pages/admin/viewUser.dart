import 'package:flutter/material.dart';
import 'package:neighborhood_doctors/pages/admin/viewAdmin.dart';
import 'package:neighborhood_doctors/pages/admin/viewDoctor.dart';
import 'package:neighborhood_doctors/pages/admin/viewPatient.dart';

class ViewUser extends StatefulWidget{
  const ViewUser({Key? key, required this.jwt, required this.title}) 
      : super(key: key);
  final String jwt;
  final String title;
  @override
  State<StatefulWidget> createState() {
    return ViewUserState(this.jwt, this.title);
  }
}

class ViewUserState extends State<ViewUser> {
  final String jwt;
  final String title;
  ViewUserState(this.jwt, this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Neighborhood Doctors Pages')
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'View User Type',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              // To view admin page
              Center(
                child: ElevatedButton(
                  child: Text('View Admin'),
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => AdminInfo(title: 'View Admin', jwt: jwt)));
                  })
              ),
              const SizedBox(
                  height: 20,
              ),
              // To view patient page
              Center(
                child: ElevatedButton(
                  child: Text('View Patient'),
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => PatientInfo(title: 'View Patient', jwt: jwt)));
                  })
              ),
              const SizedBox(
                  height: 20,
              ),
              // To view doctor page
              Center(
                child: ElevatedButton(
                  child: Text('View Doctor'),
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => DoctorInfo(title: 'View Doctor', jwt: jwt)));
                  })
              ),
            ],
          ),
        ),
      ),
    );
  }
}