import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:neighborhood_doctors/pages/admin/createUser.dart';
import 'package:neighborhood_doctors/pages/admin/createAdmin.dart';
import 'package:http/http.dart' as http;

class NavigationBarAdmin extends StatefulWidget{
  final int id;
  NavigationBarAdmin(this.id);

  @override
  State<StatefulWidget> createState() {
    return NavBarStateAdmin(this.id);
  }
}

class NavBarStateAdmin extends State<NavigationBarAdmin> {
  final int id;
  NavBarStateAdmin(this.id);

  // Set at runtime instead of compile time
  String _uname = "";
  Future<String> userFirstName(int id, BuildContext context) async {
    Uri urlAdminName = Uri.parse("http://10.0.2.2:8080/admin/username");

    var response = await http.post(urlAdminName,
        headers: <String, String>{"Content-Type": "application/json", },
        body: jsonEncode(<String, dynamic>{
          "id": id,
        }));
    String strResponse = response.body;

    if (response.statusCode == 200) {
      _uname = strResponse;
      return strResponse;
    } else {
      return strResponse;
    }
  }

  final minimumPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Neighborhood Doctors Pages')
      ),
      body: FutureBuilder<String>(
        future: userFirstName(id, context),
        builder: (username, context) {
          if (username != "") {
            String welcomeMsg = "Welcome to \nNeighborhood Doctors \n$_uname";
            return Center(child: Text(welcomeMsg, textAlign: TextAlign.center));
          } else {
            return Center(child: Text("Welcome to Neighborhood Doctors"));
          }
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
          children: <Widget>[
            const SizedBox(
              height: 84,
              child: DrawerHeader(
                child: Text('Neighborhood Doctor management'),
                decoration: BoxDecoration(
                  color: Colors.purple,
                ),
              ),
            ),
            ListTile(
              title: Text('Create usertype'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => CreateUser(title: 'Create User')));
              },
            ),
            ListTile(
                title: Text('Sign out'),
                onTap: () {
                  // Navigator.push(context,
                  //   MaterialPageRoute(builder: (context) => NavigationBarLanding()));
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);

                }
            )
          ],
        ),
      ),
    );
  }
}
