import 'package:flutter/material.dart';
import 'package:neighborhood_doctors/pages/signUp.dart';

// Navigation bar specific to the general landing page that doesnt have user heirarchy 

class NavigationBarLanding extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return NavBarLandingState();
  }
}

class NavBarLandingState extends State<NavigationBarLanding> {
  final minimumPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neighborhood Doctors Pages')
      ),
      body: Center(child: Text('Welcome to the Neighborhood Doctors website')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
          children: <Widget>[
            DrawerHeader(
              child: Text('Neighborhood Doctor management'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Sign Up'),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => SignUp(title: 'SignUp')));
              },
            )
          ],
        ),
      ),
    );
  }
}