import 'dart:developer';

import 'package:uuid/uuid.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kurs3_sabak9/chat_page.dart';
import 'package:kurs3_sabak9/models/user_model.dart';
import 'package:kurs3_sabak9/widgets/custom_button.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  static const String id = 'register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();
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
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 250.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 12.0),
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
                    horizontal: 12.0, vertical: 12.0),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 12.0),
                child: TextFormField(
                  controller: checkPasswordController,
                  decoration: InputDecoration(
                    labelText: "Сыр сөздү тастыктоо",
                    fillColor: Colors.red,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val != passwordController.text) {
                      return 'Сыр сөз дал келбей калды!';
                    } else if (val.length == 0) {
                      return 'Бул жер бош болбоосу керек!';
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
                          setState(() {
                            isClicked = true;
                          });
                          await registerWithEmail(
                            emailController.text,
                            checkPasswordController.text,
                          );
                        }
                      },
                      buttonBorderColor: Colors.amberAccent,
                      buttonColor: Colors.amberAccent,
                      buttonText: 'Катталуу',
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      /// Future, birok then versiyasy
      ///  UserCredential userCred;
      // firebaseAuth
      //     .createUserWithEmailAndPassword(email: email, password: password)
      //     .then((value) => userCred = value);

      final User _user = userCredential.user;
      UserModel _userModel;

      var uuid = Uuid();

      final _newUserID =
          uuid.v1(); // -> "710b962e-041c-11e1-9234-0123456789ab";

      log('uuidValue =====> $_newUserID'); // -> '710b962e-041c-11e1-9234-0123456789ab'

      CollectionReference userCollection = firestore.collection('users');

      /// Create user and add to database
      userCollection.doc(_newUserID).set({
        'displayName': _user.displayName,
        'email': _user.email,
        'userId': _newUserID,
      }).then((_) async {
        /// Get newly created user
        final docSnapshot = await userCollection.doc(_newUserID).get();

        if (docSnapshot.exists) {
          final _data = docSnapshot.data() as Map<String, dynamic>;

          _userModel = UserModel.fromJson(_data, _newUserID);

          log('_userModel =====> $_userModel');
        }

        /// Usermodel null emes bolso, chatpage ke jibergenche ach
        if (_userModel != null) {
          // Navigator.pushNamed(context, ChatPage.id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                userModel: _userModel,
              ),
            ),
          );
        }
      });

      setState(() {
        isClicked = false;
      });
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
}
