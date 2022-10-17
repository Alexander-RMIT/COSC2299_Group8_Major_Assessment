import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class chatPatient extends StatefulWidget {
  const chatPatient({Key? key, required this.title, required this.jwt})
      : super(key: key);
  final String jwt;
  final String title;

  @override
  State<StatefulWidget> createState() {
    return chatPatientState(this.jwt, this.title);
  }
}

TextEditingController chatMessageController = TextEditingController();

List<Map<String, dynamic>> chats = [
  {"message": ""}
];

Future<String> getId(String jwt) async {
  Uri urlViewPatients = Uri.parse("http://10.0.2.2:8080/patient/getId");
  // Return id for patient
  var response = await http.post(urlViewPatients, body: jwt);
  String tempStr = response.body;
  tempStr = tempStr.substring(1, tempStr.length - 1);
  final fin_response = json.decode(tempStr);
  print(tempStr);
  dynamic dyn_response = fin_response;
  Map<String, dynamic> responseMap = dyn_response;
  print(responseMap["id"].toString());
  if (response.statusCode == 200) {
    return (responseMap["id"].toString()); //{"id": 1}
  } else {
    return "";
  }
}

Future<List<Map<String, dynamic>>> getChats(
    String token, BuildContext context) async {
  // getId(token, context);//await getId(token, context); //Change one to getId(token, context) when its working
  chats.clear();
  var tempId = await getId(token);
  var patID = int.tryParse(
      tempId);
  Uri urlViewSymptoms =
  Uri.parse("http://10.0.2.2:8080/chat/retrieveAllChats");
  // Return list in json format
  var response = await http.post(urlViewSymptoms, body: token);
  debugPrint(response.body);
  // Convert to list of maps
  //https://stackoverflow.com/questions/51601519/how-to-decode-json-in-flutter
  final entries = json.decode(response.body);
  List<dynamic> chats_dynamic = entries;
  int num_chats = chats_dynamic.length;
  List<Map<String, dynamic>> chat_list = [
    {"message": ""}
  ];
  chat_list.clear();
  for (int i = 0; i < num_chats; i++) {
    Map<String, dynamic> cur = chats_dynamic[i];
    if (cur["usertwo"] == patID) {
      chat_list.add(cur);
    }
  }
  List<Map<String, dynamic>> r = chat_list;

  if (response.statusCode == 200) {
    chats = r;
    return r;
  } else {
    return r;
  }
}

//Create Chat
Future<void> createChat(String message, String sender, int patID) async{
  Uri url = Uri.parse("http://10.0.2.2:8080/chat/createChat");
  var response = await http.post(url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "message": message,
        "userone": 1,
        "usertwo": patID,
        "sender": "Patient",
      }));
  print(response.body);
  print(patID.toString());
}

class chatPatientState extends State<chatPatient> {
  final _formKey = GlobalKey<FormState>();

  final String jwt;
  final String title;
  chatPatientState(this.jwt, this.title);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Chat Room')),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: FutureBuilder<List<Map<String, dynamic>>>(
            future: getChats(jwt, context),
            builder: (jwt, context) {
              return Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0,
                      horizontal: 15.0),

                  child: SingleChildScrollView(
                    child: Column(
                        children: <Widget>[
                          ...chats.map((chat) => ChatBubble(text: (chat["message"]).toString(), sender: chat["sender"].toString())).toList(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: TextField(
                              controller: chatMessageController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Send Chat',
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.send),
                                    onPressed: () async {
                                      createChat(chatMessageController.text, "Doctor", chats[0]["usertwo"]);
                                      chatMessageController.clear();
                                      await new Future.delayed((const Duration(milliseconds: 1)));
                                      setState(() {});

                                    },
                                  )
                              ),
                            ),
                          )

                        ]
                    ),
                  ));

            }));
  }
}



class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.text,
    required this.sender,
  }) : super(key: key);
  final String text;
  final String sender;



  bool checkBool(String sender){
    bool isCurrentUser;
    if (sender == "Patient"){
      return true;
    }
    else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = checkBool(sender);
    return Padding(
      // asymmetric padding
      padding: EdgeInsets.fromLTRB(
        isCurrentUser ? 64.0 : 16.0,
        4,
        isCurrentUser ? 16.0 : 64.0,
        4,
      ),
      child: Align(
        // align the child within the container
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: DecoratedBox(
          // chat bubble decoration
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: isCurrentUser ? Colors.white : Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}
