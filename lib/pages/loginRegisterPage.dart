import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterauthentication/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;
  late GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerMobileNo = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
        mobileno: _controllerMobileNo.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Center(
      child: Text("Flutter App"),
    );
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text('$errorMessage');
    // return Text(errorMessage == '' ? '' : 'Oops ? $errorMessage');
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: signInWithEmailAndPassword,
      child: Text('Login'),
    );
  }

  Widget _registerButton() {
    return ElevatedButton(
      onPressed: createUserWithEmailAndPassword,
      child: const Text('Register'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
          errorMessage;
        });
      },
      child: GestureDetector(
        child: Text(''),
        // onTap: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => RegisterPage()),
        //   );
        // },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1, //optional, starts from 0, select the tab by default
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Authentication"),
          backgroundColor: Colors.lightGreen,
          bottom: const TabBar(tabs: [
            Tab(
              text: "Login",
            ),
            Tab(
              text: "Register",
            ),
            // Tab(
            //   text: "Contact Us",
            // )
          ]),
        ),
        body: TabBarView(
          children: [
            loginSection(), // First Screen
            signupSection(), // Second Screen
          ],
        ),
      ),
    );
  }

  Widget loginSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Say Hello to our new App",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            _entryField('Email', _controllerEmail),
            _entryField('Password', _controllerPassword),
            const SizedBox(
              height: 90,
            ),
            _errorMessage(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _loginButton(),
                const SizedBox(
                  width: 10,
                ),
                // _registerButton(),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _googleSignIn.signIn().then((userData) {
                  _userObj = userData!;
                }).catchError((e) {
                  isLogin = false;
                  _userObj = _googleSignIn.currentUser!;
                  print(e);
                });
              },
              child: const Text("Login With Google"),
            ),
            _loginOrRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget signupSection() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Say Hello to our new App",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            _entryField('Email', _controllerEmail),
            const SizedBox(
              height: 10,
            ),
            _entryField('Password', _controllerPassword),
            const SizedBox(
              height: 10,
            ),
            _entryField('Mobile Number', _controllerMobileNo),
            const SizedBox(
              height: 90,
            ),
            _errorMessage(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // _loginButton(),
                const SizedBox(
                  width: 10,
                ),
                _registerButton(),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  _googleSignIn.signIn().then((userData) {
                    _userObj = userData!;
                  }).catchError((e) {
                    isLogin = false;
                    _userObj = _googleSignIn.currentUser!;
                    print(e);
                  });
                },
                child: const Text("Login With Google")),
            _loginOrRegisterButton(),
          ],
        ),
      ),
    );
  }
}
