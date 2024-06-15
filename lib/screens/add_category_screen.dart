import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/blocs/bloc_exports.dart';
import 'package:task_manager/models/category.dart';
import 'package:task_manager/services/guid_gen.dart';

import '../models/task.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  //final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController colorController = TextEditingController();
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(children: [
        const Text(
          'Add Category',
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
          controller: colorController,
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
                createCategory(
                  color: colorController.text,
                  title: titleController.text,
                );
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ]),
    );
  }
}

//reads list of tasks
Stream<List<Task>> readCategories() => FirebaseFirestore.instance
    .collection('users')
    .doc('user1')
    .collection('categories')
    .snapshots()
    .map((snapshot) => snapshot.docs
        .map((doc) => Task.fromMap(doc.data()))
        .toList()); //конвертирует обратно в Task

//reads single task
Future<Task?> readCategory() async {
  final docTask = FirebaseFirestore.instance
      .collection('users')
      .doc('user1')
      .collection('categories')
      .doc('my-id');
  final snapshot = await docTask.get();
  if (snapshot.exists) {
    return Task.fromMap(snapshot.data()!);
  }
}

//saves task
Future createCategory({required String title, required String color}) async {
  final docCategory = FirebaseFirestore.instance
      .collection('users')
      .doc('user1')
      .collection('categories')
      .doc(); //.doc() генерирует id автоматически если пустой

  // final json = {
  //   'title': 'title',
  //   // 'description': 'test',
  //   // 'date': 'date',
  // };
  final category = MyCategory(title: title, id: docCategory.id, color: '');
  //создать документ и занести данные в Firebase
  final json = category.toMap();

  await docCategory.set(json);
}

//копия класса для понимания, что здесь происходит

