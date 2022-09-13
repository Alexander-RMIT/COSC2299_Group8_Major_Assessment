import 'package:flutter/material.dart';
import 'dart:html' as html;

void main() {
  html.window.history.pushState(null, 'landing_user', '#/landing/user');
  runApp(const MyApp());
}


class landing_user extends StatelessWidget {
  void _iconButton() {
    print('Icon button pressed');
  }

  void _iconAdd() {
    print('Add button pressed');
  }

  void _iconSearch() {
    print('Searhc button pressed');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Welcome user',
          onPressed: _iconButton,
        ),
        title: Text('Welcome user'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icon.search),
            tooltip: 'Search',
            onPressed: _iconSearch,
          )
        ],
      ),
        body: Center(
          child: Text('Welcome to the landing page specific to a regular user.'),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add',
          child: Icon(Icons.add),
          onPressed: _iconAdd,
        )

    );
  }
}
