import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/widgets/task_tile.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.tasksList,
  }) : super(key: key);

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        //padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
        child: ExpansionPanelList.radio(
          children: tasksList
              .map((task) => ExpansionPanelRadio(
                  value: task.myid,
                  headerBuilder: (context, isOpen) => TaskTile(task: task),
                  body: ListTile(
                    title: SelectableText.rich(TextSpan(children: [
                      const TextSpan(
                        text: 'Заголовок\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: task.title),
                      const TextSpan(
                        text: '\n\nОписание\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: task.description),
                    ])),
                  )))
              .toList(),
        ),
      ),
    );
  }
}
// return Expanded(
//       child: ListView.builder(
//           itemCount: tasksList.length,
//           itemBuilder: (context, index) {
//             var task = tasksList[index];
//             return TaskTile(task: task);
//           }),
//     );


