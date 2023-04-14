import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/utils/snackBarMsg.dart';
import 'package:task_manager/ui/widgets/AppElButton.dart';
import 'package:task_manager/ui/widgets/Screen.dart';

import '../utils/text_styles.dart';
import 'login_screen.dart';
import 'resetPasswordScreen.dart';

class OTPverificationScreen extends StatefulWidget {
  final String email;
  const OTPverificationScreen({super.key, required this.email});

  @override
  State<OTPverificationScreen> createState() => _OTPverificationScreenState();
}

class _OTPverificationScreenState extends State<OTPverificationScreen> {
  final TextEditingController _otpPinETController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen(
          widget: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pin Verification ",
              style: screenTItleTextStyle,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "A 6 digits verification code will be sent to your email address",
              style: screenSubTitleStyle,
            ),
            const SizedBox(
              height: 8,
            ),
            PinCodeTextField(
              length: 6,
              controller: _otpPinETController,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                inactiveColor: Colors.white,
                selectedColor: Colors.green,
                selectedFillColor: Colors.white,
                inactiveFillColor: Colors.white,
              ),
              animationDuration: const Duration(milliseconds: 300),
              // backgroundColor: Colors.white,
              enableActiveFill: true,
              onCompleted: (v) {
                print("Completed");
              },
              onChanged: (value) {
                print(value);
                setState(() {});
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
              appContext: context,
            ),
            const SizedBox(
              height: 16,
            ),
            AppElevetedButton(
                ontap: () async {
                  final response = await NetworkUtils.getMethod(
                      Urls.recoverVerifyOTPUrls(
                          widget.email, _otpPinETController.text.trim()));

                  if (response != null && response['status'] == 'success') {
                    if (mounted) {
                      showSnackBar(context, 'OTP verification done');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen(
                                email: widget.email,
                                otp: _otpPinETController.text)),
                      );
                    }
                  } else {
                    if (mounted) {
                      showSnackBar(context,
                          "OTP verification failed! Check your OTP and try again");
                    }
                  }
                },
                child: const Text("Verify")),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                  },
                  child: const Text("Sign In"),
                )
              ],
            )
          ],
        )),
      )),
    );
  }
}
