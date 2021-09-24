import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  final FirebaseAuth _auth;
  FacebookAuth _fbAuth;
  Stream<User> get userStatus => _auth.authStateChanges();
  String verifcationId;

  AuthServices(this._auth);

  Future<User> signInAno() {
    try {
      Future<UserCredential> userCred = _auth.signInAnonymously();
      return userCred.then<User>((value) => value.user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCred.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCred.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> verifyPhoneNumber(String phoneNumber) async {
    bool verificationStatus = false;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          verificationStatus = true;
        },
        verificationFailed: (phoneVerificationFailed) async {
          if (phoneVerificationFailed.code == "invalid-phone-number") {
            print("Invalid Phone Number");
            verificationStatus = true;
          }
        },
        codeSent: (verificationId, token) async {
          this.verifcationId = verificationId;
          print("Verification ID:" + this.verifcationId);
        },
        codeAutoRetrievalTimeout: (verficationId) async {},
        timeout: Duration(seconds: 60),
      );
      return verificationStatus;
    } catch (e) {
      print(e);
      return false;
    }
    // return verificationStatus;
  }

  Future<User> signInWithCred(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: this.verifcationId, smsCode: smsCode);
      UserCredential cred = await _auth.signInWithCredential(credential);
      return cred.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> signInWithFacebook() async {
    try {
      _fbAuth = FacebookAuth.instance;
      final LoginResult result = await _fbAuth.login(['email']);
      final FacebookAuthCredential fbAuthCredential =
          FacebookAuthProvider.credential(result.accessToken.token);
      final graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken.token}'));
      final profile = jsonDecode(graphResponse.body);

      print(profile);

      UserCredential usercred =
          await _auth.signInWithCredential(fbAuthCredential);
      print(graphResponse.body);

      return usercred.user;
    } catch (e) {
      print("Error Text" + e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    if (_fbAuth == null) {
      _auth.signOut();
      print("sign out");
    } else {
      _fbAuth.logOut();
      print("fb log out");
    }
  }
}
