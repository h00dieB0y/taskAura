package app.thecode.api.taskaura.application.usecases;

import app.thecode.api.taskaura.application.dto.requests.RegistrationRequest;
import app.thecode.api.taskaura.application.dto.responses.AuthenticationResponse;
import app.thecode.api.taskaura.domain.interfaces.UserRepository;
import app.thecode.api.taskaura.domain.UserAlreadyExistsException;
import app.thecode.api.taskaura.domain.entities.User;
import app.thecode.api.taskaura.domain.enums.Role;
import app.thecode.api.taskaura.domain.enums.TokenType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class RegisterUserUseCase {

    private final UserRepository userRepository;

    private final PasswordEncoder passwordEncoder;

    public RegisterUserUseCase(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public AuthenticationResponse execute(RegistrationRequest request) {
        if (userRepository.existsByEmail(request.userEmail())) {
            throw new UserAlreadyExistsException(request.userEmail());
        }

        User user = User.create(request.userEmail(), passwordEncoder.encode(request.userPassword()), Role.USER);

        userRepository.save(user);

        return new AuthenticationResponse(
                user.getId().toString(),
                user.getEmail(),
                "temporalAccessToken",
                TokenType.BEARER
        );
    }
}
