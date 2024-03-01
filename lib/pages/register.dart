// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> registerUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      debugPrint("Successssssssssssssss");

      debugPrint('User registered: ${userCredential.user}');
    } catch (e) {
      debugPrint('Error registering user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "Register",
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
                  registerUser();
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
