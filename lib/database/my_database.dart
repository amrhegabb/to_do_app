import 'package:to_do_app/database/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDatabase {
  static Future<void> insertTask(Task task) {
    CollectionReference<Task> tasksCollection = getTasksCollection();
    DocumentReference<Task> taskDoc = tasksCollection.doc();
    task.id = taskDoc.id;
    return taskDoc.set(task);
  }

  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: ((snapshot, options) =>
                Task.fromFirestore(snapshot.data()!)),
            toFirestore: ((task, options) => task.tofirestor()));
  }
}
