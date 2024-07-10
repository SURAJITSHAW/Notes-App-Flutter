import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class RegisterationPage extends StatefulWidget {
  const RegisterationPage({super.key});

  @override
  State<RegisterationPage> createState() => _RegisterationPageState();
}

class _RegisterationPageState extends State<RegisterationPage> {
  late final _emailController;
  late final _passwordController;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  
  // ! custom firebase init method
  Future<FirebaseApp> _firebaseInit() {
    // ! before using the firebase had to intialize it
    return Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: const Color.fromARGB(255, 167, 137, 250),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: _firebaseInit(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            // Once complete, show the main application
            if (snapshot.connectionState == ConnectionState.done) {
              return RegistrationForm(
                  emailController: _emailController,
                  passwordController: _passwordController);
            }

            // Otherwise, show a loading spinner
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class RegistrationForm extends StatelessWidget {

// ! custom methdo: create firebase user
  void _createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // User successfully created
      print("User created: ${userCredential.user!.email}");
    } on FirebaseAuthException catch (e) {
      // Handle error
      print("$e");
    }
  }


  const RegistrationForm({
    super.key,
    required emailController,
    required passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final _emailController;
  final _passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.emailAddress,
          enableSuggestions: false,
          controller: _emailController,
          decoration: const InputDecoration(
            hintText: "Email",
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        TextField(
          enableSuggestions: false,
          obscureText: true,
          controller: _passwordController,
          decoration: const InputDecoration(
            hintText: "Password",
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        TextButton(
            onPressed: _createUser,
            child: const Text("Register"))
      ],
    );
  }
}
