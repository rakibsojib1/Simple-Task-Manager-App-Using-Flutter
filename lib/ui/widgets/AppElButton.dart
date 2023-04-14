import 'package:flutter/material.dart';

class AppElevetedButton extends StatelessWidget {
  const AppElevetedButton(
      {super.key, required this.ontap, required this.child});

  final Widget child;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.all(8),
        ),
        onPressed: ontap,
        child: child,
      ),
    );
  }
}
