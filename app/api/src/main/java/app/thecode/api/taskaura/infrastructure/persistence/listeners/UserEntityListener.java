package app.thecode.api.taskaura.infrastructure.persistence.listeners;

import app.thecode.api.taskaura.infrastructure.persistence.entities.UserEntity;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;

import java.time.LocalDateTime;

public class UserEntityListener {

    @PrePersist
    public void prePersist(UserEntity userEntity) {
        LocalDateTime now = LocalDateTime.now();
        userEntity
                .setCreatedAt(now)
                .setUpdatedAt(now);
    }

    @PreUpdate
    public void preUpdate(UserEntity userEntity) {
        userEntity.setUpdatedAt(LocalDateTime.now());
    }
}
