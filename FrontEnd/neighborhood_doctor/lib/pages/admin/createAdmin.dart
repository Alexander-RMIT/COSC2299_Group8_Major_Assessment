import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:neighborhood_doctors/Model/AdminModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateAdmin extends StatefulWidget{
  const CreateAdmin({Key? key, required this.jwt, required this.title}) 
      : super(key: key);
  final String jwt;
  final String title;

  @override
  State<StatefulWidget> createState() {
    return CreateAdminState(this.jwt, this.title);
  }
}

Future<AdminModel> userSignUp(String username, 
  String email,
  String password,
  BuildContext context) async {
  // Change to http://localhost/admin/createAdmin for desktop
  // Change to http://10.0.2.2:8080/admin/createAdmin for android emulator
  Uri url = Uri.parse("https://neighborhood-doctors-backend.herokuapp.com/admin/createAdmin");
  var response = await http.post(url,
    headers: <String, String>{"Content-Type": "application/json", },
    body: jsonEncode(<String, dynamic>{
      "username": username,
      "password": password,
      "email": email,
    }));

  String strResponse = response.body;

  if (response.statusCode == 200) {
    showDialog(
      context: context, 
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return ResponseAlertDialog(title: 'Backend response', content: response.body);
      },

    );
  }
  AdminModel admin = AdminModel(username: username, password: password,  email: email );
  return admin;
}

class CreateAdminState extends State<CreateAdmin> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  final String jwt;
  final String title;
  CreateAdminState(this.jwt, this.title);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Neighborhood Doctors Pages')
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Create Admin',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [

                        // Username textfield
                        Expanded(
                          child: TextFormField(
                            controller: userNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your user name';
                              }
                              return null;
                            },
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'User name',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // Email textfield
                    TextFormField(
                      controller: emailController,
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : "Please enter a valid email",
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    
                    // Password textfield
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      maxLines: 1,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // Button that pass data to backend
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String username = userNameController.text;
                          String email = emailController.text;
                          String password = passwordController.text;
                          

                          print("has been pressed");

                          AdminModel newAdmin = await userSignUp(username, email, password, context);

                          emailController.text = '';
                          passwordController.text = '';
                          userNameController.text = '';
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      ),
                      child: const Text(
                        'Create!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ResponseAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  ResponseAlertDialog({
    required this.title,
    required this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
      ),
      actions: this.actions,
      content: Text(
        this.content,
      ),
    );
  }
}
