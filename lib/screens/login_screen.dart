import 'package:firebase_auth/firebase_auth.dart';

import 'reset_password_screen.dart';
import 'sign_up_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../helpers/authservice.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

User? googleUser;

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  late String email, password;
  Color orangeColor = AppTheme.orange;
  bool _isSigningIn = false;

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      if (kDebugMode) {
        print("Form Validé");
      }
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
        child: Form(
          key: formKey,
          child: _buildLoginForm(),
        ),
      ),
    );
  }

  _buildLoginForm() {
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
                const Text('Hello',
                    style: TextStyle(fontFamily: 'Trueno', fontSize: 60.0)),
                const Positioned(
                    top: 50.0,
                    child: Text('There',
                        style:
                            TextStyle(fontFamily: 'Trueno', fontSize: 60.0))),
                Positioned(
                  top: 97.0,
                  left: 175.0,
                  child: Container(
                    height: 10.0,
                    width: 10.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppTheme.green),
                  ),
                )
              ],
            ),
          ),
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
              ),
            ),
            onChanged: (value) {
              email = value;
            },
            validator: (value) =>
                value!.isEmpty ? 'Email is required' : validateEmail(value),
          ),
          TextFormField(
              decoration: InputDecoration(
                labelText: 'PASSWORD',
                labelStyle: TextStyle(
                  fontFamily: 'Trueno',
                  fontSize: 12.0,
                  color: Colors.grey.withOpacity(0.5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: orangeColor),
                ),
              ),
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              validator: (value) =>
                  value!.isEmpty ? 'Password is required' : null),
          const SizedBox(height: 5.0),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ResetPasswordScreen(),
                ),
              );
            },
            child: Container(
              alignment: const Alignment(1.0, 0.0),
              padding: const EdgeInsets.only(top: 15.0, left: 20.0),
              child: InkWell(
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: orangeColor,
                      fontFamily: 'Trueno',
                      fontSize: 11.0,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              {
                if (checkFields()) print(email);
                AuthService().signIn(email, password, context);
              }
            },
            child: SizedBox(
              height: 50.0,
              child: Material(
                borderRadius: BorderRadius.circular(25.0),
                shadowColor: AppTheme.orange.withOpacity(0.4),
                color: orangeColor,
                elevation: 7.0,
                child: const Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white, fontFamily: 'Trueno'),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          _isSigningIn
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : SignInButton(
                  Buttons.google,
                  text: "Sign up with Google",
                  onPressed: () async {
                    setState(() {
                      _isSigningIn = true;
                    });

                    googleUser =
                        await AuthService.signInWithGoogle(context: context);

                    if (googleUser != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }

                    setState(() {
                      _isSigningIn = false;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.all(5.0),
                ),
          const SizedBox(height: 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('New to RegisMe ?'),
              const SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: Text(
                  'Register',
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
