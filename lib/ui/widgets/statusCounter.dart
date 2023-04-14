import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import 'deshboardItem.dart';

class StatusCounter extends StatefulWidget {
  const StatusCounter({super.key});

  @override
  State<StatusCounter> createState() => _StatusCounterState();

  void statusCount() {}
}

class _StatusCounterState extends State<StatusCounter> {
  
  int count1 = 0;
  int count2 = 0;
  int count3 = 0;
  int count4 = 0;

  @override
  void initState() {
    super.initState();
    statusCount();
  }

  Future<void> statusCount() async {
    final newTaskResponse = await NetworkUtils.getMethod(Urls.newTaskUrls);
    final newTaskModel = TaskModel.fromJson(newTaskResponse);

    setState(() {
      count1 = newTaskModel.data?.length ?? 0;
    });

    final cancelledTaskResponse =
        await NetworkUtils.getMethod(Urls.cancelledTaskUrls);
    final cancelledTaskModel = TaskModel.fromJson(cancelledTaskResponse);
    setState(() {
      count2 = cancelledTaskModel.data?.length ?? 0;
    });

    final completedTaskResponse =
        await NetworkUtils.getMethod(Urls.cpmpletedTaskUrls);

    final completedTaskModel = TaskModel.fromJson(completedTaskResponse);
    setState(() {
      count3 = completedTaskModel.data?.length ?? 0;
    });

    final inProgressResponse =
        await NetworkUtils.getMethod(Urls.inProgressTaskUrls);
    final inProgressTaskModel = TaskModel.fromJson(inProgressResponse);
    setState(() {
      count4 = inProgressTaskModel.data?.length ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DeshboardIteamWidget(
            numberOfTask: count1,
            typeOfTask: "New",
          ),
        ),
        Expanded(
          child: DeshboardIteamWidget(
            numberOfTask: count3,
            typeOfTask: "Completed",
          ),
        ),
        Expanded(
          child: DeshboardIteamWidget(
            numberOfTask: count2,
            typeOfTask: "Cancelled",
          ),
        ),
        Expanded(
          child: DeshboardIteamWidget(
            numberOfTask: count4,
            typeOfTask: "Progress",
          ),
        ),
      ],
    );
  }
}
