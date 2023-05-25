SHOW databases;
SHOW tables;
CREATE database belajar;
DROP database belajar;
USE belajar;
SHOW ENGINES;
CREATE TABLE barang ( id INT NOT NULL, name VARCHAR(100) NOT NULL, harga INT NOT NULL DEFAULT 0, jumlah INT NOT NULL DEFAULT 0) ENGINE = InnoDB;
DESCRIBE barang;
SHOW CREATE TABLE barang;
ALTER TABLE barang
    ADD COLUMN createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;
    DROP COLUMN createdAt;
    MODIFY name VARCHAR(200) AFTER createdAt;

INSERT INTO barang (id, name) VALUES (1, "apel");
SELECT * FROM barang;
SELECT * FROM barang WHERE name = 'apel';
TRUNCATE barang;
DROP TABLE barang;
UPDATE barang SET name = 'banana' WHERE id = 1;
DELETE FROM barang WHERE id = 1;
SELECT DICSTINCT name FROM barang;
SELECT PI();
SELECT LAST_INSERT_ID();