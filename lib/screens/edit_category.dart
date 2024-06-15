import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/blocs/bloc_exports.dart';
import 'package:task_manager/services/guid_gen.dart';

import '../models/category.dart';

///ПЕРЕДЕЛАТЬ
class EditCategoryScreen extends StatelessWidget {
  final MyCategory oldCategory;
  const EditCategoryScreen({
    Key? key,
    required this.oldCategory,
  }) : super(key: key);

  //final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: oldCategory.title);
    // TextEditingController descriptionController =
    //     TextEditingController(text: oldCategory.description);
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(children: [
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
        // TextField(
        //   autofocus: true,
        //   controller: descriptionController,
        //   minLines: 3,
        //   maxLines: 5,
        //   decoration: const InputDecoration(
        //     label: Text('Description'),
        //     border: OutlineInputBorder(),
        //   ),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                var editedCategory = MyCategory(
                    id: oldCategory.id, title: titleController.text, color: '');
                context.read<CategoriesBloc>().add(EditCategory(
                    oldCategory: oldCategory, newCategory: editedCategory));
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ]),
    );
  }
}
