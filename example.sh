CREATE TABLE products(
    id VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    decription TEXT,
    price INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL DEFAULT 0,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;

INSERT INTO products (id, name, price, quantity) VALUES ("C0BA", "cake", 1000, 1);

INSERT INTO products (id, name, price, quantity) VALUES ("C0BH", "ayam penyet", 1500, 7), ("C0BG", "sate ayam", 10000, 23), ("C0BF", "ayam geprek", 30000, 15);

SELECT * FROM products;

SELECT id, name, price FROM products;

SELECT * FROM products WHERE quantity = 0;

ALTER TABLE products ADD COLUMN category ENUM('Makanan', 'Minuman', 'Lain-lain') AFTER name;

UPDATE products SET category = 'Makanan' WHERE id = 'C0BA';

UPDATE products SET price = price + 5000 WHERE id = 'C0BA';

DELETE FROM products WHERE id = 'C0BA';

SELECT id as 'Kode', name as 'Name', price as 'Harga', quantity as 'jumlah' FROM products;

SELECT p.id as 'Kode', p.name as 'Name', p.price as 'Harga', p.quantity as 'jumlah' FROM products as p;

SELECT * FROM products WHERE category <> 'Makanan';

SELECT * FROM products WHERE price > 1000;

SELECT * FROM products WHERE price < 1000;

SELECT * FROM products WHERE category <> 'Makanan' AND price > 1000;

SELECT * FROM products WHERE category <> 'Makanan' OR price < 1000;

SELECT * FROM products WHERE name LIKE '%mie%';

SELECT * FROM products WHERE name LIKE 'b%';

SELECT * FROM products WHERE name LIKE '%o';

SELECT * FROM products WHERE name NOT LIKE 'mie';

SELECT * FROM products WHERE category IS NULL;

SELECT * FROM products WHERE category IS NOT NULL;

SELECT * FROM products WHERE price BETWEEN 1000 AND 10000;

SELECT * FROM products WHERE category IN ('Makanan', 'Minuman');

SELECT * FROM products ORDER BY price ASC, id DESC;

SELECT * FROM products ORDER BY id LIMIT 5;

SELECT DISTINCT category FROM products;