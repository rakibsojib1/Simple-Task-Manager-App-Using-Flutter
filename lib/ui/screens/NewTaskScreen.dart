import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/utils/snackBarMsg.dart';
import 'package:task_manager/ui/widgets/Screen.dart';

import '../widgets/TaskListItem.dart';
import '../widgets/deshboardItem.dart';
import '../widgets/statusChangeBottom_shit.dart';
import '../widgets/statusCounter.dart';
import '../widgets/task_deleteFunction.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  TaskModel newTaskModel = TaskModel();
  bool inProgress = false;
  final StatusCounter _statusCounter = const StatusCounter();

  @override
  void initState() {
    super.initState();
    getAllNewTask();
    _statusCounter.statusCount();
  }

  Future<void> getAllNewTask() async {
    inProgress = true;
    setState(() {});
    final response = await NetworkUtils.getMethod(Urls.newTaskUrls);
    if (response != null) {
      newTaskModel = TaskModel.fromJson(response);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context, "Unable to fetch new task, please try again!");
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
                      getAllNewTask();
                    },
                    child: ListView.builder(
                      itemCount: newTaskModel.data?.length ?? 0,
                      //reverse: true,
                      itemBuilder: (context, index) {
                        return TaskListItems(
                          date: newTaskModel.data?[index].createdDate ??
                              "Unknown",
                          discription: newTaskModel.data?[index].description ??
                              "Unknown",
                          type: 'New',
                          onDeletePress: () {
                            deleteTask(newTaskModel.data?[index].sId ?? "");
                            setState(() {
                              getAllNewTask();
                              _statusCounter.statusCount();
                            });
                          },
                          onEditPress: () {
                            showChangeTaskStatus(mounted, 'New',
                                newTaskModel.data?[index].sId ?? "", () {
                              getAllNewTask();
                              _statusCounter.statusCount();
                              setState(() {});
                            });
                          },
                          subject: newTaskModel.data?[index].title ?? "Unknown",
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
