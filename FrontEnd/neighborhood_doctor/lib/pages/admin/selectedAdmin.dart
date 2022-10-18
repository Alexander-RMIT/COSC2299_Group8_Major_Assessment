import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SelectedAdmin extends StatefulWidget {
  const SelectedAdmin({Key? key, required this.jwt, required this.adminID}) : super(key: key);
  final String jwt;
  final int adminID;

  @override
  State<StatefulWidget> createState() {
    return SelectedAdminState(this.jwt, this.adminID);
  }
}

class SelectedAdminState extends State<SelectedAdmin> {
  final _formKey = GlobalKey<FormState>();

  final String jwt;
  final int adminID;
  SelectedAdminState(this.jwt, this.adminID);

  late Map<String, dynamic> admin;
  Future<Map<String, dynamic>> getAdminInformation(BuildContext context, String jwt, int id) async {
    Uri urlAdmin = Uri.parse("https://neighborhood-doctors-backend.herokuapp.com/admin/retrieveAllAdmins");
    var list = <String>[];
    list.add(jwt);
    list.add(id.toString());
    var response = await http.post(urlAdmin, body: list);

    print(response.body);

    final ret_admin = json.decode(response.body);
    Map<String, dynamic> a = ret_admin;

    if (response.statusCode == 200) {
      admin = a;
      return a;
    } else {
      return a;
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Admin Information')),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: FutureBuilder<Map<String, dynamic>>(
          future: getAdminInformation(context, jwt, adminID),
          builder: (jwt, context) {
            return Container(

            );
          }
        )
    );
  }

}