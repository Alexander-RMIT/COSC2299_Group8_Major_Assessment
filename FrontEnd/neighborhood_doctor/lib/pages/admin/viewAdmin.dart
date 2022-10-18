import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neighborhood_doctors/pages/admin/selectedAdmin.dart';

class AdminInfo extends StatefulWidget {
  const AdminInfo({Key? key, required this.title, required this.jwt}) : super(key: key);
  final String title;
  final String jwt;
  
  @override
  State<StatefulWidget> createState() {
    return AdminInfoState(this.jwt);
  }
}

class AdminInfoState extends State<AdminInfo> {
  final _formKey = GlobalKey<FormState>();
  final String jwt;
  AdminInfoState(this.jwt);



  List<Map<String, dynamic>> admins = [{"username": ""}];
  Future<List<Map<String, dynamic>>> allAdmins(String jwt, BuildContext context) async {
    admins.clear();
    Uri urlViewAdmins = Uri.parse("https://neighborhood-doctors-backend.herokuapp.com/admin/retrieveAllAdmins");
    // Return list in json format
    var response = await http.post(urlViewAdmins, body: jwt);

    final entries = json.decode(response.body);
    List<dynamic> admins_dynamic = entries;
    int num_admins = admins_dynamic.length;

    List<Map<String, dynamic>> admin_list = [{"username": ""}];
    admin_list.clear();
    for (int i = 0; i < num_admins; i++) {
      Map<String, dynamic> cur = admins_dynamic[i];
      admin_list.add(cur);
    }
    List<Map<String, dynamic>> r = admin_list;
    if (response.statusCode == 200) {
      admins = r;
      return r;
    } else {
      return r;
    }
  }

  TextEditingController searchBarController = TextEditingController();
  String searchResult = "";
  List<Map<String, dynamic>> test = [{"username": "", "password": "", "email": ""}];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Neighborhood Doctors Pages')
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body:
        FutureBuilder<List<Map<String, dynamic>>>(
          future: allAdmins(jwt, context),
          builder: (jwt, context) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Admins',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Form(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'Username',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'Password',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Text(
                                    'Email',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  )
                              ),
                            ),
                          ],
                          showCheckboxColumn: false,
                          rows: admins.map(
                              ((element) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(element["username"])),
                                    DataCell(Text(element["password"])),
                                    DataCell(Text(element["email"]))
                                  ],
                                  onSelectChanged: (value) {
                                    Navigator.push(
                                        this.context,
                                        MaterialPageRoute(
                                        builder: (context) => SelectedAdmin(
                                            jwt: this.jwt,
                                            adminID: element["id"]
                                        )));
                                    // Retrieve elements details and open patient health info specific to patient
                                    print(element["username"] + " has been pressed");

                                  }))).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
    );
  }
}