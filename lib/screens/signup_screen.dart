import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/blocs/bloc_exports.dart';

import '../main.dart';
import '../utils/utils.dart';
import '../widgets/tasks_list.dart';
import 'my_drawer.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const SignUpScreen({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  static const id = 'login_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
      ),
      //drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Email'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Введите действительный email'
                        : null,
              ),
              SizedBox(height: 4),
              TextFormField(
                cursorColor: Colors.white,
                controller: passwordController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Пароль'),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Минимум 6 символов'
                    : null,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.arrow_forward, size: 24),
                label: Text('Зарегистрироваться'),
                onPressed: signUp,
              ),
              SizedBox(height: 24),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      text: 'Уже есть аккаунт?',
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        text: 'Войти',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).colorScheme.secondary))
                  ]))
            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false, //не закрывается
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      userEmail = emailController.text.trim();
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
