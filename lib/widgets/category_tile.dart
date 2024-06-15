import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/screens/edit_task_screen.dart';
import 'package:task_manager/widgets/popup_menu.dart';

import '../blocs/bloc_exports.dart';
import '../models/category.dart';
// import '../models/task.dart';
import '../screens/edit_category.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.category,
  });

  final MyCategory category;

  // void _removeOrDeleteTask(BuildContext ctx, Category category) {
  //   category.isDeleted! //! значит, что мы точно знаем,что значение никокда не null
  //       ? ctx.read<TasksBloc>().add(DeleteTask(task: category))
  //       : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  // }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: EditCategoryScreen(oldCategory: category),
              ),
            ));
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.title,
                        overflow: TextOverflow
                            .ellipsis, //отображет только одну строчку если title слишком длинный
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //ПЕРЕДЕЛАТЬ
          // Row(
          //   children: [

          //     PopupMenu(
          //       task: category,
          //       cancelOrDeleteCallback: () =>
          //           _removeOrDeleteTask(context, task),
          //       likeOrDislikeCallback: () => context.read<TasksBloc>().add(
          //             MarkFavoriteOrUnfavoriteTask(task: task),
          //           ),
          //       editTaskCallback: () {
          //         Navigator.of(context).pop();
          //         _editTask(context);
          //       },
          //       restoreTaskCallback: () =>
          //           context.read<TasksBloc>().add(RestoreTask(task: task)),
          //     )
          //   ],
          // ),
        ],
      ),
    );
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