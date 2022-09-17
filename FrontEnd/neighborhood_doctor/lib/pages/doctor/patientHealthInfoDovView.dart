import 'package:flutter/material.dart';


class PatientHealthInfoDoctor extends StatefulWidget {
  const PatientHealthInfoDoctor({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<PatientHealthInfoDoctor> createState() => PatientHealthInfoDoctorState();
}

class PatientHealthInfoDoctorState extends State<PatientHealthInfoDoctor> {
  final _formKey = GlobalKey<FormState>();

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
                'Patient Health Info.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
