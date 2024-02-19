// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
                child: Text(
              "Welcome",
              style: TextStyle(color: Colors.black, fontSize: 30),
            )),
            SizedBox(
              height: 35,
            ),
            Container(
              margin: EdgeInsets.only(right: 12, left: 12),
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(16)),
              child: TextField(
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
                decoration: InputDecoration(
                    hintText: "Password",
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 20)),
              ),
            ),
            SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
