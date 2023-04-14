import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/Screen.dart';
import 'package:task_manager/ui/widgets/statusChangeBottom_shit.dart';

import '../../data/models/task_model.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/snackBarMsg.dart';
import '../widgets/TaskListItem.dart';

import '../widgets/statusCounter.dart';
import '../widgets/task_deleteFunction.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  TaskModel completedTaskModel = TaskModel();
  bool inProgress = false;
   final StatusCounter _statusCounter = const StatusCounter();
  @override
  void initState() {
    super.initState();
    getAllCompletedTask();
  }

  Future<void> getAllCompletedTask() async {
    inProgress = true;
    setState(() {});
    final response = await NetworkUtils.getMethod(Urls.cpmpletedTaskUrls);
    if (response != null) {
      completedTaskModel = TaskModel.fromJson(response);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context, "Unable to fetch Completed task, please try again!");
    }
    inProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen(
        widget: Column(children: [
          const StatusCounter(),
          Expanded(
            child: inProgress
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      getAllCompletedTask();
                    },
                    child: ListView.builder(
                      itemCount: completedTaskModel.data?.length ?? 0,
                      //reverse: true,
                      itemBuilder: (context, index) {
                        return TaskListItems(
                          date: completedTaskModel.data?[index].createdDate ??
                              "Unknown",
                          discription:
                              completedTaskModel.data?[index].description ??
                                  "Unknown",
                          type: 'Completed',
                          onDeletePress: () {
                            deleteTask(
                                completedTaskModel.data?[index].sId ?? "");
                            getAllCompletedTask();
                            _statusCounter.createState();
                            setState(() {});
                          },
                          onEditPress: () {
                            showChangeTaskStatus(mounted, 'Completed',
                                completedTaskModel.data?[index].sId ?? "", () {
                              getAllCompletedTask();
                              _statusCounter.createState();
                              setState(() {});
                            });
                          },
                          subject: completedTaskModel.data?[index].title ??
                              "Unknown",
                        );
                      },
                    ),
                  ),
          )
        ]),
      ),
    );
  }
}
