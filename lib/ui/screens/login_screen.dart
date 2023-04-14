import 'package:flutter/material.dart';
import 'package:task_manager/data/authUtils.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/ui/utils/snackBarMsg.dart';
import 'package:task_manager/ui/widgets/Screen.dart';

import '../../data/urls.dart';
import '../utils/text_styles.dart';
import '../widgets/AppElButton.dart';
import '../widgets/appTextFeildWidget.dart';
import 'EmailVerify.dart';
import 'SignUpScreen.dart';
import 'main_bottom_navBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailEtContriller = TextEditingController();
  final TextEditingController _passwordEtContriller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _inProgress = false;

  Future<void> login() async {
    _inProgress = true;
    setState(() {});
    final result = await NetworkUtils.postMethod(
      Urls.loginUrl,
      body: {
        'email': _emailEtContriller.text.trim(),
        'password': _passwordEtContriller.text.trim(),
      },
      onUnAuthorize: () {
        showSnackBar(context, 'UserName and Password incorrect', true);
      },
    );
    _inProgress = false;
    setState(() {});
    if (result != null && result['status'] == 'success') {
      await AuthUtils.saveUserData(
        result['data']['firstName'],
        result['token'],
        result['data']['lastName'],
        result['data']['photo'],
        result['data']['mobile'],
        result['data']['email'],
        _passwordEtContriller.text.trim(),
      );

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BotomNavBar()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen(
          widget: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Get Started With",
                    style: screenTItleTextStyle,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  AppTextFeildWidget(
                    hintText: 'Email',
                    controller: _emailEtContriller,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  AppTextFeildWidget(
                    obscureText: true,
                    hintText: 'Password',
                    controller: _passwordEtContriller,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  if (_inProgress)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    )
                  else
                    AppElevetedButton(
                      child: const Icon(Icons.arrow_right_alt_outlined),
                      ontap: () async {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                    ),
                  const SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const VerifyWithEmailSscreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text("Sign Up"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
