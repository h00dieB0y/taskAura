import 'package:flutter_test/flutter_test.dart';
import 'package:ui/validators/email_validator.dart';

void main() {
  group("EmailValidator", () {
    test("returns null when email is valid", () {
      const email = "test@example.com";
      final result = EmailValidator.validate(email);

      expect(result, null);
    });

    test("returns 'Email is required' when email is empty", () {
      const email = "";
      final result = EmailValidator.validate(email);

      expect(result, 'Email is required');
    });

    test("returns 'Please enter a valid email' when email missing '@' symbol",
        () {
      const email = "test.example.com";
      final result = EmailValidator.validate(email);

      expect(result, 'Please enter a valid email');
    });

    test("returns 'Please enter a valid email' when email missing '.' symbol",
        () {
      const email = "test@examplecom";
      final result = EmailValidator.validate(email);

      expect(result, 'Please enter a valid email');
    });

    test("returns 'Please enter a valid email' when email missing domain", () {
      const email = "test@.com";
      final result = EmailValidator.validate(email);

      expect(result, 'Please enter a valid email');
    });

    test(
        "returns 'Please enter a valid email' when email missing top-level domain",
        () {
      const email = "test@example.";
      final result = EmailValidator.validate(email);

      expect(result, 'Please enter a valid email');
    });
  });
}
