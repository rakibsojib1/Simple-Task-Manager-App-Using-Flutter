import 'package:flutter/material.dart';

class TaskListItems extends StatelessWidget {
  const TaskListItems({
    super.key,
    required this.subject,
    required this.discription,
    required this.date,
    required this.type,
    required this.onEditPress,
    required this.onDeletePress,
  });
  final String subject, discription, date, type;
  final VoidCallback onEditPress, onDeletePress;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            subject,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(discription),
          const SizedBox(height: 8),
          Text("Date: $date"),
          const SizedBox(height: 6),
          Row(
            children: [
              Chip(
                label: Text(type),
                backgroundColor: Colors.blueAccent,
              ),
              const Spacer(),
              IconButton(
                onPressed: onEditPress,
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: onDeletePress,
                icon: const Icon(Icons.delete),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
