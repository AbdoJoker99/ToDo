import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../app_colors.dart';
import 'edit_task.dart';

class TaskListItemState extends StatefulWidget {
  @override
  State<TaskListItemState> createState() => TaskListItemStateState();
}

class TaskListItemStateState extends State<TaskListItemState> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
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
              onPressed: null,
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) {
                // Navigate to the EditTaskScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditTask(), // Assuming EditTaskScreen is your edit screen
                  ),
                );
              },
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'edit',
            ),
          ],
        ),

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              flex: 2,
              onPressed: doNothing,
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.archive,
              label: 'Archive',
            ),
            SlidableAction(
              onPressed: doNothing,
              backgroundColor: Color(0xFF0392CF),
              foregroundColor: Colors.white,
              icon: Icons.save,
              label: 'Save',
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
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
                      "title",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: _isCompleted
                              ? AppColors.greenColor
                              : AppColors.primaryColor),
                    ),
                    Text(
                      "description",
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
                        'Done!',
                        style: TextStyle(
                          color: AppColors.greenColor,
                          fontSize: 30,
                        ),
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

  void doNothing(BuildContext context) {}
}
