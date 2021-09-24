import 'package:flutter/material.dart';
import 'package:flutter_auththetication_project/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatelessWidget {
  static String route = "\otpVerification";
  @override
  Widget build(BuildContext context) {
    String phoneNumber = ModalRoute.of(context).settings.arguments as String;
    TextEditingController otpControllor = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Enter your OTP code\n\nVerify Phone Number: " + phoneNumber,
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 1,
              ),
              Flexible(
                flex: 2,
                child: TextFormField(
                  controller: otpControllor,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              )
            ],
          ),
          Consumer<AuthServices>(builder: (context, auth, _) {
            return TextButton(
                onPressed: () {
                  if (otpControllor.text.isNotEmpty) {
                    auth.signInWithCred(otpControllor.text);
                    Navigator.pop(context);
                  }
                },
                child: Text("Verify Code"));
          })
        ],
      ),
    );
  }
}
