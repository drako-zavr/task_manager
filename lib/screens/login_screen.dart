import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/blocs/bloc_exports.dart';

import '../main.dart';
import '../widgets/tasks_list.dart';
import 'my_drawer.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginScreen({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  static const id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
    //           Center(child: Text('Login you scum')),
    //         ],
    //       ),
    //     );
    //   },
    // );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход'),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            TextField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 4),
            TextField(
              cursorColor: Colors.white,
              controller: passwordController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.lock_open, size: 24),
              label: Text('Войти'),
              onPressed: signIn,
            ),
            SizedBox(height: 24),
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    text: 'Нет аккаунта? ',
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: 'Зарегистрироваться',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary))
                ]))
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false, //не закрывается
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      userEmail = emailController.text.trim();
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
