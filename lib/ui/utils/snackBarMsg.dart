import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String msg, [bool error = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: error ? Colors.red : null,
    ),
  );
}
