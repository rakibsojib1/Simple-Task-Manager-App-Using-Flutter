import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/snackBarMsg.dart';
import '../widgets/Screen.dart';
import '../widgets/TaskListItem.dart';
import '../widgets/deshboardItem.dart';
import '../widgets/statusChangeBottom_shit.dart';
import '../widgets/statusCounter.dart';
import '../widgets/task_deleteFunction.dart';

class CalcelledTaskScreen extends StatefulWidget {
  const CalcelledTaskScreen({super.key});

  @override
  State<CalcelledTaskScreen> createState() => _CalcelledTaskScreenState();
}

class _CalcelledTaskScreenState extends State<CalcelledTaskScreen> {
  TaskModel cancelledTaskModel = TaskModel();
  final StatusCounter _statusCounter = const StatusCounter();
  bool inProgress = false;
  @override
  void initState() {
    super.initState();
    getAllCancelledTask();
  }

  Future<void> getAllCancelledTask() async {
    inProgress = true;
    setState(() {});
    final response = await NetworkUtils.getMethod(Urls.cancelledTaskUrls);
    if (response != null) {
      cancelledTaskModel = TaskModel.fromJson(response);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context, "Unable to fetch cancelled task, please try again!");
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
                      getAllCancelledTask();
                    },
                    child: ListView.builder(
                      itemCount: cancelledTaskModel.data?.length ?? 0,
                      //reverse: true,
                      itemBuilder: (context, index) {
                        return TaskListItems(
                          date: cancelledTaskModel.data?[index].createdDate ??
                              "Unknown",
                          discription:
                              cancelledTaskModel.data?[index].description ??
                                  "Unknown",
                          type: 'Cancelled',
                          onDeletePress: () {
                            deleteTask(
                                cancelledTaskModel.data?[index].sId ?? "");
                            _statusCounter.statusCount();
                            setState(() {});
                          },
                          onEditPress: () {
                            showChangeTaskStatus(mounted, 'Completed',
                                cancelledTaskModel.data?[index].sId ?? "", () {
                              getAllCancelledTask();
                              _statusCounter.statusCount();
                              setState(() {});
                            });
                          },
                          subject: cancelledTaskModel.data?[index].title ??
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
