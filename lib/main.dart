import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/email_verfication.dart';
import 'package:mynotes/notes_view.dart';
import 'package:mynotes/registerview.dart';
import 'dart:developer' as devtools show log;

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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            devtools.log(currentUser.toString());
            //   print(currentUser);

            if (currentUser != null) {
              if (currentUser.emailVerified) {
                devtools.log('Email Verified');

                return const NoteView();
              } else {
                return const EmailVerfy();
              }
            } else {
              return const LoginView();
            }

          default:
            return const Scaffold(
              body: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
