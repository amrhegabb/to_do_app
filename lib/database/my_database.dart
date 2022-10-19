import 'dart:ffi';

import 'package:to_do_app/database/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/dateUtils.dart';

class MyDatabase {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: ((snapshot, options) =>
                Task.fromFirestore(snapshot.data()!)),
            toFirestore: ((task, options) => task.tofirestor()));
  }

  static Future<void> insertTask(Task task) {
    CollectionReference<Task> tasksCollection = getTasksCollection();
    DocumentReference<Task> taskDoc = tasksCollection.doc();
    task.id = taskDoc.id;
    return taskDoc.set(task);
  }

  static Future<QuerySnapshot<Task>> getAllTasks(DateTime dateTime) async {
    var querysnapshot = await getTasksCollection()
        .where("dateTime", isEqualTo: dateOnly(dateTime).millisecondsSinceEpoch)
        .get();
    // List<Task> tasks = querysnapshot.docs
    //     .map((queryDocumentSnapshot) => queryDocumentSnapshot.data())
    //     .toList();
    return querysnapshot;
  }

  static Future<void> deleteTask(Task task) {
    DocumentReference<Task> taskdoc = getTasksCollection().doc(task.id);
    return taskdoc.delete();
  }

  static Stream<QuerySnapshot<Task>> listenforrealtimeUpdates(
      DateTime dateTime) {
    return getTasksCollection()
        .where("dateTime", isEqualTo: dateOnly(dateTime).millisecondsSinceEpoch)
        .snapshots();
  }
}
