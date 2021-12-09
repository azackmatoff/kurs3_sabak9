import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    @required this.onPressed,
    @required this.buttonBorderColor,
    @required this.buttonColor,
    @required this.buttonText,
    this.buttonHorizontalWidth,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Color buttonColor;
  final Color buttonBorderColor;
  final String buttonText;
  final double buttonHorizontalWidth;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: buttonBorderColor),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 18.0,
          horizontal:
              buttonHorizontalWidth ?? MediaQuery.of(context).size.width * 0.3,
        ),
        child: Text(buttonText),
      ),
    );
  }
}
