import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/firbase_utils.dart';
import 'package:todo/providers/listprovider.dart';

import '../../app_colors.dart';
import '../../dialog_utils.dart';
import '../../model/task.dart';
import 'edit_task.dart';

class TaskListItemState extends StatefulWidget {
  Task task;

  TaskListItemState({required this.task});

  @override
  State<TaskListItemState> createState() => TaskListItemStateState();
}

class TaskListItemStateState extends State<TaskListItemState> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: ScrollMotion(),

          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) {
                // Delete task logic here
                FirebaseUtils.deleteTaskFromFireStore(widget.task)
                    .timeout(Duration(seconds: 1), onTimeout: () {
                  DialogUtils.showMessage(
                      context: context, content: 'task is deleted');
                  print("task is deleted");
                  listProvider.getAllTasksFromFireStore();
                });
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
            SlidableAction(
              onPressed: (context) {
                // Navigate to the EditTaskScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTask(
                      task: widget
                          .task, // Assuming EditTaskScreen is your edit screen
                    ),
                  ),
                );
              },
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        // component is not dragged.
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 0.1,
                width: 4,
                color: _isCompleted
                    ? AppColors.greenColor
                    : AppColors.primaryColor,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.task.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: _isCompleted
                              ? AppColors.greenColor
                              : AppColors.primaryColor),
                    ),
                    Text(
                      widget.task.description,
                      style: TextStyle(
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _isCompleted
                      ? AppColors.whiteColor
                      : AppColors.primaryColor,
                ),
                child: _isCompleted
                    ? Text(
                        AppLocalizations.of(context)!.done,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            _isCompleted = !_isCompleted;
                          });
                        },
                        icon: Icon(Icons.check,
                            size: 30, color: AppColors.whiteColor),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
