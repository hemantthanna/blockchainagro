// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../models/auth.dart';
import 'constants.dart';
import 'loading.dart';


class SignIn extends StatefulWidget {
  final Function toggleview;
  const SignIn({super.key, required this.toggleview});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return const Loading();
    }
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
          title: const Text("Sign In"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
                onPressed: (() {
                  widget.toggleview();
                }),
                icon: const Icon(Icons.person, semanticLabel: "Register"))
          ]),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
              child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                decoration:textinputDecoration.copyWith(hintText: 'Email'),
                onChanged: ((value) {
                  setState(() {
                    email = value;
                  });
                }),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: textinputDecoration.copyWith(hintText: 'password'),
                obscureText: true,
                
                onChanged: ((value) {
                  setState(() {
                    password = value;
                  });
                }),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: (() async {
                    print(email);
                    print(password);
                    if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.signinwithEmailandPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'invalid email or password';
                              loading = false;
                            });
                          }
                    }
                  }),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ))),
    );
  }
}
