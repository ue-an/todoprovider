import 'package:flutter/foundation.dart';
import 'package:todoprovider/models/Task-model.dart';
import 'package:flutter/material.dart';

class Todo with ChangeNotifier {
  List<Task> tasklist = [
    // Task(title: 'title', content: 'content'),
    // Task(title: 'titles', content: 'contents'),
  ];

  Future addToTaskList(String title, String content) {
    if (title != null && content != null) {
      tasklist.add(Task(title: title, content: content) ?? '');
    }
    notifyListeners();
  }

  void removeAtIndex(int index) {
    tasklist.removeAt(index);
    notifyListeners();
  }
}
