import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:neighborhood_doctors/Model/DoctorModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateDoctor extends StatefulWidget{
  const CreateDoctor({Key? key, required this.jwt, required this.title}) 
      : super(key: key);
  final String jwt;
  final String title;

  @override
  State<StatefulWidget> createState() {
    return CreateDoctorState(this.jwt, this.title);
  }
}



Future<DoctorModel> userSignUp(String firstname, String lastname,
  String email,
  String password,
  BuildContext context) async {
  // Change to http://localhost/doctor/createDoctor for desktop
  // Change to http://10.0.2.2:8080/doctor/createDoctor for android emulator
  Uri url = Uri.parse("https://neighborhood-doctors-backend.herokuapp.com/doctor/createDoctor");
  var response = await http.post(url,
    headers: <String, String>{"Content-Type": "application/json", },
    body: jsonEncode(<String, dynamic>{
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "password": password,
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
  DoctorModel doctor = DoctorModel(firstname: firstname, lastname: lastname,  email: email, password: password);
  return doctor;
}

class CreateDoctorState extends State<CreateDoctor> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  final String jwt;
  final String title;
  CreateDoctorState(this.jwt, this.title);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

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
                'Create Doctor',
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
                        Expanded(
                          // First name textfield
                          child: TextFormField(
                            controller: firstNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'First name',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          // Last name textfield
                          child: TextFormField(
                            controller: lastNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                            
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Last name',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
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
                          String firstname = firstNameController.text;
                          String lastname = lastNameController.text;
                          String email = emailController.text;
                          String password = passwordController.text;

                          print("has been pressed");

                          DoctorModel newDoctor = await userSignUp(firstname, lastname, email, password, context);

                          emailController.text = '';
                          passwordController.text = '';
                          firstNameController.text = '';
                          lastNameController.text = '';
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