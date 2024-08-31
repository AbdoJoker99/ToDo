import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/task.dart';

import 'model/my_user.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection(String uID) {
    return getUsersCollection()
        .doc(uID)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (tasks, options) => tasks.toFireStore());
    // Add data here
  }

  static Future<void> addTaskToFireStore(Task task, String uID) {
    var taskCollections = getTasksCollection(uID);
    var taskDecRef = taskCollections.doc();
    task.id = taskDecRef.id;
    return taskDecRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task, String uID) {
    return getTasksCollection(uID).doc(task.id).delete();
  }

  /// Updates a task in Firestore for a specific user.
  static Future<void> updateTask(Task task, String uID) async {
    await getTasksCollection(uID).doc(task.id).update(task.toFireStore());
  }

  /// Marks a task as done in Firestore for a specific user.
  static Future<void> doneTask(Task task, String uID) async {
    await getTasksCollection(uID).doc(task.id).update({"isDone": task.isDone});
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: ((snapshot, options) =>
              MyUser.fromFirestore(snapshot.data()!)),
          toFirestore: (user, _) => user.toFirestore(),
        );
  }

  static Future<void> adduserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFirestore(String uId) async {
    var snapshot = await getUsersCollection().doc(uId).get();
    return snapshot.data();
  }
}
