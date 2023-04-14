import 'package:flutter/material.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/utils/snackBarMsg.dart';
import 'package:task_manager/ui/widgets/Screen.dart';

import '../utils/text_styles.dart';
import '../widgets/AppElButton.dart';
import '../widgets/appTextFeildWidget.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email, otp;
  const ResetPasswordScreen(
      {super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passEtController = TextEditingController();
  final TextEditingController _confirmPassETController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen(
          widget: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reset Password",
                  style: screenTItleTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "A secure password should be at least 8 characters long and include both letters and numbers.",
                  style: screenSubTitleStyle,
                ),
                const SizedBox(
                  height: 24,
                ),
                AppTextFeildWidget(
                  hintText: "Password",
                  controller: _passEtController,
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextFeildWidget(
                  hintText: "Confirm Password",
                  controller: _confirmPassETController,
                  validator: (String? value) {
                    if ((value?.isEmpty ?? true) ||
                        ((value ?? '') != _passEtController.text)) {
                      return 'Password did not match';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AppElevetedButton(
                  ontap: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await NetworkUtils.postMethod(
                          Urls.resetPassUrls,
                          body: {
                            'email': widget.email,
                            'OTP': widget.otp,
                            'password': _confirmPassETController.text,
                          });
                      if (response != null && response['status'] == 'success') {
                        if (mounted) {
                          showSnackBar(context, "Password Reset Seccess");
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (route) => false);
                        }
                      } else {
                        if (mounted) {
                          showSnackBar(context,
                              "Password Reset failed! please try again.");
                        }
                      }
                    }
                  },
                  child: const Text("Confirm"),
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
