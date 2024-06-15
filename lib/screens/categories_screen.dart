import 'package:flutter/material.dart';
import 'package:task_manager/blocs/bloc_exports.dart';
import 'package:task_manager/models/category.dart';

import '../widgets/categories_list.dart';
import 'add_category_screen.dart';
import 'my_drawer.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  static const id = 'categories_screen';

  void _addCategory(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddCategoryScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        List<MyCategory> categoriesList = state.allCategories;
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addCategory(context),
            // => _addCategory(context),
            tooltip: 'Add Category',
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: const Text('Categories'),
            // actions: [
            //   PopupMenuButton(
            //       itemBuilder: (context) => [
            //             PopupMenuItem(
            //               child: TextButton.icon(
            //                 onPressed: null,
            //                 icon: const Icon(Icons.delete_forever),
            //                 label: const Text('Delete all tasks'),
            //               ),
            //               onTap: () {},
            //             ),
            //           ])
            //   // IconButton(
            //   //   onPressed: () {},
            //   //   icon: const Icon(Icons.add),
            //   // )
            // ],
          ),
          drawer: MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [CategoriesList(categoriesList: state.allCategories)],
            // children: [CategoriesList(categoriesList: categoriesList)],
          ),
        );
      },
    );
  }
}
