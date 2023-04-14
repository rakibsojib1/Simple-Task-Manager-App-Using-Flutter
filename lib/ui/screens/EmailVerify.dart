import 'package:flutter/material.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/utils/snackBarMsg.dart';
import 'package:task_manager/ui/utils/text_styles.dart';
import 'package:task_manager/ui/widgets/AppElButton.dart';
import 'package:task_manager/ui/widgets/Screen.dart';

import '../widgets/appTextFeildWidget.dart';
import 'OTPverificationScreen.dart';

class VerifyWithEmailSscreen extends StatefulWidget {
  const VerifyWithEmailSscreen({super.key});

  @override
  State<VerifyWithEmailSscreen> createState() => _VerifyWithEmailSscreenState();
}

class _VerifyWithEmailSscreenState extends State<VerifyWithEmailSscreen> {
  final TextEditingController _emailETController = TextEditingController();
  bool inProgess = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen(
          widget: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Email Address",
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
                  height: 24,
                ),
                AppTextFeildWidget(
                  hintText: "Email",
                  controller: _emailETController,
                ),
                const SizedBox(
                  height: 16,
                ),
                if (inProgess)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  AppElevetedButton(
                    child: const Icon(Icons.arrow_forward_ios),
                    ontap: () async {
                      if (formKey.currentState!.validate()) {
                        inProgess = true;
                        setState(() {});

                        final response = await NetworkUtils.getMethod(
                            Urls.recoverVerifyEmailUrls(
                                _emailETController.text.trim()));
                        if (response != null &&
                            response['status'] == 'success') {
                          if (mounted) {
                            showSnackBar(context, 'OTP sent to email address');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OTPverificationScreen(
                                          email: _emailETController.text.trim(),
                                        )));
                          }
                        } else {
                          if (mounted) {
                            showSnackBar(
                                context, 'OTP sent failed. Try again!', true);
                          }
                        }
                        inProgess = false;
                        setState(() {});
                      }
                    },
                  ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Sign In"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
