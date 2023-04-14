import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/AddNewTaskScreen.dart';
import 'package:task_manager/ui/screens/CompletedTaskScreen.dart';
import 'package:task_manager/ui/screens/NewTaskScreen.dart';
import 'package:task_manager/ui/screens/ProgressTaskScreen.dart';

import '../widgets/UserProfileWidget.dart';
import 'CancelledTaskScreen.dart';

class BotomNavBar extends StatefulWidget {
  const BotomNavBar({super.key});

  @override
  State<BotomNavBar> createState() => _BotomNavBarState();
}

class _BotomNavBarState extends State<BotomNavBar> {
  int selectedScreen = 0;
  final List<Widget> _screens = [
    const NewTaskScreen(),
    const CompletedTaskScreen(),
    const CalcelledTaskScreen(),
    const ProgressTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewTAskScreen()));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileWidget(),
            Expanded(child: _screens[selectedScreen]),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black38,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        onTap: (index) {
          selectedScreen = index;
          setState(() {});
        },
        currentIndex: selectedScreen,
        elevation: 4,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined), label: "New"),
          BottomNavigationBarItem(
              icon: Icon(Icons.task_alt_outlined), label: "Completed"),
          BottomNavigationBarItem(
              icon: Icon(Icons.cancel_outlined), label: "Cancelled"),
          BottomNavigationBarItem(
              icon: Icon(Icons.timelapse), label: "Progress"),
        ],
      ),
    );
  }
}
