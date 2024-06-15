import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/blocs/bloc_exports.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/services/guid_gen.dart';

import '../models/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;
  static const id = 'edit_task_screen';
  //final docTask;
  const EditTaskScreen({
    Key? key,
    required this.oldTask,

    //required this.docTask,
  }) : super(key: key);

  //final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: oldTask.title);
    TextEditingController descriptionController =
        TextEditingController(text: oldTask.description);

    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20),
          child: FutureBuilder<Task?>(
            future: readTask(oldTask.myid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final task = snapshot.data;
                if (task == null) {
                  return Center(
                    child: Text('notask'),
                  );
                } else {
                  return
                      //==============
                      Column(children: [
                    const Text(
                      'Edit Task',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextField(
                        autofocus: true,
                        controller: titleController,
                        decoration: const InputDecoration(
                          label: Text('Title'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    TextField(
                      autofocus: true,
                      controller: descriptionController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        label: Text('Description'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            var editedTask = Task(
                                myid: task.myid,
                                category: task.category,
                                isFavorite: task.isFavorite,
                                isDone: false,
                                description: descriptionController.text,
                                title: titleController.text,
                                date: DateTime.now().toString());
                            // context.read<TasksBloc>().add(EditTask(
                            //     oldTask: oldTask, newTask: editedTask));
                            editTask(
                                date: DateTime.now().toString(),
                                taskid: task.myid,
                                title: titleController.text,
                                description: descriptionController.text);

                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ]);
                }
                //================
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }
}

//reads single task
Future<Task?> readTask(taskid) async {
  print('  Edit task ищет задачи');
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

Future editTask(
    {required String title,
    required String description,
    required String date,
    required String taskid}) async {
  String newid = GUIDGen.generate();
  final docTask = FirebaseFirestore.instance
      .collection('users')
      .doc(userEmail)
      .collection('tasks')
      .doc(taskid); //.doc() генерирует id автоматически если пустой

  // final json = {
  //   'title': 'title',
  //   // 'description': 'test',
  //   // 'date': 'date',
  // };
  final task = Task(
    title: title,
    description: description,
    myid: taskid,
    date: date,
    isDone: false,
    isDeleted: false,
    isFavorite: false,
    category: '',
  );
  //создать документ и занести данные в Firebase
  final json = task.toMap();

  await docTask.set(json);
}
// class EditTaskScreen extends StatelessWidget {

//   final docTask;
//   const EditTaskScreen({
//     Key? key,
//     required this.docTask,
//   }) : super(key: key);

//   //final TextEditingController titleController;

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController titleController =
//         TextEditingController(text: docTask.title);

//     TextEditingController descriptionController =
//         TextEditingController(text: docTask.description);
//     return Container(
//       padding: EdgeInsets.all(20),
//       child: Column(children: [
//         const Text(
//           'Edit Task',
//           style: TextStyle(fontSize: 24),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 10, bottom: 10),
//           child: TextField(
//             autofocus: true,
//             controller: titleController,
//             decoration: const InputDecoration(
//               label: Text('Title'),
//               border: OutlineInputBorder(),
//             ),
//           ),
//         ),
//         TextField(
//           autofocus: true,
//           controller: descriptionController,
//           minLines: 3,
//           maxLines: 5,
//           decoration: const InputDecoration(
//             label: Text('Description'),
//             border: OutlineInputBorder(),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // var editedTask = Task(
//                 //     myid: docTask.myid,
//                 //     category: docTask.category,
//                 //     isFavorite: docTask.isFavorite,
//                 //     isDone: false,
//                 //     description: descriptionController.text,
//                 //     title: titleController.text,
//                 //     date: DateTime.now().toString());
//                 var editedTask = Task(
//                   title: titleController.text,
//                   description: descriptionController.text,
//                   myid: docTask.myid,
//                   date: DateTime.now().toString(),
//                   isDone: false,
//                   isDeleted: false,
//                   isFavorite: false,
//                   category: '',
//                 );
//                 // context
//                 //     .read<TasksBloc>()
//                 //     .add(EditTask(oldTask: docTask, newTask: editedTask));

//                 Navigator.pop(context);
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         ),
//       ]),
//     );
//   }
// }

// //reads single task
// Future<Task?> readTask(taskid) async {
//   final docTask = FirebaseFirestore.instance
//       .collection('users')
//       .doc('user1')
//       .collection('tasks')
//       .doc(taskid);
//   final snapshot = await docTask.get();
//   if (snapshot.exists) {
//     return Task.fromMap(snapshot.data()!);
//   }
// }
