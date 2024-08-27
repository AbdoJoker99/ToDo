import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance.collection('tasks').withConverter<Task>(
        fromFirestore: (snapshot, options) =>
            Task.fromFireStore(snapshot.data()!),
        toFirestore: (tasks, options) => tasks.toFireStore());
    // Add data here
  }

  static Future<void> addTaskToFireStore(Task task) {
    var taskCollections = getTasksCollection();
    var taskDecRef = taskCollections.doc();
    task.id = taskDecRef.id;
    return taskDecRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task) {
    return getTasksCollection().doc(task.id).delete();
  }
}
