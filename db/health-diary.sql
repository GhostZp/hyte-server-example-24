DROP DATABASE IF EXISTS HealthDiary;

CREATE DATABASE HealthDiary;

USE HealthDiary;

-- Create a table for users
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_level VARCHAR(10) NOT NULL DEFAULT 'regular'
);

-- Create a table for diary entries
CREATE TABLE DiaryEntries (
    entry_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    entry_date DATE NOT NULL,
    mood VARCHAR(50),
    weight DECIMAL(5,2),
    sleep_hours INT,
    notes TEXT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create a table for health data
CREATE TABLE HealthData (
    entry_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    entry_date DATE NOT NULL,
    sys DECIMAL(5,2),
    dia DECIMAL(5,2),
    pul DECIMAL(5,2),
    notes TEXT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- INSERT USer mock data
-- Iserting multiple user rows at once
INSERT INTO Users (username, password, email, user_level) VALUES
  ('johndoe', 'temp-pw-1', 'johndoe@example.com', 'regular'),
  ('janedoe', 'temp-pw-2', 'janedoe@example.com', 'admin'),
  ('mike_smith', 'temp-pw-3', 'mike@example.com', 'moderator');

-- INSERT Diary mock data
-- Inserting multiple diary entries
INSERT INTO DiaryEntries (user_id, entry_date, mood, weight, sleep_hours, notes, created_at) VALUES
  (1, '2024-01-10', 'Happy', 70.5, 8, 'Had a great day, felt energetic', '2024-01-10 20:00:00'),
  (1, '2024-01-11', 'Tired', 70.2, 6, 'Long day at work, need rest', '2024-01-11 20:00:00'),
  (2, '2024-01-10', 'Stressed', 65.0, 7, 'Busy day, a bit stressed out', '2023-01-10 21:00:00');

-- INSERT HealthData mock data
-- Inserting multiple healthdata entries
INSERT INTO HealthData (user_id, entry_date, sys, dia, pul, notes, created_at) VALUES
  (1, '2024-01-10', 118, 78, 69, 'OK', '2024-01-10 05:10:00'),
  (1, '2024-01-11', 128, 86, 88, 'Stressed', '2024-01-11 21:30:00'),
  (2, '2024-01-10', 140, 88, 86, 'Oops', '2023-01-10 18:00:00');

-- Example queries
SELECT Users.username, DiaryEntries.entry_date, DiaryEntries.mood, DiaryEntries.notes
  FROM Users, DiaryEntries
  WHERE DiaryEntries.user_id = Users.user_id;

-- Same with JOIN
SELECT Users.username, DiaryEntries.entry_date, DiaryEntries.mood, DiaryEntries.notes
  FROM Users JOIN DiaryEntries ON DiaryEntries.user_id = Users.user_id;

-- Entries for specific username
SELECT entry_date, mood, sleep_hours FROM DiaryEntries
  JOIN Users ON DiaryEntries.user_id = Users.user_id
  WHERE username = 'johndoe';

-- Example Update
-- Change user_level of user with id 1 to 'admin'
UPDATE Users SET user_level = 'admin' WHERE user_id = 1;
-- Change mood of entry with id 1 to 'Outstanding'
UPDATE DiaryEntries SET mood = 'Outstanding' WHERE entry_id = 1;

-- Example Delete
DELETE FROM DiaryEntries WHERE entry_id = 2;

-- Examble Query

