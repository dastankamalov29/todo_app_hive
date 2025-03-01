import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app_hive/domain/entity/group.dart';
import 'package:todo_app_hive/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GroupsWidgetModel extends ChangeNotifier {
  var _groups = <Group>[];

  List<Group> get groups => _groups.toList();

  GroupsWidgetModel() {
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/groups/form');
  }

  void showTasks(BuildContext context, int groupIndex) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    box.keyAt(groupIndex);
    final groupKey = box.keyAt(groupIndex) as int;

    unawaited(
      Navigator.of(context).pushNamed('/groups/tasks', arguments: groupKey),
    );
  }

  void deleteGroup(int groupIndex) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    await box.deleteAt(groupIndex);
  }

  void _readGroupsFromHive(Box<Group> box) {
    _groups = box.values.toList();
    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    _readGroupsFromHive(box);
    box.listenable().addListener(
          () => _readGroupsFromHive(box),
        );
  }
}

class GroupsWidgetModelProvider extends InheritedNotifier {
  final GroupsWidgetModel model;
  GroupsWidgetModelProvider({
    Key? key,
    required this.model,
    required this.child,
  }) : super(
          child: child,
          notifier: model,
        );

  final Widget child;

  static GroupsWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupsWidgetModelProvider>();
  }

  static GroupsWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupsWidgetModelProvider>()
        ?.widget;
    return widget is GroupsWidgetModelProvider ? widget : null;
  }
}
