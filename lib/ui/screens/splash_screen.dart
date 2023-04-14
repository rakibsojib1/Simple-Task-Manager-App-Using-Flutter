import 'package:flutter/material.dart';
import 'package:task_manager/data/authUtils.dart';
import 'package:task_manager/ui/screens/login_screen.dart';

import '../widgets/Screen.dart';
import 'main_bottom_navBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      checkUserAuthState();
    });
  }

  void checkUserAuthState() async {
    final bool result = await AuthUtils.checkLoginState();
    if (result) {
      await AuthUtils.geetAuthData();
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BotomNavBar()),
          (route) => false);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Screen(
      widget: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 150,
          //height: 150,
          fit: BoxFit.scaleDown,
        ),
      ),
    ));
  }
}
