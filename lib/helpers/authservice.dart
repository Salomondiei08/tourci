import 'package:firebase_auth/firebase_auth.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';


import '../screens/onboarding_screen.dart';
import 'error_handler.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthService {
  //Determine if the user is authenticated.
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Sign In
  signIn(String email, String password, context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (val) {
        if (kDebugMode) {
          print('signed in');
        }
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
      },
    ).catchError(
      (e) {
        if (kDebugMode) {
          print(e);
        }
        ErrorHandler().errorDialog(context, e);
      },
    );
  }

// Google Sign in
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;

        // await FirebaseChatCore.instance.createUserInFirestore(
        //   types.User(
        //     firstName: user!.displayName,
        //     id: user.uid, // UID from Firebase Authentication
        //     imageUrl: 'https://i.pravatar.cc/300',
        //     lastName: user.email,
        //   ),
        // );
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            ErrorHandler().errorDialog(context, e);
          } else if (e.code == 'invalid-credential') {
            ErrorHandler().errorDialog(context, e);
          }
        } catch (e) {
          ErrorHandler().errorDialog(context, e);
        }
      }
    }

    return user;
  }

  static Future<void> signOutWithGoogle({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ErrorHandler().errorDialog(context, e);
    }
  }

  //Signup a new user
  signUp(String email, String password) {
    print(email);
    print(password);
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (user) {
        print('signed in');
      },
    );
  }

  //Reset Password
  resetPasswordLink(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
