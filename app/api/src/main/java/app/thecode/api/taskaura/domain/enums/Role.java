package app.thecode.api.taskaura.domain.enums;

import java.util.Set;

public enum Role {
    ADMIN(
            "ADMIN",
            Set.of(
                    Permission.READ,
                    Permission.WRITE
            )
    ),
    USER (
            "USER",
            Set.of(
                    Permission.READ
            )
    );

    private final String name;

    private final Set<Permission> permissions;

    Role(String name, Set<Permission> permissions) {
        this.name = name;
        this.permissions = permissions;
    }

    public Boolean hasPermission(Permission permission) {
        return this.permissions.contains(permission);
    }

    public Set<Permission> getPermissions() {
        return this.permissions;
    }

    @Override
    public String toString() {
        return String.format("Role{name='%s', permissions=%s}", name, permissions);
    }
}
