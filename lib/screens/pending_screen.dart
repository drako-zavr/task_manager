import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/widgets/task_tile.dart';

// import '../models/task.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../widgets/tasks_list.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({Key? key}) : super(key: key);
  static const id = 'tasks_screen';

  @override
  Widget build(BuildContext context) {
    //   return BlocBuilder<TasksBloc, TasksState>(
    //     builder: (context, state) {
    //       List<Task> tasksList = state.pendingTasks;
    //       return Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           // Center(
    //           //   child: Chip(
    //           //     label: Text(
    //           //       '${tasksList.length} Pending | ${state.completedTasks.length} Completed',
    //           //     ),
    //           //   ),
    //           // ),
    //           TasksList(tasksList: tasksList)
    //         ],
    //       );
    //     },
    //   );
    // }
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<List<Task>>(
            stream: readTasks(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Ошибкааааа ${snapshot.error}');
              } else if (snapshot.hasData) {
                final tasks = snapshot.data!;
                // return ListView(
                //   children: tasks.map(buildTask).toList(),
                // );
                return TasksList(tasksList: tasks);
                //return TaskTile(task:tasks.map(buildTask).toList());
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Widget buildTask(Task task) => ListTile(
        leading: Text(task.title),
        title: Text(task.description),
        subtitle: Text(task.date),
      );

//reads list of tasks
  Stream<List<Task>> readTasks() => FirebaseFirestore.instance
      .collection('users')
      .doc(userEmail)
      .collection('tasks')
      .where('isDeleted', isEqualTo: false)
      .where('isDone', isEqualTo: false)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Task.fromMap(doc.data()))
          .toList()); //конвертирует обратно в Task
}
