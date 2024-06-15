import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/screens/edit_task_screen.dart';
import 'package:task_manager/widgets/popup_menu.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../screens/tabs_screen.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted! //! значит, что мы точно знаем,что значение никокда не null
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  void _editTask(BuildContext context, Task task) {
    print('_editTask вызвался');
    // EditTaskScreen(
    //   oldTask: task,
    // );
    // AlertDialog(
    //   backgroundColor: Colors.amber,
    //   content: Container(height: 120),
    // );

    // showModalBottomSheet(
    //     context: context,
    //     builder: (context) {
    //       print('hwllo');
    //       return Container(
    //         height: 100,
    //         padding: EdgeInsets.only(
    //             bottom: MediaQuery.of(context).viewInsets.bottom),
    //         child: EditTaskScreen(
    //           oldTask: task,
    //           //docTask: docTask,
    //         ),
    //       );
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavorite == false
                    // ? const Icon(Icons.star_outline)
                    ? const SizedBox(
                        width: 10,
                      )
                    : const Icon(Icons.star),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow
                            .ellipsis, //отображет только одну строчку если title слишком длинный
                        style: TextStyle(
                          fontSize: 18,
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      // Text(
                      //   // DateFormat().add_yMMMd().add_Hms().format(
                      //   //     DateTime.parse(task
                      //   //         .date)), //формат даты с использованием библиотеки intl
                      //   DateFormat('dd-MM-yyyy hh:mm').format(DateTime.parse(
                      //       task.date)), //можно задавать формат даты текстом
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          FutureBuilder<Task?>(
              future: readTask(taskid: task.myid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('data');
                } else if (snapshot.hasData) {
                  final task = snapshot.data;

                  if (task == null) {
                    return Center(
                      child: Text('no tasks?'),
                    );
                  } else {
                    final docTask = FirebaseFirestore.instance
                        .collection('users')
                        .doc(userEmail)
                        .collection('tasks')
                        .doc(task.myid);
                    return Row(
                      children: [
                        Checkbox(
                          value: task.isDone,
                          onChanged: task.isDeleted == false
                              ? (value) {
                                  // context
                                  //     .read<TasksBloc>()
                                  //     .add(UpdateTask(task: task));
                                  if (task.isDone == false) {
                                    docTask.update({
                                      'isDone': true,
                                    });
                                  } else {
                                    docTask.update({
                                      'isDone': false,
                                    });
                                  }
                                }
                              : null,
                        ),
                        PopupMenu(
                          task: task,
                          cancelOrDeleteCallback: ()
                              //=>
                              //     _removeOrDeleteTask(context, task),

                              {
                            if (task.isDeleted == false) {
                              docTask.update({
                                'isDeleted': true,
                              });
                            } else {
                              docTask.delete();
                            }
                          },
                          likeOrDislikeCallback: ()
                              // =>
                              //     context.read<TasksBloc>().add(
                              //           MarkFavoriteOrUnfavoriteTask(task: task),
                              //         ),
                              {
                            if (task.isFavorite == false) {
                              docTask.update({
                                'isFavorite': true,
                              });
                            } else {
                              docTask.update({
                                'isFavorite': false,
                              });
                            }
                            Navigator.of(context).pop();
                          },
                          editTaskCallback: () {
                            print(FirebaseFirestore.instance
                                .collection('users')
                                .doc(userEmail)
                                .collection('tasks')
                                .doc(task.myid));
                            print(task.myid);
                            Navigator.of(context).pop();
                            // Navigator.of(context)
                            //     .pushReplacementNamed(EditTaskScreen.id);

                            print('edit task is called?');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    EditTaskScreen(oldTask: task)));
                            _editTask(context, task);
                            //return EditTaskScreen(oldTask: task);
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => EditTaskScreen(
                            //           oldTask: task,
                            //         )));
                            // showModalBottomSheet(
                            //     isScrollControlled: true,
                            //     context: context,
                            //     builder: (context) => SingleChildScrollView(
                            //           child: Container(
                            //             padding: EdgeInsets.only(
                            //                 bottom: MediaQuery.of(context)
                            //                     .viewInsets
                            //                     .bottom),
                            //             child: EditTaskScreen(
                            //               oldTask: task,
                            //               //docTask: docTask,
                            //             ),
                            //           ),
                            //         ));
                          },
                          restoreTaskCallback: ()
                              //  => context
                              //     .read<TasksBloc>()
                              //     .add(RestoreTask(task: task)),
                              {
                            docTask.update({
                              'isDeleted': false,
                            });
                          },
                        )
                      ],
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })

          //
        ], //outer row
      ),
    );
  }
}

Widget buildTask(Task task) => ListTile(
      leading: Text(task.title),
      title: Text(task.description),
      subtitle: Text(task.date),
    );

//reads single task
Future<Task?> readTask({required String taskid}) async {
  final docTask = FirebaseFirestore.instance
      .collection('users')
      .doc(userEmail)
      .collection('tasks')
      .doc(taskid);
  final snapshot = await docTask.get();
  if (snapshot.exists) {
    return Task.fromMap(snapshot.data()!);
  }
}

// ListTile(
//       title: Text(
//         task.title,
//         overflow: TextOverflow
//             .ellipsis, //отображет только одну строчку если title слишком длинный
//         style: TextStyle(
//           decoration: task.isDone! ? TextDecoration.lineThrough : null,
//         ),
//       ),
//       trailing: Checkbox(
//         value: task.isDone,
//         onChanged: task.isDeleted == false
//             ? (value) {
//                 context.read<TasksBloc>().add(UpdateTask(task: task));
//               }
//             : null,
//       ),
//       onLongPress: () => _removeOrDeleteTask(context, task),
//     );