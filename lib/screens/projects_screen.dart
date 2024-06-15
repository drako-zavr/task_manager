import 'package:flutter/material.dart';
import 'package:task_manager/blocs/bloc_exports.dart';

import '../widgets/tasks_list.dart';
import 'my_drawer.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});
  static const id = 'projects_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Projects'),
          ),
          drawer: MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [TasksList(tasksList: state.removedTasks)],
          ),
        );
      },
    );
  }
}
