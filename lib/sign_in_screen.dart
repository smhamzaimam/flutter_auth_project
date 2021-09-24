import 'package:flutter/material.dart';
import 'package:flutter_auththetication_project/firebase_auth_service.dart';
import 'package:flutter_auththetication_project/home_screen.dart';
import 'package:flutter_auththetication_project/phone_verification_screen.dart';
import 'package:flutter_auththetication_project/sign_up_screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();

    TextEditingController password = TextEditingController();
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Sign In"),
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
          Consumer<AuthServices>(
            builder: (context, auth, _) {
              return TextButton(
                  onPressed: () {
                    auth.signInWithEmail(email.text, password.text);
                  },
                  child: Text("Sign In"));
            },
          ),
          Consumer<AuthServices>(builder: (context, auth, _) {
            return TextButton(
              onPressed: () {
                auth.signInAno();
              },
              child: Text("Sign In Anonymously"),
            );
          }),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, PhoneVerificationScreen.route);
            },
            child: Text("Phone Verification"),
          ),
          Consumer<AuthServices>(builder: (context, auth, _) {
            return TextButton(
              onPressed: () {
                auth.signInWithFacebook();
                Navigator.pushNamed(context, HomeScreen.route);
              },
              child: Text("Sign In with FaceBook"),
            );
          }),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, SignUpScreen.route);
            },
            child: Text("Sign In with Google"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, SignUpScreen.route);
            },
            child: Text("Sign In with Twitter"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, SignUpScreen.route);
            },
            child: Text("Sign Up"),
          ),
        ],
      ),
    ));
  }
}
