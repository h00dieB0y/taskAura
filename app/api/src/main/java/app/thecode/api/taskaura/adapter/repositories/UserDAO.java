package app.thecode.api.taskaura.adapter.repositories;

import app.thecode.api.taskaura.adapter.mappers.UserMapper;
import app.thecode.api.taskaura.domain.entities.User;
import app.thecode.api.taskaura.domain.interfaces.UserRepository;
import app.thecode.api.taskaura.infrastructure.persistence.repositories.JpaUserRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public class UserDAO implements UserRepository {

    private final JpaUserRepository jpaUserRepository;

    private final UserMapper userMapper;

    public UserDAO(JpaUserRepository jpaUserRepository, UserMapper userMapper) {
        this.jpaUserRepository = jpaUserRepository;
        this.userMapper = userMapper;
    }

    @Override
    public Optional<User> save(User user) {
        return Optional.of(
                userMapper.toDomain(
                        jpaUserRepository.save(
                                userMapper.toEntity(user)
                        )
                )
        );
    }

    @Override
    public boolean existsByEmail(String email) {
        return jpaUserRepository.existsByEmail(email);
    }
}
