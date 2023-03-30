// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../models/auth.dart';
import 'constants.dart';
import 'loading.dart';



class Register extends StatefulWidget {
  final Function toggleview;

  const Register({super.key, required this.toggleview});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              onPressed: (() {
                widget.toggleview();
              }),
              icon: const Icon(Icons.person, semanticLabel: "Register"))
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
              child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textinputDecoration.copyWith(hintText: 'Email'),
                validator: ((value) => value!.isEmpty ? 'enter Email' : null),
                onChanged: ((value) {
                  setState(() {
                    email = value;
                  });
                }),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: textinputDecoration.copyWith(hintText: 'Password'),
                validator: ((value) => value!.length < 6 ? 'enter Password greater than length 6' : null),
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
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.createwithEmailandPassword(email, password);
                      if (result == null) {
                        setState(() {
                          loading = false;
                        });
                      }
                    }
                  }),
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ))),
    );
  }
}
