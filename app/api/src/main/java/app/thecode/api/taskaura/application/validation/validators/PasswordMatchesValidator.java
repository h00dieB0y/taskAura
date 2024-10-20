package app.thecode.api.taskaura.application.validation.validators;

import app.thecode.api.taskaura.application.dto.requests.RegistrationRequest;
import app.thecode.api.taskaura.application.validation.annotations.PasswordMatches;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class PasswordMatchesValidator implements ConstraintValidator<PasswordMatches, Object> {

    @Override
    public void initialize(PasswordMatches constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(Object obj, ConstraintValidatorContext context) {
        if (obj instanceof RegistrationRequest request) {
            return request.userPassword().equals(request.userConfirmPassword());
        }

        return false;
    }
}
