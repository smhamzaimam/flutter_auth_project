import 'package:flutter/material.dart';
import 'package:flutter_auththetication_project/firebase_auth_service.dart';
import 'package:flutter_auththetication_project/otp_screen.dart';
import 'package:provider/provider.dart';

class PhoneVerificationScreen extends StatelessWidget {
  const PhoneVerificationScreen();
  static final String route = "/phoneVerificationScreen";

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumber = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Verification"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: phoneNumber,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "Enter Phone Number",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Consumer<AuthServices>(
            builder: (context, auth, _) {
              return TextButton(
                  onPressed: () async {
                    await auth.verifyPhoneNumber(phoneNumber.text);
                    Navigator.popAndPushNamed(context, OTPScreen.route,
                        arguments: phoneNumber.text);
                  },
                  child: Text("Send OTP Code"));
            },
          ),
        ],
      ),
    );
  }
}
