import 'package:flutter/cupertino.dart';
import 'package:todo/firbase_utils.dart';
import 'package:todo/model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  var selectDate = DateTime.now();

  void getAllTasksFromFireStore(String uID) async {
    var querySnapshot = await FirebaseUtils.getTasksCollection(uID).get();
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

    /// Sorting
    tasksList.sort((task1, task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    });

    notifyListeners();
  }

  void changeDate(DateTime newDate, String uID) {
    selectDate = newDate;
    getAllTasksFromFireStore(uID);
    // notifyListeners();
  }
}
