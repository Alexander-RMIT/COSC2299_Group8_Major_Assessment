import 'package:neighborhood_doctors/pages/signUp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './signUp.dart';
import 'package:neighborhood_doctors/pages/patient/navigationBarPat.dart';
import 'package:neighborhood_doctors/pages/doctor/navigationBarDoc.dart';
import 'package:neighborhood_doctors/pages/admin/navigationBarAdmin.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Login> createState() => LoginState();
}

Future<void> userLogin(String email, String password, BuildContext context) async {
  Uri urlPatient = Uri.parse("http://10.0.2.2:8080/auth/patient/login");
  Uri urlDoctor = Uri.parse("http://10.0.2.2:8080/auth/doctor/login");
  Uri urlAdmin = Uri.parse("http://10.0.2.2:8080/auth/admin/login");

  var urlList = [urlPatient, urlDoctor, urlAdmin];
  bool found = false;
  for (int i = 0; i < urlList.length; i++) {
    var response = await http.post(urlList[i],
        headers: <String, String>{"Content-Type": "application/json", },
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
        }));
    String strResponse = response.body;

    if (response.statusCode == 200) {
      print(response.body);
      if (response.body == "Successful login") {
        // Check what type the user is for the correct landing page
        found = true;
        if (i == 0) {
          // Patient
          Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationBarLanding()));
        } else if (i == 1) {
          // Doctor
          Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationBarDoc()));
        } else if (i == 2) {
          // Admin
          Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationBarAdmin()));
        }
      } else {
        if (i == urlList.length - 1 && found == false) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed, invalid details")));
        }
      }
    } else {
      if (i == urlList.length - 1 && found == false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed, invalid details")));
      }
    }
  }

}


class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sign in',
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
                  TextFormField(
                    controller: emailController,
                    validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Please enter a valid email",
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      prefixIcon  : const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String email = emailController.text;
                        String password = passwordController.text;

                        print(email);
                        print(password);
                        print("has been pressed");

                        var loginAttempt = userLogin(email, password, context);

                        
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not registered yet?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SignUp(title: 'Register UI'),
                            ),
                          );
                        },
                        child: const Text('Create an account'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
