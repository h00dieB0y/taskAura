package app.thecode.api.taskaura.adapter.controllers;

import app.thecode.api.taskaura.application.dto.requests.RegisterUserRequest;
import app.thecode.api.taskaura.application.dto.responses.AuthenticationResponse;
import app.thecode.api.taskaura.application.usecases.RegisterUserUseCase;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AuthenticationController {
    private final String AUTHENTICATION_PATH = "/api/authenticate";

    private final RegisterUserUseCase registerUserUseCase;

    public AuthenticationController(RegisterUserUseCase registerUserUseCase) {
        this.registerUserUseCase = registerUserUseCase;
    }

    @PostMapping(AUTHENTICATION_PATH + "/register")
    public AuthenticationResponse registerUser(@RequestBody RegisterUserRequest request) {

        return registerUserUseCase.execute(request);
    }
}
