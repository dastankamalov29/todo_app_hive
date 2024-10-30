import 'package:flutter/material.dart';
import 'package:todo_app_hive/widgets/group_form_widget/group_form_widget.dart';
import 'package:todo_app_hive/widgets/task_form/task_form_widget.dart';
import 'package:todo_app_hive/widgets/tasks/tasks_widget.dart';

import '../groups/groups_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      routes: {
        '/groups': (context) => GroupsWidget(),
        '/groups/form': (context) => GroupFormWidget(),
        '/groups/tasks': (context) => TasksWidget(),
        '/groups/tasks/form': (context) => TaskFormWidget(),
      },
      initialRoute: '/groups',
      theme: ThemeData(primaryColor: Colors.blue),
    );
  }
}
