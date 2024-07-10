import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser?.emailVerified);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home", style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(child: Text("Hello, verified user!!")),
    );
  }
}