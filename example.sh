# jangan gunakan query LIKE jika datanya banyak direkomendasikan menggunakan FULLTEXT

CREATE TABLE products(
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE KEY,
    decription TEXT,
    price INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL DEFAULT 0,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT `check_price` CHECK (price > 0),
    INDEX `name_index` (name),
    FULLTEXT `product_search` (name, description)
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

SELECT id, name, price, price DIV 1000 AS "Price in K" FROM products;

SELECT id, name, price FROM products WHERE price DIV 1000 > 15000;

SELECT id, LOWER(name) as "Name" FROM products;

SELECT id, createdAt, EXTRACT(YEAR FROM createdAt) AS Year, EXTRACT(MONTH FROM createdAt) AS Month From products;

SELECT id, createdAt, YEAR(createdAt), MONTH(createdAt) FROM products;

SELECT id, CASE category WHEN 'Makanan' THEN 'Food' WHEN 'Minuman' THEN 'Drink' ELSE 'Other' END AS 'Category' From products;

SELECT id, price, IF(price <= 15000, 'Murah', IF(price <= 2000, 'Mahal', 'Mahal banget')) AS 'Mahal?' FROM products;

SELECT id, name, IFNULL(decription, 'Kosong') AS description FROM products;

SELECT COUNT(id) AS 'Total products' FROM products;

SELECT MAX(price) AS 'Product Termahal' FROM products;

SELECT MIN(price) AS 'Product Termurah' FROM products;

SELECT AVG(price) AS 'Rata-rata Harga' FROM products;

SELECT SUM(quantity) AS 'Total stock' FROM products;

SELECT COUNT(id) AS 'Total products', category FROM products GROUP BY category;

SELECT MAX(price) AS 'Product Termahal', category FROM products GROUP BY category;

SELECT MIN(price) AS 'Product Termurah', category FROM products GROUP BY category;  

SELECT AVG(price) AS 'Rata-rata Harga', category FROM products GROUP BY category;

SELECT SUM(quantity) AS 'Total stock', category FROM products GROUP BY category;

SELECT category, COUNT(id) AS 'Total' FROM products GROUP BY category HAVING Total > 1;

ALTER TABLE products ADD CONSTRAINT name_unique UNIQUE(name);

ALTER TABLE products ADD CONSTRAINT price_check CHECK (price >= 0);

ALTER TABLE products DROP CONSTRAINT name_unique;

ALTER TABLE products ADD INDEX name_index (name);

ALTER TABLE products DROP INDEX name_index;

ALTER TABLE products ADD FULLTEXT product_search (name, decription);

ALTER TABLE products DROP INDEX product_search;

SELECT * FROM products WHERE MATCH(name, decription) AGAINST ('ayam' IN NATURAL LANGUAGE MODE);

SELECT * FROM products WHERE MATCH(name, decription) AGAINST ('-mie +ayam' IN BOOLEAN MODE);

SELECT * FROM products WHERE MATCH(name, decription) AGAINST ('mie' WITH QUERY EXPANSION);

# example foreign keys
CREATE TABLE wishList(
    id INT NOT NULL AUTO_INCREMENT,
    id_product VARCHAR(10) NOT NULL,
    description TEXT,
    PRIMARY KEY (id),
    CONSTRAINT `fk_wishList_product` FOREIGN KEY (id_product) REFERENCES `products` (id)
) ENGINE = InnoDB;

ALTER TABLE wishList ADD CONSTRAINT `fk_wishList_product` FOREIGN KEY (id_product) REFERENCES products (id);

ALTER TABLE wishList Drop CONSTRAINT `fk_wishList_product`;