import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kurs3_sabak9/chat_page.dart';
import 'package:kurs3_sabak9/home_page.dart';
import 'package:kurs3_sabak9/login_page.dart';
import 'package:kurs3_sabak9/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LoginPage(),
      // home: RegisterPage(),
      // home: ChatPage(),
      //Versiya 1
      // initialRoute: '/',
      // routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   '/': (context) => const HomePage(),
      //   // When navigating to the "/second" route, build the SecondScreen widget.
      //   '/login': (context) => const LoginPage(),
      //   '/register': (context) => const RegisterPage(),
      //   '/chat': (context) => const ChatPage(),
      // },

      //Versiya 2
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage(),
      },
    );
  }
}
