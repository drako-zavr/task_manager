import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/blocs/bloc_exports.dart';
import 'package:task_manager/main.dart';

import '../models/task.dart';
import '../widgets/tasks_list.dart';
import 'my_drawer.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});
  static const id = 'recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Корзина'),
              actions: [
                PopupMenuButton(
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              child: TextButton.icon(
                                onPressed: null,
                                icon: const Icon(Icons.delete_forever),
                                label: const Text('Очистить корзину'),
                              ),
                              onTap: () => context
                                  .read<TasksBloc>()
                                  .add(DeleteAllTasks())),
                        ])
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.add),
                // )
              ],
            ),
            drawer: MyDrawer(),
            body: StreamBuilder<List<Task>>(
                stream: readTasks(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Ошибкааааа ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final tasks = snapshot.data!;
                    // return ListView(
                    //   children: tasks.map(buildTask).toList(),
                    // );
                    return Column(
                      children: [
                        TasksList(tasksList: tasks),
                      ],
                    );
                    //return TaskTile(task:tasks.map(buildTask).toList());
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }));
      },
    );
  }
}

// @override
// Widget build(BuildContext context) {
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

//   return ;
// }

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
    .where('isDeleted', isEqualTo: true)
    .snapshots()
    .map((snapshot) => snapshot.docs
        .map((doc) => Task.fromMap(doc.data()))
        .toList()); //конвертирует обратно в Task

