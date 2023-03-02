import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _mobileNoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;

  void registerUser(String mobileNo, String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      user!.updateProfile(displayName: mobileNo);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _mobileNoController,
              decoration: const InputDecoration(
                hintText: 'Mobile Number',
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('Register'),
              onPressed: () {
                registerUser(_mobileNoController.text, _emailController.text,
                    _passwordController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class nextRegisterationPage extends StatefulWidget {
  nextRegisterationPage({Key? key}) : super(key: key);

  @override
  State<nextRegisterationPage> createState() => _nextRegisterationPageState();
}

class _nextRegisterationPageState extends State<nextRegisterationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Next Page"),
      ),
      body: const Center(
        child: Text("Next Page"),
      ),
    );
  }
}
