import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _passcode;
  @override
  void initState() {
    _email = TextEditingController();
    _passcode = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email;
    _passcode;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Email-Address'),
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              controller: _passcode,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            TextButton(
              onPressed: () async {
                final password = _passcode;
                final email = _email;

                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text, password: password.text);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'network-request-failed') {
                    print('Check Ur Network Access');
                  }
                }
                // catch (e) {
                //   print(e.runtimeType);
                // }
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/register/', (route) => false);
              },
              child: const Text('Not Registered yet? Register here!'),
            ),
          ],
        ),
      ),
    );
  }
}
