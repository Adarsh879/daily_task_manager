import 'package:get/get.dart';

class LoginFormController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  void setEmail(String value) => email.value = value;
  String get emailValue => email.value;

  void setPassword(String value) => password.value = value;
  String get passwordVaue => password.value;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    } else {
      // isEmailValid.value = true;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password should be at least 6 characters long';
    }
    return null;
  }
}
