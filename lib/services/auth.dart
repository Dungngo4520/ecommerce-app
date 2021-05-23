import 'package:ecommerce/screens/home/home_screen.dart';
import 'package:ecommerce/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> getOnAuthStateChange() {
    return FirebaseAuth.instance.authStateChanges().map((e) => e);
  }

  createUserWithUserData(BuildContext context, List<String> userData) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userData[0], password: userData[1]);
      User userDetails = userCredential.user!;
      String displayName = userData[2] + " " + userData[3];
      Map<String, dynamic> userInfo = {
        'email': userDetails.email,
        'username': userDetails.email!.replaceAll(new RegExp(r'@.+'), ''),
        'name': displayName,
        'photoURL': '',
        'phone': userData[4],
        'address': userData[5],
      };
      DatabaseMethods(uid: userDetails.uid).setUserInfoToDB(userInfo).then((_) {
        Navigator.pushReplacementNamed(context, HomeScreen.route);
      });
      return true;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message!),
      ));
      return false;
    }
  }

  signInWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushReplacementNamed(context, HomeScreen.route);
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return false;
    }
  }

  signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      User userDetails = userCredential.user!;

      Map<String, dynamic> userInfo = {
        'email': userDetails.email ?? "",
        'username': userDetails.email!.replaceAll(new RegExp(r'@.+'), ''),
        'name': userDetails.displayName ?? "",
        'photoURL': userDetails.photoURL ?? "",
        'phone': userDetails.phoneNumber ?? "",
        'address': '',
      };
      DatabaseMethods(uid: userDetails.uid).setUserInfoToDB(userInfo).then((_) {
        Navigator.pushReplacementNamed(context, HomeScreen.route);
      });
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return false;
    }
  }

  Future signOut(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('USERIDKEY');
      await auth.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  Future forgotPassword(BuildContext context, String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "An email has been sent to you. Please open and follow the link to recover your password."),
      ));
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return false;
    }
  }
}
