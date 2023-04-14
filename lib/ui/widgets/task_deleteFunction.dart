import 'package:flutter/material.dart';

import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../../main.dart';

Future<void> deleteTask(dynamic id) async {
  final TextEditingController _passwordController = TextEditingController();

  showDialog(
      context: TaskManagerApp.globalKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Really? do you want to delete?"),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Enter your login password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () async {
                final password = _passwordController.text.trim();
                final isLoggedIn = await NetworkUtils.checkUserLoggedIn(password);
                if (isLoggedIn) {
                  Navigator.pop(context);
                  await NetworkUtils.getMethod(Urls.deleteTaskUrl(id));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Incorrect password!'),
                    ),
                  );
                }
              },
              child: const Text('Yes'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      });
}
