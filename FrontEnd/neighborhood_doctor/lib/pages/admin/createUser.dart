import 'package:flutter/material.dart';
import 'package:neighborhood_doctors/pages/admin/createAdmin.dart';
import 'package:neighborhood_doctors/pages/admin/createDoctor.dart';
import 'package:neighborhood_doctors/pages/admin/createPatient.dart';

class CreateUser extends StatefulWidget{
  const CreateUser({Key? key, required this.jwt, required this.title}) 
      : super(key: key);
  final String jwt;
  final String title;
  @override
  State<StatefulWidget> createState() {
    return CreateUserState(this.jwt, this.title);
  }
}

class CreateUserState extends State<CreateUser> {
  final String jwt;
  final String title;
  CreateUserState(this.jwt, this.title);

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
                'Create User Type',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              // To create admin page
              Center(
                child: ElevatedButton(
                  child: Text('Create Admin'),
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(
                        // builder: (context) => CreateAdmin(title: 'Create Admin', jwt: jwt)));
                        builder: (context) => CreateAdmin(title: 'Create Admin', jwt: jwt)));
                  })
              ),
              const SizedBox(
                  height: 20,
              ),
              // To create patient page
              Center(
                child: ElevatedButton(
                  child: Text('Create Patient'),
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => CreatePatient(title: 'Create Patient', jwt: jwt)));
                  })
              ),
              const SizedBox(
                  height: 20,
              ),
              // To create doctor page
              Center(
                child: ElevatedButton(
                  child: Text('Create Doctor'),
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => CreateDoctor(title: 'Create Admin', jwt: jwt)));
                  })
              ),
            ],
          ),
        ),
      ),
    );
  }
}



