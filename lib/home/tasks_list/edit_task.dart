import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/firbase_utils.dart';
import 'package:todo/model/task.dart';

import '../../providers/listprovider.dart';
import '../../providers/user_provider.dart';

class EditTask extends StatefulWidget {
  final Task task;

  const EditTask({super.key, required this.task});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final detailsController = TextEditingController();
  var selectDate = DateTime.now();
  late ListProvider listProvider;
  late UserProvider userProvider;

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        style: TextStyle(color: AppColors.blackColor),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.title,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColors.blackColor),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a title";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          widget.task.title = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: detailsController,
                        style: TextStyle(color: AppColors.blackColor),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.details,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColors.blackColor),
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter details description ";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          widget.task.description = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.select_date,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          ShowCelender();
                        },
                        child: Text(
                          '${selectDate.day}/${selectDate.month}/${selectDate.year}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FirebaseUtils.updateTask(
                                widget.task, userProvider.currentUser!.id);
                            listProvider.getAllTasksFromFireStore(
                                userProvider.currentUser!.id);
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.changes,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void ShowCelender() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );
    if (chosenDate != null) {
      selectDate = chosenDate;
      widget.task.dateTime = chosenDate;
    }
    selectDate = chosenDate ?? selectDate;
    setState(() {});
  }
}
