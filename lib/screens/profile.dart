import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        toolbarHeight: MediaQuery.of(context).size.height / 8,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: const CircleAvatar(
                    radius: 70,
                    child: Icon(Icons.person),
                  ),
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.email.toString(),
                  style: const TextStyle(fontSize: 25),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
