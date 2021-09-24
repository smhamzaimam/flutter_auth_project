import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auththetication_project/connectivity_error.dart';
import 'package:flutter_auththetication_project/firebase_auth_service.dart';
import 'package:flutter_auththetication_project/routes.dart';
import 'package:flutter_auththetication_project/sign_in_wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthServices>(
            create: (context) => AuthServices(FirebaseAuth.instance),
          ),
          StreamProvider(
              create: (context) => context.read<AuthServices>().userStatus,
              initialData: null)
        ],
        child: MaterialApp(
          routes: route,
          home: FutureBuilder(
              future: Firebase.initializeApp(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SignInWrapper();
                } else if (snapshot.hasError) {
                  return InternetError();
                } else
                  return Text("Waiting to connect");
              }),
        ));
  }
}
