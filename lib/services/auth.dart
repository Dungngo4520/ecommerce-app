import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/home/home_screen.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/services/shared_preference_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future getCurrentUser() async {
    // ignore: await_only_futures
    return await auth.currentUser;
  }

  createUserWithUserData(BuildContext context, List<String> userData) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userData[0], password: userData[1]);
      print(userCredential);
      if (userCredential != null) {
        User userDetails = userCredential.user;
        SharedPreferenceHelper().saveUserId(userDetails.uid);
        SharedPreferenceHelper().saveUserEmail(userDetails.email);
        String displayName = userData[2] + " " + userData[3];
        SharedPreferenceHelper().saveUserDisplayName(displayName);
        SharedPreferenceHelper().saveUserPhotoURL("");
        SharedPreferenceHelper().saveUserPhoneNumber(userData[4]);
        SharedPreferenceHelper().saveUserPhotoURL(userData[5]);

        Map<String, dynamic> userInfo = {
          'email': userDetails.email,
          'username': userDetails.email.replaceAll(new RegExp(r'@.+'), ''),
          'name': displayName,
          'photoURL': '',
          'phone': userData[4],
          'address': userData[5],
        };
        DatabaseMethods().addUserInfoToDB(userDetails.uid, userInfo).then((_) {
          Navigator.pushReplacementNamed(context, HomeScreen.route);
        });
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    } catch (e) {
      print(e);
    }
  }

  signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.route);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    }
  }

  signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount googleSignInAccount =
        await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    User userDetails = userCredential.user;

    if (userCredential != null) {
      SharedPreferenceHelper().saveUserId(userDetails.uid);
      SharedPreferenceHelper().saveUserEmail(userDetails.email);
      SharedPreferenceHelper().saveUserDisplayName(userDetails.displayName);
      SharedPreferenceHelper().saveUserPhotoURL(userDetails.photoURL);

      Map<String, dynamic> userInfo = {
        'email': userDetails.email,
        'username': userDetails.email.replaceAll(new RegExp(r'@.+'), ''),
        'name': userDetails.displayName,
        'photoURL': userDetails.photoURL,
        'phone': userDetails.phoneNumber,
        'address': '',
      };
      DatabaseMethods().addUserInfoToDB(userDetails.uid, userInfo).then((_) {
        Navigator.pushReplacementNamed(context, HomeScreen.route);
      });
    }
  }

  Future signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    await auth.signOut();
  }
}
