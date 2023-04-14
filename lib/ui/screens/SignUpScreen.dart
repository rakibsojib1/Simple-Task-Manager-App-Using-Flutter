import 'package:flutter/material.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/ui/utils/snackBarMsg.dart';
import 'package:task_manager/ui/widgets/AppElButton.dart';

import '../../data/urls.dart';
import '../utils/text_styles.dart';
import '../widgets/Screen.dart';
import '../widgets/appTextFeildWidget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailETcontroller = TextEditingController();
  final TextEditingController firstNameETcontroller = TextEditingController();
  final TextEditingController lastNameETcontroller = TextEditingController();
  final TextEditingController mobileETcontroller = TextEditingController();
  final TextEditingController passwordETcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _inProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen(
        widget: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Text("Join with Us", style: screenTItleTextStyle),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextFeildWidget(
                    controller: emailETcontroller,
                    hintText: "Email",
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your valid Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextFeildWidget(
                    controller: firstNameETcontroller,
                    hintText: "First Name",
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextFeildWidget(
                    controller: lastNameETcontroller,
                    hintText: "Last Name",
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your Last Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextFeildWidget(
                    controller: mobileETcontroller,
                    hintText: "Mobile",
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextFeildWidget(
                    controller: passwordETcontroller,
                    hintText: "Password",
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (_inProgress)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    )
                  else
                    AppElevetedButton(
                      ontap: () async {
                        if (_formKey.currentState!.validate()) {
                          _inProgress = true;
                          setState(() {});
                          final result = await NetworkUtils.postMethod(
                              Urls.registrationUrl,
                              body: {
                                'email': emailETcontroller.text.trim(),
                                'firstName': firstNameETcontroller.text.trim(),
                                'lastName': lastNameETcontroller.text.trim(),
                                'mobile': mobileETcontroller.text.trim(),
                                'password': passwordETcontroller.text,
                              });
                          _inProgress = false;
                          setState(() {});

                          if (result != null && result['status'] == 'success') {
                            emailETcontroller.clear;
                            firstNameETcontroller.clear;
                            lastNameETcontroller.clear;
                            mobileETcontroller.clear;
                            passwordETcontroller.clear;

                            // ignore: use_build_context_synchronously
                            showSnackBar(
                                context, "Registration Success", false);
                          } else {
                            // ignore: use_build_context_synchronously
                            showSnackBar(context,
                                "Registration failed. Try again!", true);
                          }
                        }
                      },
                      child: const Icon(Icons.arrow_right_alt_outlined),
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
      ),
    );
  }
}
