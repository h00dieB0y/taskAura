package app.thecode.api.taskaura.infrastructure.persistence.entities;

import app.thecode.api.taskaura.infrastructure.persistence.listeners.UserEntityListener;
import jakarta.persistence.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import java.time.LocalDateTime;
import java.util.UUID;

@Table(name = "users")
@Entity
@EntityListeners(UserEntityListener.class)
public class UserEntity {

    @Id
    @Column(updatable = false, nullable = false, unique = true)
    private UUID id;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String hashedPassword;

    @Column(nullable = false)
    private String role;

    @CreatedDate
    @Column(updatable = false, nullable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(nullable = false)
    private LocalDateTime updatedAt;

    public UserEntity() {
        // Jpa requires a default constructor for entities classes because it needs to create instances of the entity class using reflection.
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public UserEntity setEmail(String email) {
        this.email = email;

        return this;
    }

    public String getHashedPassword() {
        return hashedPassword;
    }

    public UserEntity setHashedPassword(String password) {
        this.hashedPassword = password;

        return this;
    }

    public String getRole() {
        return role;
    }

    public UserEntity setRole(String role) {
        this.role = role;

        return this;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public UserEntity setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;

        return this;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public UserEntity setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;

        return this;
    }
}
