CREATE TABLE app_user (
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL
        CHECK (user_name ~ '^[A-Za-zА-Яа-яЇїІіЄєҐґ]{2,}$'),
    user_surname VARCHAR(100) NOT NULL
        CHECK (user_surname ~ '^[A-Za-zА-Яа-яЇїІіЄєҐґ]{2,}$'),
    user_status VARCHAR(20)
        CHECK (user_status IN ('online', 'offline'))
);

CREATE TABLE humidity_record (
    hum_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    hum_level SMALLINT
    CHECK (hum_level BETWEEN 0 AND 100),
    measured_at TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES app_user (user_id) ON DELETE SET NULL
);

CREATE TABLE humidity_alert (
    alert_id SERIAL PRIMARY KEY,
    hum_id INTEGER,
    alert_text TEXT NOT NULL,
    alert_date DATE NOT NULL,
    alert_type VARCHAR(50)
    CHECK (alert_type IN ('норма', 'перевищення', 'низька')),
    FOREIGN KEY (hum_id) REFERENCES humidity_record (hum_id) ON DELETE CASCADE
);

CREATE TABLE humidity_history (
    hhist_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    hum_level SMALLINT
    CHECK (hum_level BETWEEN 0 AND 100),
    record_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES app_user (user_id) ON DELETE CASCADE
);

CREATE TABLE safety_recommendation (
    rec_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    rec_text TEXT NOT NULL,
    rec_priority SMALLINT
    CHECK (rec_priority BETWEEN 1 AND 5),
    FOREIGN KEY (user_id) REFERENCES app_user (user_id) ON DELETE CASCADE
);

CREATE TABLE hazard_record (
    haz_id SERIAL PRIMARY KEY,
    haz_description TEXT NOT NULL,
    risk_level SMALLINT
    CHECK (risk_level BETWEEN 1 AND 10)
);

CREATE TABLE safety_log (
    log_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    log_action TEXT NOT NULL,
    log_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES app_user (user_id) ON DELETE CASCADE
);

CREATE TABLE chat_room (
    chat_id SERIAL PRIMARY KEY,
    chat_name VARCHAR(200) NOT NULL
);

CREATE TABLE message_record (
    msg_id SERIAL PRIMARY KEY,
    chat_id INTEGER,
    user_id INTEGER,
    msg_text TEXT NOT NULL,
    sent_at TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (chat_id) REFERENCES chat_room (chat_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES app_user (user_id) ON DELETE SET NULL
);

CREATE TABLE dance_lesson (
    lesson_id SERIAL PRIMARY KEY,
    lesson_name VARCHAR(200) NOT NULL,
    lesson_difficulty SMALLINT
    CHECK (lesson_difficulty BETWEEN 1 AND 5)
);

CREATE TABLE dance_progress (
    progress_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    lesson_id INTEGER,
    progress_percent SMALLINT
    CHECK (progress_percent BETWEEN 0 AND 100),
    progress_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES app_user (user_id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id)
    REFERENCES dance_lesson (lesson_id)
    ON DELETE CASCADE
);
