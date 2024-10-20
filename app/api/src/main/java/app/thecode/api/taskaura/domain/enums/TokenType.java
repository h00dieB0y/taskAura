package app.thecode.api.taskaura.domain.enums;

public enum TokenType {
    BEARER("Bearer");

    private final String type;

    TokenType(String type) {
        this.type = type;
    }

    public String getType() {
        return this.type;
    }

    @Override
    public String toString() {
        return String.format("TokenType{type='%s'}", type);
    }
}
