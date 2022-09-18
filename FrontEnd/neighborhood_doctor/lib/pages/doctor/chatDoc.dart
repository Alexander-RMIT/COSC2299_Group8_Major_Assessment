import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      appBar: AppBar(title: Text('Neighborhood Doctors Pages')),
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

Future<void> sendMessage(int chatId, int doctorID, int patientId) async {
  TextEditingController messageController = TextEditingController();
  Uri url = Uri.parse("http://10.0.2.2:8080/doctor/chatDoc");
  var response = await http.post(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "chatId": chatId,
        "doctorId": doctorID,
        "patientId": patientId,
      }));
}
