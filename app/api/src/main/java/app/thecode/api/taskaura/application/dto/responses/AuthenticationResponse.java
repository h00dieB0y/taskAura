package app.thecode.api.taskaura.application.dto.responses;


import app.thecode.api.taskaura.domain.enums.TokenType;

public record AuthenticationResponse(
        String userId,
        String userEmail,
        String userAccessToken,
        TokenType tokenType
) {
}
