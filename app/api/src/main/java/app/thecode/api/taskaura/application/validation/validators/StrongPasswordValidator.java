package app.thecode.api.taskaura.application.validation.validators;

import app.thecode.api.taskaura.application.validation.annotations.StrongPassword;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class StrongPasswordValidator implements ConstraintValidator<StrongPassword, String> {
    @Override
    public void initialize(StrongPassword constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(String password, ConstraintValidatorContext constraintValidatorContext) {
        if (password == null) {
            return false;
        }

        boolean length = password.length() >= 8;
        boolean upperCase = password.chars().anyMatch(Character::isUpperCase);
        boolean lowerCase = password.chars().anyMatch(Character::isLowerCase);
        boolean digit = password.matches(".*\\d.*");
        boolean specialCharacter = !password.matches("[A-Za-z0-9 ]*");

        return length && upperCase && lowerCase && digit && specialCharacter;
    }
}
