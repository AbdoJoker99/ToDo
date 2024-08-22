import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/home/tasks_list/add_task_buttom_sheet.dart';
import 'package:todo/home/tasks_list/tasks.dart';

import 'settings/settings.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "todo";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120, // Reduced toolbar height
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _selectIndex,
        onTap: (index) {
          setState(() {
            _selectIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        // Use fixed type for better control
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/tasks.png')),
            label: AppLocalizations.of(context)!.task_list,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/settings.png')),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: AppColors.whiteColor, width: 4),
        ),
        onPressed: () {
          addTaskButtom();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 20,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(
        index: _selectIndex,
        children: [
          Tasks(),
          Settings(),
        ],
      ),
    );
  }

  void addTaskButtom() {
    showModalBottomSheet(
        context: context, builder: (context) => AddTaskButtomSheet());
  }
}
