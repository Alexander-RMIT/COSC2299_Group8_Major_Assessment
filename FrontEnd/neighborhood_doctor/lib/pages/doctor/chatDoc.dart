import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:email_validator/email_validator.dart';

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

Future<void> createChate(
    int doctorID, int patientID, BuildContext context) async {
  Uri url = Uri.parse("http://10.0.2.2:8080/chat/createChat");
  var response = await http.post(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "doctorID": doctorID,
        "patientID": patientID,
      }));
  if (response.statusCode == 200) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return ResponseAlertDialog(
            title: 'Sent to backend', content: response.body);
      },
    );
  }
}

Future<void> sendMessage(
    int chatId, int doctorID, int patientId, BuildContext context) async {
  TextEditingController messageController = TextEditingController();
  //to be implemented to service
  Uri url = Uri.parse("http://10.0.2.2:8080/chat/sendChat");
}

Future<void> getMessages(int chatId, int doctorID, int patientId) async {
  Uri url = Uri.parse("http://10.0.2.2:8080/chat/readChats");
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

class ResponseAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  ResponseAlertDialog({
    required this.title,
    required this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
      ),
      actions: this.actions,
      content: Text(
        this.content,
      ),
    );
  }
}
