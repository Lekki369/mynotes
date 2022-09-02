import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/email_verfication.dart';
import 'package:mynotes/registerview.dart';

import 'package:mynotes/views/loginview.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const Register(),
      },
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final currentUser = (FirebaseAuth.instance.currentUser);
            print(currentUser);

            if (currentUser != null) {
              if (currentUser.emailVerified) {
                print('Email Verified');
              } else {
                return const EmailVerfy();
              }
            } else {
              return const LoginView();
            }
            return const Text('Done');
          default:
            return const Scaffold(
              body: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
