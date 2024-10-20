CREATE TABLE users
(
    id              UUID         NOT NULL,
    email           VARCHAR(255) NOT NULL,
    hashed_password VARCHAR(255) NOT NULL,
    role            VARCHAR(255) NOT NULL,
    created_at      TIMESTAMP    NOT NULL,
    updated_at      TIMESTAMP    NOT NULL,
    CONSTRAINT pk_users PRIMARY KEY (id)
);

ALTER TABLE users
    ADD CONSTRAINT uc_users_email UNIQUE (email);