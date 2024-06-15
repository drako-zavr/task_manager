import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/blocs/bloc_exports.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/services/guid_gen.dart';

import '../models/task.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  //final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(children: [
        const Text(
          'Добавить задачу',
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
              label: Text('Заголовок'),
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
            label: Text('Описание'),
            border: OutlineInputBorder(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            //Добавление задачи
            ElevatedButton(
              onPressed: () {
                // var task = Task(
                //     id: GUIDGen.generate(),
                //     description: descriptionController.text,
                //     title: titleController.text,
                //     date: DateTime.now().toString());
                // context.read<TasksBloc>().add(AddTask(task: task));
                Navigator.pop(context);
                createTask(
                    date: DateTime.now().toString(),
                    title: titleController.text,
                    description: descriptionController.text);
              },
              child: const Text('Добавить'),
            ),
          ],
        ),
      ]),
    );
  }
}

//reads list of tasks
Stream<List<Task>> readTasks() => FirebaseFirestore.instance
    .collection('users')
    .doc('user1')
    .collection('tasks')
    .snapshots()
    .map((snapshot) => snapshot.docs
        .map((doc) => Task.fromMap(doc.data()))
        .toList()); //конвертирует обратно в Task

//reads single task
Future<Task?> readTask() async {
  final docTask = FirebaseFirestore.instance
      .collection('users')
      .doc('user1')
      .collection('tasks')
      .doc('my-id');
  final snapshot = await docTask.get();
  if (snapshot.exists) {
    return Task.fromMap(snapshot.data()!);
  }
}

//saves task
Future createTask(
    {required String title,
    required String description,
    required String date}) async {
  String newid = GUIDGen.generate();
  final docTask = FirebaseFirestore.instance
      .collection('users')
      .doc(userEmail)
      .collection('tasks')
      .doc(newid); //.doc() генерирует id автоматически если пустой

  // final json = {
  //   'title': 'title',
  //   // 'description': 'test',
  //   // 'date': 'date',
  // };
  final task = Task(
    title: title,
    description: description,
    myid: newid,
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

//копия класса для понимания, что здесь происходит

// class Task extends Equatable {
//   final String title;
//   final String description;
//   final String id;
//   final String date;
//   bool? isDone;
//   bool? isDeleted;
//   bool? isFavorite;

//   Task({
//     required this.title,
//     required this.description,
//     required this.id,
//     required this.date,
//     this.isDone,
//     this.isDeleted,
//     this.isFavorite,
//    })

//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'description': description,
//       'id': id,
//       'date': date,
//       'isDone': isDone,
//       'isDeleted': isDeleted,
//       'isFavorite': isFavorite,
//     };
//   }