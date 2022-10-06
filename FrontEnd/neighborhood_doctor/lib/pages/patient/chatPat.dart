import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatPatient extends StatefulWidget {
  const ChatPatient({Key? key, required this.jwt, required this.title})
      : super(key: key);
  final String jwt;
  final String title;
  @override
  State<StatefulWidget> createState() {
    return ChatPatientState(this.jwt, this.title);
  }
}

class ChatPatientState extends State<ChatPatient> {
  final String jwt;
  final String title;
  final _formKey = GlobalKey<FormState>();
  ChatPatientState(this.jwt, this.title);
  TextEditingController messageController = TextEditingController();
  TextEditingController useroneController = TextEditingController();

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
              ElevatedButton(
                child: Text('Create Chat'),
                onPressed: () {
                  openChatDialog();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future openChatDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text("New Chat"),
          content: Column(children: <Widget>[
            TextField(
                controller: messageController,
                decoration: InputDecoration(
                  icon: Icon(Icons.timer),
                  labelText: 'Enter Message',
                )),
            TextField(
                controller: useroneController,
                decoration: InputDecoration(
                  icon: Icon(Icons.timer),
                  labelText: 'Enter doctorId',
                )),
            ElevatedButton(
              child: Text('Send Chat'),
              onPressed: () {
                createChat(messageController.text,
                    int.parse(useroneController.text), 1234567890);
              },
            )
          ])));

  Future<void> createChat(String message, int user1, int user2) async {
    Uri url = Uri.parse("http://10.0.2.2:8080/chat/createChat");
    var response = await http.post(url,
        headers: <String, String>{
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, dynamic>{
          "message": message,
          "userone": user1,
          "usertwo": user2
        }));
  }
}
