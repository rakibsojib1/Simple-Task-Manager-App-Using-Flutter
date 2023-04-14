import 'package:flutter/material.dart';

class DeshboardIteamWidget extends StatelessWidget {
  const DeshboardIteamWidget({
    super.key,
    required this.numberOfTask,
    required this.typeOfTask,
  });
  final int numberOfTask;
  final String typeOfTask;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              numberOfTask.toString(),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            FittedBox(child: Text(typeOfTask))
          ],
        ),
      ),
    );
  }
}
