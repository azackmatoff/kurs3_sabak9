import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kurs3_sabak9/chat_page.dart';
import 'package:kurs3_sabak9/login_page.dart';
import 'package:kurs3_sabak9/register_page.dart';
import 'package:kurs3_sabak9/widgets/custom_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  static const String id = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();

    initAnimation();
    // startAnimation();
  }

  void initAnimation() {
    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    animation = ColorTween(
      begin: Colors.redAccent,
      end: Colors.white,
    ).animate(animationController);
  }

  void startAnimation() {
    animationController.forward();

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('Анимация'),
                  WavyAnimatedText('Старт берүү үчүн мени бас'),
                ],
                isRepeatingAnimation: true,
                onTap: () {
                  startAnimation();
                },
              ),
            ),
            const SizedBox(height: 54.0),
            Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/images/logo.png',
                height: 150.0,
              ),
            ),
            const SizedBox(height: 54.0),
            CustomButton(
              buttonText: 'Login',
              buttonColor: Color(0xff41C3FF),
              buttonBorderColor: Color(0xff41C3FF),
              buttonHorizontalWidth: MediaQuery.of(context).size.width * 0.32,
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.id);
              },
            ),
            const SizedBox(height: 24.0),
            CustomButton(
              buttonText: 'Register',
              buttonColor: Color(0xff4489FF),
              buttonBorderColor: Color(0xff4489FF),
              onPressed: () {
                Navigator.pushNamed(context, RegisterPage.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
