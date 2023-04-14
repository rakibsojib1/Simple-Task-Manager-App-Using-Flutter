import 'package:flutter/material.dart';
import 'package:task_manager/main.dart';

import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/snackBarMsg.dart';
import 'AppElButton.dart';

showChangeTaskStatus(
  bool mounted,
  String currentStatus,
  String taskId,
  VoidCallback onTaskCompleted,
  
) {
  String statusValue = currentStatus;

  showModalBottomSheet(
      context: TaskManagerApp.globalKey.currentContext!,
      builder: (context) {
        return StatefulBuilder(
          builder: (
            context,
            changeState,
          ) {
            return Column(
              children: [
                RadioListTile(
                  value: "New",
                  title: const Text("New"),
                  groupValue: statusValue,
                  onChanged: (state) {
                    statusValue = state!;
                    changeState(() {});
                  },
                ),
                RadioListTile(
                  value: "Completed",
                  title: const Text("Completed"),
                  groupValue: statusValue,
                  onChanged: (state) {
                    statusValue = state!;
                    changeState(() {});
                  },
                ),
                RadioListTile(
                  value: "Cancelled",
                  title: const Text("Cancelled"),
                  groupValue: statusValue,
                  onChanged: (state) {
                    statusValue = state!;
                    changeState(() {});
                  },
                ),
                RadioListTile(
                  value: "Progress",
                  title: const Text("Progress"),
                  groupValue: statusValue,
                  onChanged: (state) {
                    statusValue = state!;
                    changeState(() {});
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AppElevetedButton(
                    ontap: () async {
                      final response = await NetworkUtils.getMethod(
                          Urls.changeTaskStatusUrls(taskId, statusValue));
                      if (response != null) {
                        if (mounted) {
                          Navigator.pop(context);
                        }

                        onTaskCompleted();
                      } else {
                        if (mounted) {
                          showSnackBar(context,
                              "Status Changed Failed, Please Try again!");
                        }
                      }
                    },
                    child: const Text("Change Status"),
                  ),
                ),
              ],
            );
          },
        );
      });
}
