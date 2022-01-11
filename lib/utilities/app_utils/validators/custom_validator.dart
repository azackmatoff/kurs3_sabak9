class CustomValidator {
  static String passwordValidator(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    final _isPassOk = regExp.hasMatch(value);

    if (!_isPassOk) {
      return 'Сыр сөздө эң аз бир чоң тамга, кичине тамга, цифра жана символ болушу керек!';
    } else if (value.length == 0) {
      return 'Сыр сөздү жазыңыз!';
    } else {
      return null;
    }
  }

  static String confirmPassword(String password, confirmPassword) {
    if (password != confirmPassword) {
      return 'Сыр сөз дал келбей калды!';
    } else if (password.length == 0) {
      return 'Бул жер бош болбоосу керек!';
    } else {
      return null;
    }
  }

  static String emailValidator(String val) {
    if (!isEmail(val)) {
      return 'Э-почтаңызды жазыңыз!';
    } else {
      return null;
    }
  }
}

/// E-pochtaby je jokbu teksheret
bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(em);
}
