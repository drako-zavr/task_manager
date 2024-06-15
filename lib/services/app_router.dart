// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/screens/auth_screen.dart';

import 'package:task_manager/screens/categories_screen.dart';
import 'package:task_manager/screens/recycle_bin.dart';
// import 'package:task_manager/screens/pending_screen.dart';
import 'package:task_manager/screens/settings_screen.dart';
import 'package:task_manager/widgets/task_tile.dart';
import '../screens/edit_task_screen.dart';
import '../screens/login_screen.dart';
import '../screens/projects_screen.dart';
import '../screens/tabs_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AuthScreen.id:
        return MaterialPageRoute(
          builder: (_) => AuthScreen(),
          // builder: StreamBuilder<User?>(
          //   stream:FirebaseAuth.instance.authStateChanges(),
          //   builder: (context,snapshot){
          //     return LoginScreen();
          //   },)
        );

      case TabsScreen.id:
        return MaterialPageRoute(
          builder: (_) => TabsScreen(),
        );
      // case EditTaskScreen.id:
      // return MaterialPageRoute(
      //   builder: (_) => EditTaskScreen(),
      // );

      case CategoriesScreen.id:
        return MaterialPageRoute(
          builder: (_) => CategoriesScreen(),
        );

      case ProjectsScreen.id:
        return MaterialPageRoute(
          builder: (_) => ProjectsScreen(),
        );

      case RecycleBin.id:
        return MaterialPageRoute(
          builder: (_) => const RecycleBin(),
        );

      case SettingsScreen.id:
        return MaterialPageRoute(
          builder: (_) => SettingsScreen(),
        );

      default:
        return null;
    }
  }
}
