import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/blocs/bloc_exports.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/screens/categories_screen.dart';
import 'package:task_manager/screens/projects_screen.dart';
import 'package:task_manager/screens/recycle_bin.dart';
import 'package:task_manager/screens/settings_screen.dart';
import 'package:task_manager/screens/tabs_screen.dart';
import 'package:task_manager/screens/login_screen.dart';
import 'package:task_manager/screens/pending_screen.dart';

class MyDrawer extends StatelessWidget {
  // const MyDrawer({super.key});
  MyDrawer({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              color: Color.fromARGB(255, 88, 52, 139),
              child: Text(
                // user.email == null
                // ? 'text'
                // : user.email,
                userEmail,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),

            //Все задачи
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).pushReplacementNamed(
                    TabsScreen.id,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.folder_special),
                    title: const Text('Мои задачи'),
                    // trailing: Text(
                    //    '${state.pendingTasks.length} | ${state.completedTasks.length}'),
                  ),
                );
              },
            ),
            //Категории
            // GestureDetector(
            //   onTap: () => Navigator.of(context).pushReplacementNamed(
            //     CategoriesScreen.id,
            //   ),
            //   child: ListTile(
            //     leading: const Icon(Icons.category_outlined),
            //     title: const Text('Категории'),
            //   ),
            // ),
            // //Проекты
            // GestureDetector(
            //   onTap: () => Navigator.of(context).pushReplacementNamed(
            //     ProjectsScreen.id,
            //   ),
            //   child: ListTile(
            //     leading: const Icon(Icons.stacked_bar_chart),
            //     title: const Text('Проекты'),
            //   ),
            // ),
            const Divider(),
            //Мусорка
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).pushReplacementNamed(
                    RecycleBin.id,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Мусорка'),
                    //trailing: Text('${state.removedTasks.length}'),
                  ),
                );
              },
            ),
            //Изменение темы приложения
            // BlocBuilder<SwitchBloc, SwitchState>(
            //   builder: (context, state) {
            //     return ListTile(
            //       leading: state.switchValue
            //           ? const Icon(Icons.dark_mode)
            //           : const Icon(Icons.light_mode),
            //       title: const Text('App theme'),
            //       trailing: Switch(
            //         value: state.switchValue,
            //         onChanged: (newValue) {
            //           newValue
            //               ? context.read<SwitchBloc>().add(SwitchOnEvent())
            //               : context.read<SwitchBloc>().add(SwitchOffEvent());
            //         },
            //       ),
            //     );
            //   },
            // ),
            //Настройки
            GestureDetector(
              onTap: () => Navigator.of(context).pushReplacementNamed(
                SettingsScreen.id,
              ),
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Настройки'),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: BlocBuilder<TasksBloc, TasksState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () =>
                        // Navigator.of(context).pushReplacementNamed(LoginScreen.id),
                        FirebaseAuth.instance.signOut(),
                    child: ListTile(
                      leading: const Icon(Icons.arrow_back),
                      title: const Text('Выйти из аккаунта'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
