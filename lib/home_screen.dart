import 'package:flutter/material.dart';
import 'package:flutter_auththetication_project/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String route = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text("Home Screen"),
          Consumer<AuthServices>(builder: (context, auth, _) {
            return TextButton(
                onPressed: () {
                  auth.signOut();
                },
                child: Text("Sign Out"));
          })
        ],
      )),
    );
  }
}
