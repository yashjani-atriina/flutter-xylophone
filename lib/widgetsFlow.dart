// import 'package:flutter/material.dart';
// import 'package:flutterauthentication/auth.dart';
// import 'package:flutterauthentication/pages/homePage.dart';
// import 'package:flutterauthentication/pages/loginRegisterPage.dart';

// class WidgetTreeFlow extends StatefulWidget {
//   WidgetTreeFlow({Key? key}) : super(key: key);

//   @override
//   State<WidgetTreeFlow> createState() => _WidgetTreeFlowState();
// }

// class _WidgetTreeFlowState extends State<WidgetTreeFlow> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: Auth().authStateChanges,
//         builder: ((context, snapshot) {
//           if (snapshot.hasData) {
//             return HomePage();
//           } else {
//             return LoginRegister();
//           }
//         }));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutterauthentication/auth.dart';
import 'package:flutterauthentication/pages/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterauthentication/pages/loginRegisterPage.dart';

class WidgetTree extends StatefulWidget {
  WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authstateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
