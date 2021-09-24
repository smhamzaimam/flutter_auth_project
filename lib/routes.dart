import 'package:flutter_auththetication_project/home_screen.dart';
import 'package:flutter_auththetication_project/otp_screen.dart';
import 'package:flutter_auththetication_project/phone_verification_screen.dart';
import 'package:flutter_auththetication_project/sign_up_screen.dart';

final route = {
  HomeScreen.route: (context) => HomeScreen(),
  SignUpScreen.route: (context) => SignUpScreen(),
  PhoneVerificationScreen.route: (context) => PhoneVerificationScreen(),
  OTPScreen.route: (context) => OTPScreen(),
};
