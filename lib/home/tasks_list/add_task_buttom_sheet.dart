import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/firbase_utils.dart';
import 'package:todo/model/task.dart';
import 'package:todo/providers/listprovider.dart';

import '../../dialog_utils.dart';
import '../../providers/user_provider.dart';

class AddTaskButtomSheet extends StatefulWidget {
  static final formKey = GlobalKey<FormState>();

  const AddTaskButtomSheet({super.key});

  @override
  State<AddTaskButtomSheet> createState() => _AddTaskButtomSheetState();
}

class _AddTaskButtomSheetState extends State<AddTaskButtomSheet> {
  String titel = "";

  String disc = "";

  var selectDate = DateTime.now();

  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              //textAlign: TextAlignVertical.center,
              AppLocalizations.of(context)!.add_new_task,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Form(
              key: AddTaskButtomSheet.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(14.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.title,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColors.blackColor),
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter task title';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        titel = text;
                      },
                      style: const TextStyle(color: AppColors.blackColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.details,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColors.blackColor),
                      ),
                      maxLines: 4,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter task descrip-tion';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        disc = text;
                      },
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.select_date,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ), // Text
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          ShowCelender();
                        },
                        child: Text(
                          '${selectDate.day}/${selectDate.month}/'
                          '${selectDate.year}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.primaryColor),
              ),
              onPressed: () {
                addTsk();
              },
              child: Text(
                AppLocalizations.of(context)!.add,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTsk() {
    if (AddTaskButtomSheet.formKey.currentState?.validate() == true) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      Task task = Task(title: titel, description: disc, dateTime: selectDate);
      FirebaseUtils.addTaskToFireStore(task, userProvider.currentUser!.id).then(
        (value) {
          print("Task  is added");
          listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id);
          Navigator.pop(context);
        },
      ).timeout(Duration(seconds: 1), onTimeout: () {
        DialogUtils.showMessage(context: context, content: 'Task  is added');
      });
    }
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
    }
    selectDate = chosenDate ?? selectDate;
    setState(() {});
  }
}
