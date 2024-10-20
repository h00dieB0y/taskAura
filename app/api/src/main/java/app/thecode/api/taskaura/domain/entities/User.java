package app.thecode.api.taskaura.domain.entities;

import app.thecode.api.taskaura.domain.enums.Role;

import java.util.UUID;

public class User {

    private final UUID id;

    private String email;

    private String password;

    private Role role;

    public User(UUID id, String email, String password, Role role) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    public static User create(String email, String password, Role role) {
        return new User(UUID.randomUUID(), email, password, role);
    }

    public UUID getId() {
        return this.id;
    }

    public String getEmail() {
        return this.email;
    }

    public String getPassword() {
        return this.password;
    }

    public Role getRole() {
        return this.role;
    }

    public User changeEmail(String email) {
        this.email = email;

        return this;
    }

    public User changePassword(String password) {
        this.password = password;

        return this;
    }

    public User changeRole(Role role) {
        this.role = role;

        return this;
    }

    public boolean isPasswordCorrect(String password) {
        return this.password.equals(password);
    }

    public boolean isEmailCorrect(String email) {
        return this.email.equals(email);
    }

    public String toString() {
        return String.format(
                "User{id=%s, email=%s, password=%s, role=%s}",
                this.id, this.email, this.password, this.role
        );
    }
}
