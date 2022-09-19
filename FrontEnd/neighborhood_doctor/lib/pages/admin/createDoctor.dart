import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:neighborhood_doctors/Model/DoctorModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateDoctor extends StatefulWidget{
  const CreateDoctor({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return CreateDoctorState();
  }
}



Future<DoctorModel> userSignUp(String firstname, String lastname,
  String email,
  String password,
  BuildContext context) async {
  // Change to http://localhost/patient/createPatient for desktop
  // Change to http://10.0.2.2:8080/patient/createPatient for android emulator
  Uri url = Uri.parse("http://10.0.2.2:8080/doctor/createDoctor");
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
      backgroundColor: Theme.of(context).colorScheme.background,
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
                    // Name other
                    // TextFormField(
                    //   controller: nameOtherController,
                    //   maxLines: 1,
                    //   decoration: InputDecoration(
                    //     hintText: 'Middle name/initial',
                    //     prefixIcon: const Icon(Icons.person),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ),

                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),

                    // Age & Gender
                    // Row(
                    //   children: [
                    //     Expanded(child: TextFormField(
                    //       controller: ageController,
                    //       validator: (value) {
                    //         if (value == null || value.isEmpty) {
                    //           return 'Please enter your age';
                    //         }
                    //         return null;
                    //       },
                    //       maxLines: 1,
                    //       decoration: InputDecoration(
                    //         hintText: 'Age',
                    //         prefixIcon: const Icon(Icons.face),
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //       ),
                    //     ),
                    //     ),

                    //     const SizedBox(
                    //       width: 20,
                    //     ),
                    //     Expanded(child:

                    //       DropdownButtonFormField<String>(
                    //         value: dropdownValue,
                    //         icon: const Icon(Icons.arrow_downward),
                    //         elevation: 16,
                    //         style: const TextStyle(color: Colors.white),
                    //         validator: (value) {
                    //           if (value == "Gender") {
                    //             return 'Please enter your gender';
                    //           }
                    //           return null;
                    //           },
                    //         onChanged: (String? value) {

                    //           // This is called when the user selects an item.
                    //           setState(() {
                    //             dropdownValue = value!;
                    //           });
                    //         },

                    //         items: genderList.map<DropdownMenuItem<String>>((String value) {
                    //           return DropdownMenuItem<String>(
                    //             value: value,
                    //             child: Text(value),
                    //           );
                    //         }).toList(),
                    //       ),
                    //     ),
                    //   ],

                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),

                    // // Address
                    // TextFormField(
                    //   controller: addressController,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your address';
                    //     }
                    //     return null;
                    //   },
                    //   maxLines: 1,
                    //   decoration: InputDecoration(
                    //     hintText: 'Enter your address',
                    //     prefixIcon: const Icon(Icons.home),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ),

                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),

                    // // Phone Number
                    // TextFormField(
                    //   controller: phoneNumController,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your phone number';
                    //     }
                    //     return null;
                    //   },
                    //   maxLines: 1,
                    //   decoration: InputDecoration(
                    //     hintText: 'Enter your phone number',
                    //     prefixIcon: const Icon(Icons.phone),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ),

                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),

                    // TextFormField(
                    //   controller: emailController,
                    //   validator: (value) => EmailValidator.validate(value!)
                    //       ? null
                    //       : "Please enter a valid email",
                    //   maxLines: 1,
                    //   decoration: InputDecoration(
                    //     hintText: 'Enter your email',
                    //     prefixIcon: const Icon(Icons.email),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
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
                          String firstname = firstNameController.text;
                          String lastname = lastNameController.text;
                          String email = emailController.text;
                          String password = passwordController.text;
                          
                          // String nameOther = nameOtherController.text;
                          // int age = int.parse(ageController.text);
                          // String gender = dropdownValue;
                          // String address = addressController.text;
                          // String phoneNumber = phoneNumController.text;

                          print("has been pressed");

                          DoctorModel newDoctor = await userSignUp(firstname, lastname, email, password, context);

                          emailController.text = '';
                          passwordController.text = '';
                          firstNameController.text = '';
                          lastNameController.text = '';
                          // nameOtherController.text = '';
                          // ageController.text = '';
                          // dropdownValue = genderList.first;
                          // addressController.text = '';
                          // phoneNumController.text = '';
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