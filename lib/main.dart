import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/registerview.dart';
import 'package:mynotes/views/loginView.dart';

import 'firebase_options.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final currentUser = (FirebaseAuth.instance.currentUser);

              if (currentUser?.emailVerified ?? false) {
                print('You\'re Verified');
              } else {
                print('You\'re not Verified');
              }
              return const Text('Done Loading');

            default:
              return const Text(' Unknown Loading');
          }
        },
      ),
    );
  }
}
