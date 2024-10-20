package app.thecode.api.taskaura.domain.entities;

import app.thecode.api.taskaura.domain.enums.Role;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

class UserTest {

    @Nested
    class UserCreation {

        @Test
        void shouldCreateUserWithConstructor() {
            UUID userId = UUID.randomUUID();
            User newUser = new User(userId, "user@example.com", "securePass", Role.ADMIN);

            assertEquals(userId, newUser.getId());
            assertEquals("user@example.com", newUser.getEmail());
            assertEquals("securePass", newUser.getPassword());
            assertEquals(Role.ADMIN, newUser.getRole());
        }

        @Test
        void shouldCreateUserWithFactoryMethod() {
            User createdUser = User.create("newuser@example.com", "newPassword", Role.USER);

            assertNotNull(createdUser.getId()); // Should have a non-null, random UUID
            assertEquals("newuser@example.com", createdUser.getEmail());
            assertEquals("newPassword", createdUser.getPassword());
            assertEquals(Role.USER, createdUser.getRole());
        }
    }

    @Nested
    class UserModification {

        private User user;

        @BeforeEach
        public void setup() {
            user = new User(UUID.randomUUID(), "test@example.com", "password123", Role.USER);
        }

        @Nested
        class EmailManagement {

            @Test
            void shouldChangeUserEmail() {
                String newEmail = "updated@example.com";
                user.changeEmail(newEmail);

                assertEquals(newEmail, user.getEmail());
            }

            @Test
            void shouldVerifyIfEmailIsCorrect() {
                assertTrue(user.isEmailCorrect("test@example.com"));
                assertFalse(user.isEmailCorrect("wrong@example.com"));
            }
        }

        @Nested
        class PasswordManagement {

            @Test
            void shouldChangeUserPassword() {
                String newPassword = "newPassword123";
                user.changePassword(newPassword);

                assertEquals(newPassword, user.getPassword());
            }

            @Test
            void shouldVerifyIfPasswordIsCorrect() {
                assertTrue(user.isPasswordCorrect("password123"));
                assertFalse(user.isPasswordCorrect("wrongPassword"));
            }
        }

        @Nested
        class RoleManagement {

            @Test
            void shouldChangeUserRole() {
                Role newRole = Role.ADMIN;
                user.changeRole(newRole);

                assertEquals(newRole, user.getRole());
            }
        }

        @Nested
        class UserInformation {

            @Test
            void shouldGenerateCorrectToStringRepresentation() {
                String userString = user.toString();

                assertTrue(userString.contains(user.getId().toString()));
                assertTrue(userString.contains("test@example.com"));
                assertTrue(userString.contains("password123"));
                assertTrue(userString.contains("USER"));
            }
        }
    }
}
