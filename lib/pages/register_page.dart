import 'package:flutter/material.dart';
import 'package:kurs3_sabak9/app_constants/app_constants.dart';
import 'package:kurs3_sabak9/repositories/register/register_repo.dart';
import 'package:kurs3_sabak9/utilities/app_utils/validators/custom_validator.dart';
import 'chat_page.dart';

import 'package:kurs3_sabak9/widgets/custom_button.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  static const String id = AppConstants.register;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
        child: SingleChildScrollView(
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
                      return CustomValidator.emailValidator(val);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12.0),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      labelText: "Сыр сөз",
                      fillColor: Colors.red,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      return CustomValidator.passwordValidator(val);
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
                      return CustomValidator.confirmPassword(
                          val, passwordController.text);
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
      ),
    );
  }

  Future<void> registerWithEmail(String email, String password) async {
    final _userModel =
        await registerRepo.registerWithEmail(context, email, password);

    if (_userModel != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            userModel: _userModel,
          ),
        ),
      );
    }

    setState(() {
      isClicked = false;
    });
  }
}
