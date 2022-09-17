import 'package:flutter/material.dart';


class ChatDoctor extends StatefulWidget {
  const ChatDoctor({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ChatDoctor> createState() => ChatDoctorState();
}

class ChatDoctorState extends State<ChatDoctor> {
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
                'Chat, Doctor POV',
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