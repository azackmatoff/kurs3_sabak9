import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kurs3_sabak9/app_constants/app_constants.dart';
import 'package:kurs3_sabak9/models/user_model.dart';
import 'package:kurs3_sabak9/pages/chat_page.dart';
import 'package:kurs3_sabak9/pages/home_page.dart';
import 'package:kurs3_sabak9/pages/login_page.dart';
import 'package:kurs3_sabak9/pages/register_page.dart';
import 'package:kurs3_sabak9/utilities/firestore_collections/firestore_collections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirestoreCollections.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage(userModel: UserModel()),
      },
    );
  }
}
