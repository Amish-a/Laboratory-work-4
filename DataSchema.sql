CREATE TABLE app_user (
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    user_surname VARCHAR(100) NOT NULL,
    user_status VARCHAR(20)
        CHECK (user_status IN ('online', 'offline'))
);

CREATE TABLE humidity_record (
    hum_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES app_user (user_id),
    hum_level SMALLINT CHECK (hum_level BETWEEN 0 AND 100),
    measured_at TIMESTAMP NOT NULL
);
