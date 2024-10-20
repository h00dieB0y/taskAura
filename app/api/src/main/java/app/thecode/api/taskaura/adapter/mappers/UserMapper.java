package app.thecode.api.taskaura.adapter.mappers;

import app.thecode.api.taskaura.domain.entities.User;
import app.thecode.api.taskaura.domain.enums.Role;
import app.thecode.api.taskaura.infrastructure.persistence.entities.UserEntity;
import org.springframework.stereotype.Component;

@Component
public class UserMapper {

    public UserEntity toEntity(User user) {
        return new UserEntity()
                .setEmail(user.getEmail())
                .setHashedPassword(user.getPassword())
                .setRole(user.getRole().name());
    }

    public User toDomain(UserEntity userEntity) {
        return new User(userEntity.getId(), userEntity.getEmail(), userEntity.getHashedPassword(), Role.valueOf(userEntity.getRole()));
    }
}
