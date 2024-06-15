import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/blocs/bloc_exports.dart';
import 'package:task_manager/screens/login_screen.dart';

import '../widgets/tasks_list.dart';
import 'my_drawer.dart';
// import 'package:task_manager/services/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  static const id = 'settings_screen';
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<TasksBloc, TasksState>(
    //   builder: (context, state) {
    //     return Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Login'),
    //       ),
    //       drawer: const MyDrawer(),
    //       body: Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Center(child: Text('Login')),
    //         ],
    //       ),
    //     );
    //   },
    // );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 0),
            //Смена темы приложения
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return ListTile(
                  leading: state.switchValue
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode),
                  title: const Text('Тема приложения'),
                  trailing: Switch(
                    value: state.switchValue,
                    onChanged: (newValue) {
                      newValue
                          ? context.read<SwitchBloc>().add(SwitchOnEvent())
                          : context.read<SwitchBloc>().add(SwitchOffEvent());
                    },
                  ),
                );
              },
            ),
            //Выйти из аккаунта
            // ElevatedButton.icon(
            //   icon: Icon(Icons.lock_open, size: 24),
            //   label: Text('Sign out'),
            //   onPressed: () => FirebaseAuth.instance.signOut(),
            // ),

            // GestureDetector(
            //   onTap: () {
            //     // Navigator.of(context).pushReplacementNamed(LoginScreen.id),
            //     FirebaseAuth.instance.signOut();
            //     Navigator.of(context).pushReplacementNamed(LoginScreen.id);
            //   },
            //   child: const ListTile(
            //     leading: Icon(Icons.arrow_back),
            //     title: Text('Sign out'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
