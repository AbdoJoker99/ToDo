import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/app_colors.dart';

class AddTaskButtomSheet extends StatefulWidget {
  static final formKey = GlobalKey<FormState>();

  @override
  State<AddTaskButtomSheet> createState() => _AddTaskButtomSheetState();
}

class _AddTaskButtomSheetState extends State<AddTaskButtomSheet> {
  String titel = "";

  String disc = "";

  var selectDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
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
                    padding: const EdgeInsets.all(14.0),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'Enter task title'),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter task title';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        titel = text;
                      },
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: TextFormField(
                      decoration:
                          InputDecoration(hintText: 'Enter task description'),
                      maxLines: 4,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter task title';
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
                'Add',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTsk() {
    if (AddTaskButtomSheet.formKey.currentState?.validate() == true) {}
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
