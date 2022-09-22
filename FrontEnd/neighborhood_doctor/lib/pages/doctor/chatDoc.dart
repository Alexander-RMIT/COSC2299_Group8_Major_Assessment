import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatDoctor extends StatefulWidget {
  const ChatDoctor({Key? key, required this.id, required this.title})
      : super(key: key);
  final int id;
  final String title;
  @override
  State<ChatDoctor> createState() {
    return ChatDoctorState(this.id, this.title);
  }
}

class ChatDoctorState extends State<ChatDoctor> {
  final _formKey = GlobalKey<FormState>();

  final int id;
  final String title;
  ChatDoctorState(this.id, this.title);

  TextEditingController messageController = TextEditingController();
  TextEditingController usertwoController = TextEditingController();

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
              controller: usertwoController,
              decoration: InputDecoration(
                icon: Icon(Icons.timer),
                labelText: 'Enter patientId',
              ),
            ),
            ElevatedButton(
              child: Text('Send Chat'),
              onPressed: () {
                createChat(messageController.text, id,
                    int.parse(usertwoController.text));
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
