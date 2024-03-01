// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/home.dart';
import 'package:flutter_firebase/pages/register.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // signWithGoogle() async {
  //   final GoogleSignIn _googleSignIn = GoogleSignIn();
  //   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();
  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;

  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //           idToken: googleSignInAuthentication.idToken,
  //           accessToken: googleSignInAuthentication.accessToken);
  //       await _firebaseAuth.signInWithCredential(credential);
  //     }
  //   } catch (e) {}
  // }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      debugPrint("Successs");
      // Navigate to the next screen upon successful login
      // Navigator.push(...)
    } catch (e) {
      debugPrint('Failed to sign in: $e');
      // Show error message to the user
      // ScaffoldMessenger.of(context).showSnackBar(...)
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      assert(!user!.isAnonymous);
      assert(await user!.getIdToken() != null);

      final User? currentUser = _auth.currentUser;
      assert(user!.uid == currentUser!.uid);

      debugPrint('signInWithGoogle succeeded: $user');

      return user;
    } catch (error) {
      debugPrint('signInWithGoogle failed: $error');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await googleSignIn.signOut();
    debugPrint('User signed out');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "Login",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            Center(
                child: Text(
              "Welcome",
              style: TextStyle(color: Colors.black, fontSize: 35),
            )),
            SizedBox(
              height: 45,
            ),
            Container(
              margin: EdgeInsets.only(right: 12, left: 12),
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(16)),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Username",
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 20)),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              margin: EdgeInsets.only(right: 12, left: 12),
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(16)),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 20)),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Container(
              width: 350,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(16)),
              child: GestureDetector(
                onTap: () {
                  login();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ));
                },
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 350,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(16)),
              child: GestureDetector(
                  onTap: () {
                    signInWithGoogle();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => Home(),
                    //     ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Text(
                        "Sign In with Google",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 17,
            ),
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  )),
              child: Text(
                "Register Here",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
