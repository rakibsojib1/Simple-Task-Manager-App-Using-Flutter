import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/authUtils.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/utils/snackBarMsg.dart';
import 'package:task_manager/ui/utils/text_styles.dart';
import 'package:task_manager/ui/widgets/AppElButton.dart';
import 'package:task_manager/ui/widgets/Screen.dart';
import 'package:task_manager/ui/widgets/UserProfileWidget.dart';
import 'package:task_manager/ui/widgets/appTextFeildWidget.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailETController = TextEditingController();
  final TextEditingController _firstNameETController = TextEditingController();
  final TextEditingController _lastNameETController = TextEditingController();
  final TextEditingController _mobileETController = TextEditingController();
  final TextEditingController _passwordETController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? pickedImage;
  String? base64Image;
  @override
  void initState() {
    super.initState();
    _emailETController.text = AuthUtils.email ?? '';
    _firstNameETController.text = AuthUtils.firstName ?? '';
    _lastNameETController.text = AuthUtils.lastName ?? '';
    _mobileETController.text = AuthUtils.mobile ?? '';
  }

  void updateProfile() async {
    if (_formKey.currentState!.validate()) {
      if (pickedImage != null) {
        List<int> imageBytes = await pickedImage!.readAsBytes();
        // print(imageBytes);
        base64Image = base64Encode(imageBytes);
        print("");
        print(base64Image);
      }

      Map<String, String> bodyParams = {
        'firstName': _firstNameETController.text.trim(),
        'lastName': _lastNameETController.text.trim(),
        'mobile': _mobileETController.text.trim(),
        'photo': base64Image ?? '',
      };

      if (_passwordETController.text.isNotEmpty) {
        bodyParams['password'] = _passwordETController.text;
      }

      final result = await NetworkUtils.postMethod(Urls.updatedProfileUrls,
          body: bodyParams);
      if (result != null && result['status'] == 'success') {
        await AuthUtils.saveUserData(
          result['data']['firstName'] ?? '',
          result['token'] = AuthUtils.token ?? '',
          result['data']['lastName'] ?? '',
          result['data']['photo'] ?? '',
          result['data']['mobile'] ?? '',
          result['data']['email'] ?? '',
          _passwordETController.text,
        );
        if (mounted) {
          showSnackBar(context, 'Profile data updated');
        }
      }
    }
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
                        "Update Profile",
                        style: screenTItleTextStyle,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  )),
                              child: const Text("Photo"),
                            ),
                            Expanded(
                                child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              child: Text(
                                pickedImage?.name ?? '',
                                maxLines: 1,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AppTextFeildWidget(
                        hintText: "Email",
                        readonly: true,
                        controller: _emailETController,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AppTextFeildWidget(
                        hintText: "First Name",
                        controller: _firstNameETController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AppTextFeildWidget(
                        hintText: "Last Name",
                        controller: _lastNameETController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your Last Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AppTextFeildWidget(
                        hintText: "Mobile",
                        controller: _mobileETController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your mobile number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AppTextFeildWidget(
                        hintText: "Password",
                        obscureText: true,
                        controller: _passwordETController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your Password';
                          }
                          return null;
                        },
                      ),
                      AppElevetedButton(
                          ontap: () {
                            updateProfile();
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined))
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

  void pickImage() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Pick Image From:'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () async {
                    pickedImage = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (pickedImage != null) {
                      setState(() {});
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    } else {}
                  },
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera'),
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  onTap: () async {
                    pickedImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      setState(() {});
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    } else {}
                  },
                  title: const Text('Gallery'),
                )
              ],
            ),
          );
        });
  }
}
