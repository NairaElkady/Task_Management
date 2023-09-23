import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmanagemet/model/task_model.dart';

class TaskServices {
  final taskCollection =
      FirebaseFirestore.instance.collection('taskManagement');

  void addNewTask(TaskModel model) {
    taskCollection.add(model.toMap());
  }

  void updateTask(String? docId, bool valueUpdate) {
    taskCollection.doc(docId).update({'isDone': valueUpdate});
  }

  void deletTask(String? docId) {
    taskCollection.doc(docId).delete();
  }
}
