-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS users (
    id uuid NOT NULL,
    login text,
    first_name text,
    last_name text,
    date_of_birth text,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS users_contacts (
    id uuid,
    user_id uuid,
    contact text,
    contact_type int,
    created_at timestamp,
    deleted_at timestamp,
    CONSTRAINT users_users_contacts_fkey
        FOREIGN KEY (user_id) REFERENCES users (id),
    PRIMARY KEY (id)
);

CREATE INDEX users_contacts_contact_idx ON users_contacts(contact);
CREATE INDEX users_contacts_user_id_idx ON users_contacts(user_id);
CREATE INDEX users_contacts_user_id_contact_type_idx ON users_contacts(user_id, contact_type) WHERE deleted_at IS NULL;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS users_contacts;
-- +goose StatementEnd
