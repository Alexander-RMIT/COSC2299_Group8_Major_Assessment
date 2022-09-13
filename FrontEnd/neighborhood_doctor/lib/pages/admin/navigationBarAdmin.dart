import 'package:flutter/material.dart';


class NavigationBarAdmin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return NavBarStateAdmin();
  }
}

class NavBarStateAdmin extends State<NavigationBarAdmin> {
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
              title: Text('Calendar'),
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => landing_user();
                    )
                  ),
              },
            )
          ],
        ),
      ),
    );
  }
}