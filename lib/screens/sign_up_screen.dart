import 'package:flutter/material.dart';

import '../helpers/authservice.dart';
import '../helpers/error_handler.dart';
import '../theme/app_theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  late String email, password;

  Color orangeColor = AppTheme.orange;


  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String? validateEmail(String value) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildSignupForm())));
  }

  _buildSignupForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView(
        children: [
          const SizedBox(height: 75.0),
          SizedBox(
              height: 125.0,
              width: 200.0,
              child: Stack(
                children: [
                  const Text('Signup',
                      style: TextStyle(fontFamily: 'Trueno', fontSize: 60.0)),
                  //Dot placement
                  Positioned(
                      top: 62.0,
                      left: 200.0,
                      child: Container(
                          height: 10.0,
                          width: 10.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: orangeColor)))
                ],
              )),
          const SizedBox(height: 25.0),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: orangeColor),
                  )),
              onChanged: (value) {
                email = value;
              },
              validator: (value) =>
                  value!.isEmpty ? 'Email is required' : validateEmail(value)),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: orangeColor),
                  )),
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              validator: (value) =>
                  value!.isEmpty ? 'Password is required' : null),
          const SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              if (checkFields()) {
                AuthService().signUp(email, password).then((userCreds) {
                  Navigator.of(context).pop();
                }).catchError((e) {
                  ErrorHandler().errorDialog(context, e);
                });
              }
            },
            child: SizedBox(
              height: 50.0,
              child: Material(
                borderRadius: BorderRadius.circular(25.0),
                shadowColor: AppTheme.orange,
                color: orangeColor,
                elevation: 7.0,
                child: const Center(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(color: Colors.white, fontFamily: 'Trueno'),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Go back',
                  style: TextStyle(
                      color: orangeColor,
                      fontFamily: 'Trueno',
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
