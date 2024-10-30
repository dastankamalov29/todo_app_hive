import 'package:flutter/material.dart';

class TasksWidgetModel extends ChangeNotifier {
  int groupKey;

  TasksWidgetModel({required this.groupKey});
}

class TasksWidgetModelProvider extends InheritedNotifier {
  final TasksWidgetModel model;
  const TasksWidgetModelProvider({
    Key? key,
    required this.child,
    required this.model,
  }) : super(
          child: child,
          notifier: model
        );

  final Widget child;

  static TasksWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksWidgetModelProvider>();
  }

  static TasksWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksWidgetModelProvider>()
        ?.widget;
    return widget is TasksWidgetModelProvider ? widget : null;
  }
}




