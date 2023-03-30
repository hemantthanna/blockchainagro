// ignore: implementation_imports
// ignore_for_file: avoid_print


import 'package:blockchainagro/services/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';


class Wrapper extends StatefulWidget {
  const Wrapper({super.key});


  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            print("-------------------------------------------------------");
            print(snapshot.data?.uid);
            print("-------------------------------------------------------");
            return const Home();
          }
          return const Authenticate(); 
        }));
  }
}
