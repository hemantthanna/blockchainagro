import 'package:blockchainagro/screens/dashboard.dart';
import 'package:blockchainagro/screens/home.dart';
import 'package:blockchainagro/services/singleton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupSingleton();
  runApp(const MaterialApp(
    home: Home(),
  ));
}
