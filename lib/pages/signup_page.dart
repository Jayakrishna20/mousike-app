// ignore_for_file: avoid_print, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mousike_app/pages/home_page.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({Key? key}) : super(key: key);

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  final _phoneNoTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  late String _email, _phoneno;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailTextController,
                decoration: const InputDecoration(hintText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Email";
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                    return "Please enter valid email";
                  }

                  return null;
                },
                onSaved: (email) {
                  _email = email.toString();
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneNoTextController,
                maxLength: 10,
                decoration: const InputDecoration(hintText: 'Phone No'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Phone";
                  }
                  if (value.length < 10) {
                    return "Please enter valid phone number";
                  }

                  return null;
                },
                onSaved: (phoneno) {
                  _phoneno = phoneno.toString();
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordTextController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Password";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _confirmPasswordTextController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Confirm Password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Re-Enter Password";
                  }
                  if (_passwordTextController.text != _confirmPasswordTextController.text) {
                    return "Password Does Not Match";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    try {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      )
                          .then((value) {
                        sendDetails(
                            email: _emailTextController.text, phoneno: _phoneNoTextController.text);
                        print('Created New Account');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return const HomePage();
                            },
                          ),
                        );
                      });
                    } catch (e) {
                      print(e);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Invalid Admin Credentials"),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                label: const Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: const Icon(Icons.save),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future sendDetails({required String email, required String phoneno}) async {
    final db = FirebaseFirestore.instance;
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "username": email,
      "Phone no": phoneno,
      "Created DateTime": DateTime.now()
    };

// Add a new document with a generated ID
    db
        .collection("admin_details")
        .add(user)
        .then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
  }
}
