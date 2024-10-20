package app.thecode.api.taskaura.domain.interfaces;

import app.thecode.api.taskaura.domain.entities.User;

import java.util.Optional;

public interface UserRepository {
    Optional<User> save(User user);

    Optional<User> findByEmail(String email);
}
