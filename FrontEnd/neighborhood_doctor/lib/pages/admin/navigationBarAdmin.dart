import 'package:flutter/material.dart';

import 'package:neighborhood_doctors/pages/admin/createUser.dart';

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
              title: Text('Create user'),
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
