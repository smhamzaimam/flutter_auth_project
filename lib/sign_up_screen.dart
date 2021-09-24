import 'package:flutter/material.dart';
import 'package:flutter_auththetication_project/firebase_auth_service.dart';
import 'package:flutter_auththetication_project/home_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  static String route = "\SignUp";
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Text("Sign Up"),
          TextFormField(
            controller: email,
            decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          TextFormField(
            controller: password,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Confirm Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Consumer<AuthServices>(builder: (ctx, auth, _) {
            return TextButton(
              onPressed: () {
                auth.signUpWithEmail(email.text, password.text);
                Navigator.pushNamed(context, HomeScreen.route);
              },
              child: Text("Sign Up"),
            );
          }),
        ],
      ),
    ));
  }
}
