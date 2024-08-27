import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/app_colors.dart';

import '../../../dialog_utils.dart';
import '../custom_text_form-field.dart';

class Signup extends StatefulWidget {
  static const String routeName = 'register_screen';

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
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
                    label: 'User Name',
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please enter  your name";
                      }
                      return null;
                    },
                    obscureText: false,
                  ), // CustomTextFormField
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
                  CustomTextFormField(
                    // CustomTextFormField
                    label: 'confirm password',
                    controller: confirmpasswordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please enter  confirm password";
                      }
                      if (text.length < 6) {
                        return " password  can not be less than 6 characters";
                      }
                      if (text != passwordController.text) {
                        return "confirm password does not matches try again!";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                      onPressed: () {
                        regester();
                        //TODO: Add your logic here
                      },
                      child: Text(
                        'Create Account',
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                    ), // Elevated
                  )
                ],
              ),
            ),
          ],
        ),
      ), // Column
    ); // Scaffold
  }

  void regester() async {
    if (_formKey.currentState!.validate()) {
      DialogUtils.showLoading(context, "loading...");
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        DialogUtils.showMessage(
            context: context, content: 'Register Successfully!');
        print("Register  successfully");
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
