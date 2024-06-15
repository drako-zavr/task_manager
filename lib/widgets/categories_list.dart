import 'package:flutter/material.dart';
import 'package:task_manager/models/category.dart';
import 'package:task_manager/widgets/category_tile.dart';
import '../blocs/bloc_exports.dart';
// import '../models/category.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    Key? key,
    required this.categoriesList,
  }) : super(key: key);

  final List<MyCategory> categoriesList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          //padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
          child: ExpansionPanelList.radio(
            children: categoriesList
                .map((category) => ExpansionPanelRadio(
                    value: category.id,
                    headerBuilder: (context, isOpen) =>
                        CategoryTile(category: category),
                    body: ListTile(
                      title: SelectableText.rich(TextSpan(children: [
                        const TextSpan(
                          text: 'Text\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // TextSpan(text: task.title),
                        // const TextSpan(
                        //   text: '\n\nDescription\n',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // TextSpan(text: task.description),
                      ])),
                    )))
                .toList(),
          ),
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