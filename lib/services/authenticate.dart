import 'package:blockchainagro/screens/register.dart';
import 'package:blockchainagro/screens/sign_in.dart';
import 'package:flutter/cupertino.dart';


class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleview() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      return SignIn(toggleview: toggleview);
    } else {
      return Register(toggleview: toggleview);
    }
  }
}
