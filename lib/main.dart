import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:task_manager/models/category.dart';
import 'package:task_manager/screens/auth_screen.dart';
// import 'package:task_manager/screens/login_screen.dart';
import 'package:task_manager/services/app_router.dart';
import 'package:task_manager/services/app_theme.dart';
// import 'package:task_manager/utils/utils.dart';
import 'screens/tabs_screen.dart';
// import 'screens/pending_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'blocs/bloc_exports.dart';

Future main() async {
  //Hydrated bloc v 8 (устаревший)

  // WidgetsFlutterBinding.ensureInitialized();

  // final storage = await HydratedStorage.build(
  //   storageDirectory: await getApplicationDocumentsDirectory(),
  // );

  // HydratedBlocOverrides.runZoned(
  //   () => runApp(const MainApp()),
  //   storage: storage,
  // );

  //Hydrated bloc v 9
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //?
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(MainApp(
    appRouter: AppRouter(),
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();
String userEmail = 'test@gmail.com';

class MainApp extends StatelessWidget {
  // const MainApp({super.key});
  const MainApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
        BlocProvider(create: (context) => CategoriesBloc()), //
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            //scaffoldMessengerKey: Utils.messengerKey,
            navigatorKey: navigatorKey,
            title: 'Flutter Tasks App',
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Что-то пошло не так'));
                } else if (snapshot.hasData) {
                  return TabsScreen();
                } else {
                  return AuthScreen();
                }
              },
            ),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
