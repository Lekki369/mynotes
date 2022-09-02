import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerfy extends StatelessWidget {
  const EmailVerfy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Please Very Your Email'),
        TextButton(
          onPressed: () async {
            final currentUser = (FirebaseAuth.instance.currentUser);
            await currentUser?.sendEmailVerification();
          },
          child: const Text('Send Email Verification'),
        ),
      ],
    );
  }
}
