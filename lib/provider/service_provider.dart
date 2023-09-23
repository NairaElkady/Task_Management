import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagemet/model/task_model.dart';
import 'package:taskmanagemet/services/task_services.dart';

final serviceProvider = StateProvider<TaskServices>((ref) {
  return TaskServices();
});

final fetchDateProvider = StreamProvider<List<TaskModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('taskManagement')
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => TaskModel.fromSnapshot(snapshot))
          .toList());
  yield* getData;
});
