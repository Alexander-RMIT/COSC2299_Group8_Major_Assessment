import 'package:flutter/material.dart';


class DoctorAvailability extends StatefulWidget {
  const DoctorAvailability({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<DoctorAvailability> createState() => DoctorAvailabilityState();
}

class DoctorAvailabilityState extends State<DoctorAvailability> {
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
                'Doctor Availability',
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
