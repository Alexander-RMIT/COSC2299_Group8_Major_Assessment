import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:neighborhood_doctors/pages/admin/createUser.dart';
import 'package:neighborhood_doctors/pages/admin/editUser.dart';
import 'package:neighborhood_doctors/pages/admin/viewAdmin.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

import 'package:neighborhood_doctors/pages/admin/viewUser.dart';

class NavigationBarAdmin extends StatefulWidget{
  final String jwt;
  NavigationBarAdmin(this.jwt);

  @override
  State<StatefulWidget> createState() {
    return NavBarStateAdmin(this.jwt);
  }
}

class NavBarStateAdmin extends State<NavigationBarAdmin> {
  final String jwt;
  NavBarStateAdmin(this.jwt);

  // Set at runtime instead of compile time
  String _uname = "";
  Future<String> userFirstName(String token, BuildContext context) async {
    Uri urlAdminName = Uri.parse("https://neighborhood-doctors-backend.herokuapp.com/admin/username");
    var response = await http.post(urlAdminName,
        body: token);
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
        future: userFirstName(jwt, context),
        builder: (username, context) {
          if (username != "") {
            String welcomeMsg = "Welcome to \nNeighborhood Doctors \n$_uname";
            return Center(child: Text(welcomeMsg, textAlign: TextAlign.center,
            style: TextStyle(
            fontSize: 15,
            foreground: Paint()
            ..shader = ui.Gradient.linear(
            const Offset(0, 20),
            const Offset(300, 20),
          <Color>[
          Color.fromARGB(255, 209, 16, 248),
          Color.fromARGB(223, 0, 195, 255),
          ],
       )
    ),));
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
              title: Text('Create User type'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => CreateUser(title: 'Create User', jwt: jwt)));
              },
            ),
            // ListTile(
            //   title: Text('Edit User'),
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(
            //             builder: (context) => EditUser(title: 'Edit User', jwt: jwt)));
            //   },
            // ),
            ListTile(
              title: Text('View User'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => ViewUser(title: 'View User', jwt: jwt)));
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
