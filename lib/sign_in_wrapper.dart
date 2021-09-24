import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_auththetication_project/home_screen.dart';
import 'package:flutter_auththetication_project/sign_in_screen.dart';

class SignInWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    if (user != null) {
      return HomeScreen();
    } else
      return SignInScreen();
  }
}
