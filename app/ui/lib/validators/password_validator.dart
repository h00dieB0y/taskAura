class PasswordValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // Contains at least one uppercase letter
    if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Contains at least one lowercase letter
    if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    // Contains at least one number
    if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    // Contains at least one special character
    if (!RegExp(r'^(?=.*?[!@#$&*~])').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static String? validateConfirmPassword(
      String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Confirm Password can\'t be empty';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }
}
