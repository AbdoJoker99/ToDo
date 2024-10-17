import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/firbase_utils.dart';
import 'package:todo/home/authentication/regestration/signUp.dart';
import 'package:todo/home/home_screen.dart';

import '../../../dialog_utils.dart';
import '../../../providers/user_provider.dart';
import '../custom_text_form-field.dart';

class Login extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    label: 'Email',
                    controller: _emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please enter your email";
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_^{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    obscureText: false,
                  ),
                  CustomTextFormField(
                    label: 'Password',
                    controller: _passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please enter your password";
                      }
                      if (text.length < 6) {
                        return "Password cannot be less than 6 characters";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                      onPressed: login,
                      child: const Text(
                        'Login',
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Signup.routeName);
                      },
                      child: const Text(
                        'Or Create Account',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    if (_formKey.currentState!.validate()) {
      DialogUtils.showLoading(context, "Loading...");
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        final user = await FirebaseUtils.readUserFromFirestore(
          credential.user?.uid ?? "",
        );
        if (user == null) {
          return;
        }
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        print("Login successful");
        DialogUtils.hideLoading(context);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.showMessage(
            context: context,
            content: 'No user found for that email.',
          );
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          DialogUtils.showMessage(
            context: context,
            content: 'Wrong password provided for that user.',
          );
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
