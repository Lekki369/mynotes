import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
        title: Text('Register'),
      ),
      body: Column(
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

              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email.text, password: password.text);
            },
            child: const Text('Register Now'),
          ),
        ],
      ),
    );
  }
}
