package app.thecode.api.taskaura.application.validation.annotations;

public @interface PasswordMatches {
    String message() default "password and confirm password must match";

    Class<?>[] groups() default {};

    Class<?>[] payload() default {};
}
