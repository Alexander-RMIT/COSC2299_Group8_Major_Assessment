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

//gets patient ID
Future<String> getChatPatId(String jwt) async {
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

class ChatPatientState extends State<ChatPatient> {
  final String jwt;
  final String title;
  final _formKey = GlobalKey<FormState>();
  ChatPatientState(this.jwt, this.title);
  TextEditingController messageController = TextEditingController();
  TextEditingController useroneController = TextEditingController();

  List<Map<String, dynamic>> chats = [
    {"id": ""}
  ];

  Future<List<Map<String, dynamic>>> allChats(
      String token, BuildContext context) async {
    var tempId = await getChatPatId(token);
    var patientId = int.tryParse(tempId);
    chats.clear();
    Uri urlViewChats = Uri.parse("http://10.0.2.2:8080/chat/retrieveAllChats");
    // Return list in json format
    var response = await http.post(urlViewChats, body: token);
    debugPrint(response.body);
    // Convert to list of maps
    //https://stackoverflow.com/questions/51601519/how-to-decode-json-in-flutter
    final entries = json.decode(response.body);
    List<dynamic> chats_dynamic = entries;
    int num_chats = chats_dynamic.length;

    List<Map<String, dynamic>> symptom_list = [
      {"name": ""}
    ];
    symptom_list.clear();
    for (int i = 0; i < num_chats; i++) {
      Map<String, dynamic> cur = chats_dynamic[i];
      if (cur["usertwo"] == patientId) {
        symptom_list.add(cur);
      }
    }
    List<Map<String, dynamic>> r = symptom_list;

    if (response.statusCode == 200) {
      chats = r;
      return r;
    } else {
      return r;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Neighborhood Doctors Pages')),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            ChatBubble(
              text: 'Hi doc, i am sick',
              isCurrentUser: false,
            ),
            ChatBubble(
              text: 'Oh no, thats terrible',
              isCurrentUser: true,
            ),
            ChatBubble(
              text: 'Yes it is.',
              isCurrentUser: false,
            ),
          ],
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
                    int.parse(useroneController.text), 1);
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
          "usertwo": user2,
          "sender": "Patient"
        }));
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.text,
    required this.isCurrentUser,
  }) : super(key: key);
  final String text;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
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
