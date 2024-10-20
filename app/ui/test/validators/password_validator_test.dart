import 'package:flutter_test/flutter_test.dart';
import 'package:ui/validators/password_validator.dart';

void main() {
  group("PasswordValidator", () {
    test("returns null when password is valid", () {
      const password = "Password@123";
      final result = PasswordValidator.validate(password);

      expect(result, null);
    });

    test("returns 'Password is required' when password is empty", () {
      const password = "";
      final result = PasswordValidator.validate(password);

      expect(result, 'Password is required');
    });

    test(
        "returns 'Password must be at least 8 characters' when password is less than 8 characters",
        () {
      const password = "Pass@1";
      final result = PasswordValidator.validate(password);

      expect(result, 'Password must be at least 8 characters');
    });

    test(
        "returns 'Password must contain at least one uppercase letter' when password does not contain uppercase letter",
        () {
      const password = "password@123";
      final result = PasswordValidator.validate(password);

      expect(result, 'Password must contain at least one uppercase letter');
    });

    test(
        "returns 'Password must contain at least one lowercase letter' when password does not contain lowercase letter",
        () {
      const password = "PASSWORD@123";
      final result = PasswordValidator.validate(password);

      expect(result, 'Password must contain at least one lowercase letter');
    });

    test(
        "returns 'Password must contain at least one number' when password does not contain number",
        () {
      const password = "Password@";
      final result = PasswordValidator.validate(password);

      expect(result, 'Password must contain at least one number');
    });

    test(
        "returns 'Password must contain at least one special character' when password does not contain special character",
        () {
      const password = "Password123";
      final result = PasswordValidator.validate(password);

      expect(result, 'Password must contain at least one special character');
    });

    test("returns null when password and confirm password match", () {
      const password = "Password@123";
      const confirmPassword = "Password@123";
      final result =
          PasswordValidator.validateConfirmPassword(password, confirmPassword);

      expect(result, null);
    });

    test(
        "returns 'Passwords do not match' when password and confirm password do not match",
        () {
      const password = "Password@123";
      const confirmPassword = "Password@1234";
      final result =
          PasswordValidator.validateConfirmPassword(password, confirmPassword);

      expect(result, 'Passwords do not match');
    });
  });
}
