import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/home/tasks_list/task_list_item.dart';
import 'package:todo/providers/listprovider.dart';
import 'package:todo/providers/user_provider.dart';

class Tasks extends StatefulWidget {
  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    var listprovider = Provider.of<ListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    if (listprovider.tasksList.isEmpty) {
      listprovider.getAllTasksFromFireStore(userProvider.currentUser!.id);
    }
    return Container(
      child: Column(
        children: [
          EasyDateTimeLine(
            activeColor: AppColors.whiteColor,
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
              listprovider.changeDate(
                  selectedDate, userProvider.currentUser!.id);
            },
            headerProps: const EasyHeaderProps(
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.fullDateDMY(),
            ),
            dayProps: const EasyDayProps(
              dayStructure: DayStructure.dayStrDayNum,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff3371FF),
                      Color(0xECEEF3FF),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: listprovider.tasksList.isEmpty
                ? Center(
                    child: Text(
                      "No task is added",
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return TaskListItem(
                        task: listprovider.tasksList[index],
                      );
                    },
                    itemCount: listprovider.tasksList.length,
                  ),
          ),
        ],
      ),
    );
  }
}
