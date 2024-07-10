import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email", style: TextStyle(
          color: Colors.white
        )),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Please Verify Your Email",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              if (_user != null)
                Column(
                  children: [
                    Text(
                      "Email: ${_user!.email}",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      _user!.emailVerified
                          ? "Status: Verified"
                          : "Status: Not Verified",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: _user!.emailVerified ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  await _user?.sendEmailVerification();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Verification email sent!"),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text(
                  'Send Verification Email',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
