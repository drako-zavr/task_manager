import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screens/completed_tasks_screen.dart';

import '../main.dart';
import '../models/task.dart';
import 'add_task_screen.dart';
import 'favorite_tasks_screen.dart';
import 'my_drawer.dart';
import 'pending_screen.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen({super.key});
  static const id = 'tabs_screen';
  final user = FirebaseAuth.instance.currentUser;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': PendingTasksScreen(), 'title': 'Задачи'},
    {'pageName': CompletedTasksScreen(), 'title': 'Выполненные задачи'},
    {'pageName': FavoriteTasksScreen(), 'title': 'Отмеченные задачи'},
  ];

  var _selectedPageIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 88, 52, 139),
        elevation: 0,
        title: Text(_pageDetails[_selectedPageIndex]['title']),
        actions: [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: MyDrawer(),
      //список
      body: _pageDetails[_selectedPageIndex]['pageName'],
      //
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle_sharp), label: 'Задачи'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Выполненные'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Отмеченные'),
        ],
      ),
    );
  }
}

//reads list of tasks
Stream<List<Task>> readTasks() => FirebaseFirestore.instance
    .collection('users')
    .doc(userEmail)
    .collection('tasks')
    .snapshots()
    .map((snapshot) => snapshot.docs
        .map((doc) => Task.fromMap(doc.data()))
        .toList()); //конвертирует обратно в Task

//reads single task
// Future<Task?> readTask() async {
//   final docTask = FirebaseFirestore.instance
//       .collection('users')
//       .doc(userEmail)
//       .collection('tasks')
//       .doc('my-id');
//   final snapshot = await docTask.get();
//   if (snapshot.exists) {
//     return Task.fromMap(snapshot.data()!);
//   }
// }
