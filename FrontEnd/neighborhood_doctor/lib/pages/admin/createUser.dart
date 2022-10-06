import 'package:flutter/material.dart';
import 'package:neighborhood_doctors/pages/admin/createAdmin.dart';
import 'package:neighborhood_doctors/pages/admin/createDoctor.dart';
import 'package:neighborhood_doctors/pages/admin/createPatient.dart';

class CreateUser extends StatefulWidget{
  const CreateUser({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return CreateUserState();
  }
}

class CreateUserState extends State<CreateUser> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Neighborhood Doctors Pages')
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
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
                        builder: (context) => CreateAdmin(title: 'Create Admin')));
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
                        builder: (context) => CreatePatient(title: 'Create Patient')));
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
                        builder: (context) => CreateDoctor(title: 'Create Admin')));
                  })
              ),
            ],
          ),
        ),
      ),
    );
  }
}



