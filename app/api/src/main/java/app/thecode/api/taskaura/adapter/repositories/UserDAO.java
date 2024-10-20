package app.thecode.api.taskaura.adapter.repositories;

import app.thecode.api.taskaura.domain.entities.User;
import app.thecode.api.taskaura.domain.interfaces.UserRepository;
import app.thecode.api.taskaura.infrastructure.persistence.repositories.JpaUserRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public class UserDAO implements UserRepository {

    private final JpaUserRepository jpaUserRepository;

    public UserDAO(JpaUserRepository jpaUserRepository) {
        this.jpaUserRepository = jpaUserRepository;
    }

    @Override
    public Optional<User> save(User user) {
        return Optional.empty();
    }

    @Override
    public Optional<User> findByEmail(String email) {
        return Optional.empty();
    }
}
