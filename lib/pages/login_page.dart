import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kurs3_sabak9/app_constants/app_constants.dart';
import 'package:kurs3_sabak9/app_constants/app_global_assets.dart';
import 'package:kurs3_sabak9/repositories/login/login_repo.dart';

import 'package:kurs3_sabak9/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  static const String id = AppConstants.login;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'logo',
                child: AppGlobalAssets.imageLogo(250.0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Э-почта",
                    fillColor: Colors.red,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (!isEmail(val)) {
                      return 'Э-почтаңызды жазыңыз!';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 24.0),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Сыр сөз",
                    fillColor: Colors.red,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val.length == 0) {
                      return 'Сыр сөздү жазыңыз!';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(height: 24.0),
              isClicked
                  ? CircularProgressIndicator()
                  : CustomButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await loginWithEmail(context, emailController.text,
                              passwordController.text);
                        }
                      },
                      buttonBorderColor: Colors.amberAccent,
                      buttonColor: Colors.amberAccent,
                      buttonText: 'Кирүү',
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginWithEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    setState(() {
      isClicked = true;
    });

    await LoginRepo.loginWithEmail(context, email, password);

    setState(() {
      isClicked = false;
    });
  }
}

/// E-pochtaby je jokbu teksheret
bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(em);
}
