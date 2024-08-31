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
  _loginState createState() => _loginState();
}

class _loginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login"),
        centerTitle: true,
      ), // AppBar
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    label: 'email',
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please enter  your email";
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_^{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return " please enter valid email";
                      }
                      return null;
                    },
                    obscureText: false,
                  ),
                  CustomTextFormField(
                    // CustomTextFormField
                    label: 'password',
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please enter  your password";
                      }
                      if (text.length < 6) {
                        return " password  can not be less than 6 characters";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                        onPressed: () {
                          login();
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: AppColors.whiteColor),
                        ),
                      ),
                    ), // Elevated
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Signup.routeName);
                      },
                      child: Text(
                        'Or Create Account',
                        style: TextStyle(fontSize: 20),
                      ), // Text, TextButton
                    ),
                  ), // Padding
                ],
              ),
            ),
          ],
        ),
      ), // Column
    ); // Scaffold
  }

  void login() async {
    if (_formKey.currentState!.validate()) {
      DialogUtils.showLoading(context, "loading...");
      //TODO: Add your logic here
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFirestore(
            credential.user?.uid ?? "");
        if (user == null) {
          return;
        }
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        print("login  successfully");
        DialogUtils.hideLoading(context);
        //   DialogUtils.showMessage(
        // context: context, content: 'login Successfully!');
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.showMessage(
              context: context, content: 'No user found for that email.');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          DialogUtils.showMessage(
              context: context,
              content: 'Wrong password provided for that user.');
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
