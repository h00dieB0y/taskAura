package app.thecode.api.taskaura.application.dto.requests;

import app.thecode.api.taskaura.application.validation.annotations.PasswordMatches;
import app.thecode.api.taskaura.application.validation.annotations.StrongPassword;
import jakarta.validation.constraints.Email;

@PasswordMatches
public record RegistrationRequest(
        @Email(message = "email must be a valid email address")
        String userEmail,
        @StrongPassword
        String userPassword,
        String userConfirmPassword
) {
}
