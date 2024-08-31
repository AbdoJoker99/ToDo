import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/firbase_utils.dart';
import 'package:todo/providers/listprovider.dart';
import 'package:todo/providers/user_provider.dart'; // Import UserProvider

import '../../app_colors.dart';
import '../../dialog_utils.dart';
import '../../model/task.dart';
import 'edit_task.dart';

class TaskListItem extends StatefulWidget {
  final Task task;

  const TaskListItem({Key? key, required this.task}) : super(key: key);

  @override
  TaskListItemState createState() => TaskListItemState();
}

class TaskListItemState extends State<TaskListItem> {
  bool _isCompleted = false;
  late ListProvider listProvider;
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    userProvider =
        Provider.of<UserProvider>(context); // Get UserProvider instance

    return Container(
      margin: const EdgeInsets.all(10),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context) {
                FirebaseUtils.deleteTaskFromFireStore(
                  widget.task,
                  userProvider.currentUser!.id,
                ).then((value) {
                  print("task is deleted");
                  listProvider
                      .getAllTasksFromFireStore(userProvider.currentUser!.id);
                }).timeout(const Duration(seconds: 1), onTimeout: () {
                  DialogUtils.showMessage(
                    context: context,
                    content: 'task is deleted',
                  );
                }).catchError((error) {
                  DialogUtils.showMessage(
                    context: context,
                    content: 'Error deleting task',
                  );
                });
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTask(
                      task: widget.task,
                    ),
                  ),
                );
              },
              backgroundColor: const Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
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
                                : AppColors.primaryColor,
                          ),
                    ),
                    Text(
                      widget.task.description,
                      style: const TextStyle(
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _isCompleted
                      ? AppColors.whiteColor
                      : AppColors.primaryColor,
                ),
                child: _isCompleted
                    ? Text(
                        AppLocalizations.of(context)!.done,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.green),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            _isCompleted = !_isCompleted;
                            widget.task.isDone = true;
                            FirebaseUtils.doneTask(
                              widget.task,
                              userProvider.currentUser!.id,
                            );
                            listProvider.getAllTasksFromFireStore(
                                userProvider.currentUser!.id);
                          });
                        },
                        icon: const Icon(
                          Icons.check,
                          size: 30,
                          color: AppColors.whiteColor,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
