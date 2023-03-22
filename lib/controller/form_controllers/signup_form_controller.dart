import 'package:get/get.dart';

class SignUpFormController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var confirmPasswordText = ''.obs;
  var isLoading = false.obs;

  void setEmail(String value) => email.value = value;
  get emailValue => email.value;

  void setPassword(String value) => password.value = value;
  get passwordVaue => password.value;

  void setConfirmPassword(String value) => confirmPasswordText.value = value;

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

  String? confirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    if (password != null && value != password.value) {
      return 'Passwords do not match';
    }

    return null;
  }
}
