import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/snackBarMsg.dart';
import '../widgets/Screen.dart';
import '../widgets/TaskListItem.dart';
import '../widgets/statusChangeBottom_shit.dart';
import '../widgets/statusCounter.dart';
import '../widgets/task_deleteFunction.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  TaskModel inProgressTaskModel = TaskModel();
  final StatusCounter _statusCounter = const StatusCounter();
  bool inProgress = false;
  @override
  void initState() {
    super.initState();
    getAllinProgressTask();
  }

  Future<void> getAllinProgressTask() async {
    inProgress = true;
    setState(() {});
    final response = await NetworkUtils.getMethod(Urls.inProgressTaskUrls);
    if (response != null) {
      inProgressTaskModel = TaskModel.fromJson(response);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context, "Unable to fetch 'inProgress' task, please try again!");
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
                      getAllinProgressTask();
                    },
                    child: ListView.builder(
                      itemCount: inProgressTaskModel.data?.length ?? 0,
                      //reverse: true,
                      itemBuilder: (context, index) {
                        return TaskListItems(
                          date: inProgressTaskModel.data?[index].createdDate ??
                              "Unknown",
                          discription:
                              inProgressTaskModel.data?[index].description ??
                                  "Unknown",
                          type: 'Cancelled',
                          onDeletePress: () {
                            deleteTask(
                                inProgressTaskModel.data?[index].sId ?? "");
                            getAllinProgressTask();
                            _statusCounter.createState();
                            setState(() {});
                          },
                          onEditPress: () {
                            
                            showChangeTaskStatus(mounted, 'Completed',
                                inProgressTaskModel.data?[index].sId ?? "", () {
                              getAllinProgressTask();
                              _statusCounter.createState();
                              setState(() {});
                            });
                          },
                          subject: inProgressTaskModel.data?[index].title ??
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
