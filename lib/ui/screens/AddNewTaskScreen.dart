import 'package:flutter/material.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/ui/utils/snackBarMsg.dart';
import 'package:task_manager/ui/utils/text_styles.dart';
import 'package:task_manager/ui/widgets/AppElButton.dart';
import 'package:task_manager/ui/widgets/Screen.dart';
import 'package:task_manager/ui/widgets/UserProfileWidget.dart';
import 'package:task_manager/ui/widgets/appTextFeildWidget.dart';

import '../../data/urls.dart';
import 'main_bottom_navBar.dart';
import 'package:intl/intl.dart';

class AddNewTAskScreen extends StatefulWidget {
  const AddNewTAskScreen({super.key});

  @override
  State<AddNewTAskScreen> createState() => _AddNewTAskScreenState();
}

class _AddNewTAskScreenState extends State<AddNewTAskScreen> {
  final TextEditingController subjectETController = TextEditingController();
  final TextEditingController descriptionETController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _inProgress = false;

  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('dd-MM-yyyy').format(now);
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const UserProfileWidget(),
          Expanded(
              child: Screen(
            widget: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Add New TAsk",
                        style: screenTItleTextStyle,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      AppTextFeildWidget(
                        hintText: "Subject",
                        controller: subjectETController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter  Subject';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextFeildWidget(
                        hintText: "Descriptions",
                        maxLine: 10,
                        controller: descriptionETController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Write task description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      if (_inProgress)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      else
                        AppElevetedButton(
                            ontap: () async {
                              if (_formKey.currentState!.validate()) {
                                _inProgress = true;
                                setState(() {});
                                final result = await NetworkUtils.postMethod(
                                  Urls.createnewtaskUrl,
                                  body: {
                                    "title": subjectETController.text.trim(),
                                    "description":
                                        descriptionETController.text.trim(),
                                    "status": "New",
                                    "createdDate": getCurrentDateTime(),
                                  },
                                );
                                _inProgress = false;
                                setState(() {});
                                if (result != null &&
                                    result["status"] == 'success') {
                                  // ignore: use_build_context_synchronously
                                  showSnackBar(context, "New Task added");
                                  if (mounted) {}
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BotomNavBar()),
                                      (route) => false);
                                  subjectETController.clear();
                                  descriptionETController.clear();
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showSnackBar(context,
                                      "New Task add Failed! Try again", true);
                                }
                              }
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined))
                    ],
                  ),
                ),
              ),
            ),
          ))
        ],
      )),
    );
  }
}
