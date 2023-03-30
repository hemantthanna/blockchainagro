// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // sign in anonymously

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // UsernCred? _firebaseUser(User user) {
  //   // ignore: unnecessary_null_comparison
  //   if (user != null) {
  //     return UsernCred(uid: user.uid);
  //   } else {
  //     return null;
  //   }
  // }

  // create a user object based on firebase user

  
  Future createwithEmailandPassword(String email, String password) async {
    try {
      final credential =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      return user?.uid;
    } on FirebaseAuthException catch(e) {
      if(e.code == 'weak-password') {
        print("Password is too weak.");
      } else if (e.code == 'email-already-in-use') {
        print("This account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }

  Future signinwithEmailandPassword(String email, String password) async{
      try {
        final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
        User? user = credential.user;
        return user!.uid;
      } catch (e) {
        print(e.toString());
        return null;
      }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
