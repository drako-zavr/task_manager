import 'package:flutter/material.dart';

import '../models/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislikeCallback;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;

  const PopupMenu({
    super.key,
    required this.task,
    required this.cancelOrDeleteCallback,
    required this.likeOrDislikeCallback,
    required this.editTaskCallback,
    required this.restoreTaskCallback,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false
          ? ((context) => [
                //РЕДАКТИРОВАТЬ
                PopupMenuItem(
                  onTap: editTaskCallback,
                  child: TextButton.icon(
                    onPressed: editTaskCallback,
                    icon: const Icon(Icons.edit),
                    label: const Text('Редактировать'),
                  ),
                ),
                //В ИЗБРАННОЕ
                PopupMenuItem(
                  onTap: null,
                  child: TextButton.icon(
                    onPressed: likeOrDislikeCallback,
                    icon: task.isFavorite == false
                        ? const Icon(Icons.bookmark_add_outlined)
                        : const Icon(Icons.bookmark_remove),
                    label: task.isFavorite == false
                        // ? const Text('Add to \nBookmarks')
                        // : const Text('Remove from \nBookmarks'),
                        ? const Text('Отметить')
                        : const Text('Убрать из \nотмеченных'),
                  ),
                ),
                //УДАЛИТЬ
                PopupMenuItem(
                  onTap: cancelOrDeleteCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete),
                    label: const Text('Удалить'),
                  ),
                ),
              ])
          : (context) => [
                PopupMenuItem(
                  onTap: restoreTaskCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.restore_from_trash),
                    label: const Text('Восстановить'),
                  ),
                ),
                PopupMenuItem(
                  onTap: cancelOrDeleteCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Удалить навсегда'),
                  ),
                ),
              ],
    );
  }
}
