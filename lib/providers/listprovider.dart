import 'package:flutter/cupertino.dart';
import 'package:todo/firbase_utils.dart';
import 'package:todo/model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  var selectDate = DateTime.now();

  void getAllTasksFromFireStore() async {
    var querySnapshot = await FirebaseUtils.getTasksCollection().get();
    // List<Task> => List<QueryDocumentSnapshot<Task>>
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data() as Task;
    }).toList();

    /// filter tasks => select date (user)
    tasksList = tasksList.where((task) {
      if (selectDate.day == task.dateTime.day &&
          selectDate.month == task.dateTime.month &&
          selectDate.year == task.dateTime.year) {
        return true;
      }
      return false;
    }).toList();

    notifyListeners();
  }

  void changeDate(DateTime newDate) {
    selectDate = newDate;
    getAllTasksFromFireStore();
    // notifyListeners();
  }
}
