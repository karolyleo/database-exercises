USE codeup_test_db;

DROP TABLE IF EXISTS albums;

CREATE TABLE albums(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    artist CHAR(100) NOT NULL,
    name CHAR(100) NOT NULL,
    release_date INT UNSIGNED,
    sales FLOAT,
    genre VARCHAR(100)
);

SHOW CREATE TABLE albums\G;