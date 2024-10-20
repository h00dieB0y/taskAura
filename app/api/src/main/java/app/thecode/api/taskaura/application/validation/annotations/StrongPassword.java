package app.thecode.api.taskaura.application.validation.annotations;

import jakarta.validation.Payload;

import java.lang.annotation.Documented;

@Documented
public @interface StrongPassword {
    String message() default "password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit and one special character";

    Class<?>[] groups () default {};

    Class<? extends Payload>[] payload() default {};
}
