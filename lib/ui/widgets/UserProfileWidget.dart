import 'package:flutter/material.dart';
import 'package:task_manager/data/authUtils.dart';
import 'package:task_manager/ui/screens/login_screen.dart';

import '../screens/UpdateProfileScreen.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UpdateProfileScreen()),
        );
      },
      title: Text('${AuthUtils.firstName ?? ' '} ${AuthUtils.lastName ?? ' '}'),
      subtitle: Text(AuthUtils.email ?? 'Unknown'),
      trailing: IconButton(
        onPressed: () async {
          await AuthUtils.clearData();
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        },
        icon: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ),
      tileColor: Colors.green,
      leading: const CircleAvatar(
          child: Icon(Icons.person) //I try hard to show profile pic but failed.
          ),
    );
  }
}
