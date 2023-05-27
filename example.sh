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

SELECT * FROM products WHERE name = "bakso";

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

INSERT INTO wishList(id_product, description) VALUES ("C0BH", "Makanan kesukaan");

ALTER TABLE wishList ADD CONSTRAINT `fk_wishList_product` FOREIGN KEY(id_product) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE;

SELECT * FROM wishList as w JOIN products as p ON (w.id_product = p.id);

SELECT p.id as idProduct, p.name as nameProduct, p.price as priceProduct, w.id as id, w.description as description FROM wishList AS w JOIN products AS p ON (w.id_product = p.id);

ALTER TABLE wishList ADD customer_id INT;

ALTER TABLE wishList ADD CONSTRAINT `fk_wishList_customer` FOREIGN KEY(id_customer) REFERENCES customers(id) ON DELETE CASCADE ON UPDATE CASCADE;

SELECT c.email as email, p.name as nameProduct, p.price as priceProduct, w.description as description FROM wishList as w Join products as p ON (w.id_product = p.id) JOIN customers as c ON (w.id_customer = c.id);

# customers

CREATE TABLE customers (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (email)
) ENGINE = InnoDB;

# wallet
CREATE TABLE wallet (
    id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    balance INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE KEY `customer_id_unique` (customer_id),
    FOREIGN KEY `FK_wallet_customer` (customer_id) REFERENCES customers (id)
) ENGINE = InnoDB;

INSERT INTO wallet (customer_id) VALUES(1), (2);

SELECT c.email, w.balance FROM wallet as w JOIN customers as c ON (w.customer_id = c.id);

# category

CREATE TABLE categories (
   id VARCHAR(10) NOT NULL,
   name VARCHAR(100) NOT NULL,
   PRIMARY KEY (id)
) ENGINE = InnoDB;

ALTER TABLE products DROP COLUMN category;

ALTER TABLE products ADD COLUMN id_category VARCHAR(10);

ALTER TABLE products ADD CONSTRAINT `fk_products_categories` FOREIGN KEY (id_category) REFERENCES categories (id);

INSERT into categories (id, name) VALUES ("001", "Makanan"), ("002", "Minuman"), ("003", "Lain-lain");

UPDATE products SET id_category = "001" WHERE id IN ("C0BB", "C0BC", "C0BD", "C0BE", "C0BF", "C0BG");

SELECT p.id, p.name, c.name as category FROM products as p JOIN categories as c ON (p.id_category = c.id);

# order

CREATE TABLE orders (
    id INT NOT NULL AUTO_INCREMENT,
    total INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

DESCRIBE orders;

INSERT INTO orders(total) VALUES (50000);

# detail order

CREATE TABLE orders_detail(
    id_product VARCHAR(10) NOT NULL,
    id_order INT NOT NULL,
    price INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY(id_product, id_order)
) ENGINE=InnoDB;

ALTER TABLE orders_detail ADD CONSTRAINT `fk_orders_detail_product` FOREIGN KEY (id_product) REFERENCES products(id);

ALTER TABLE orders_detail ADD CONSTRAINT `fk_orders_detail_orders` FOREIGN KEY (id_order) REFERENCES orders(id);

SHOW CREATE TABLE orders_detail;

INSERT INTO orders_detail(id_product, id_order, price, quantity) VALUES ("C0BB", 1, 25000, 1), ("C0BC", 1, 25000, 1);

INSERT INTO orders_detail(id_product, id_order, price, quantity) VALUES ("C0BC", 2, 25000, 1), ("C0BB", 2, 25000, 1);

SELECT * FROM orders JOIN orders_detail ON (orders_detail.id_order = orders.id) JOIN products ON (products.id = orders_detail.id_product);


# Lanjut

SELECT * FROM categories LEFT JOIN products ON (categories.id = products.id_category);

SELECT * FROM categories RIGHT JOIN products ON (categories.id = products.id_category);

SELECT * FROM categories CROSS JOIN products;

SELECT * FROM products WHERE price > (SELECT AVG(price) FROM products);

SELECT MAX(price) FROM products;

SELECT MAX(price) FROM (SELECT price FROM categories JOIN products ON (products.id_category = categories.id)) as cp;

# guestBooks

CREATE TABLE guestBooks (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(200),
    title VARCHAR(200),
    content TEXT,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

INSERT INTO guestBooks (email, title, content) VALUES ("guest@gmail.com", "Hello", "Hello"), ("guest1@gmail.com", "Hello", "Hello"), ("guest2@gmail.com", "Hello", "Hello"), ("roxyzc@gmail.com", "Hello", "Hello"), ("roxyzc@gmail.com", "Hello", "Hello"), ("roxyzc@gmail.com", "Hello", "Hello");

SELECT DISTINCT email FROM customers UNION SELECT DISTINCT email FROM guestBooks;

SELECT DISTINCT email FROM customers UNION ALL SELECT DISTINCT email FROM guestBooks;

SELECT emails.email, COUNT(emails.email) FROM (SELECT email FROM customers UNION ALL SELECT email FROM guestBooks) as emails GROUP BY emails.email;

SELECT COUNT(p.id) AS 'Total products', p.name FROM (SELECT products.id, categories.name FROM products JOIN categories ON(products.id_category = categories.id)) as p GROUP BY p.name;

SELECT DISTINCT email FROM customers WHERE email IN (SELECT DISTINCT email FROM guestBooks);

SELECT DISTINCT customers.email FROM customers INNER JOIN guestBooks ON(guestBooks.email = customers.email);

SELECT DISTINCT customers.email, guestBooks.email FROM customers LEFT JOIN guestBooks ON(guestBooks.email = customers.email) WHERE guestBooks.email IS NULL;

# TRANSACTION
START TRANSACTION;
INSERT INTO guestBooks (email, title, content) VALUES ("apage@gmail.com", "contoh", "ya"),("apage1@gmail.com", "contoh", "ya"),("apage@gmail.com", "contoh", "ya");
SELECT * FROM guestBooks;
COMMIT;

##########3

START TRANSACTION;
DELETE FROM guestBooks;
ROLLBACK;

# LOCKING

START TRANSACTION;

SELECT * FROM products WHERE id = "C0BD" FOR UPDATE;

UPDATE products SET quantity = quantity - 5 WHERE id = "C0BD";

COMMIT;

# DEAD LOCK
#user 1
START TRANSACTION;

SELECT * FROM products WHERE id = "C0BA" FOR UPDATE;

SELECT * FROM products WHERE id = "C0BB" FOR UPDATE;

#user 2
START TRANSACTION;

SELECT * FROM products WHERE id = "C0BB" FOR UPDATE;

SELECT * FROM products WHERE id = "C0BA" FOR UPDATE;

# LOCK TABLE READ
LOCK TABLES products READ;

UNLOCK TABLES;

# LOCK TABLE WRITE
LOCK TABLES products WRITE;

UNLOCK TABLES;

# LOCK INSTANCE
LOCK INSTANCE FOR BACKUP;

UNLOCK INSTANCE;

# hak akses
CREATE USER 'roxyzc'@'localhost';
CREATE USER 'rozy'@'%';

DROP USER 'roxyzc'@'localhost';
DROP USER 'rozy'@'%';

GRANT SELECT ON belajar.* TO 'roxyzc'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON belajar.* TO 'rozy'@'%';

SHOW GRANTS FOR 'roxyzc'@'localhost';
SHOW GRANTS FOR 'rozy'@'%';

SET PASSWORD FOR 'roxyzc'@'localhost' = 'rahasia';
SET PASSWORD FOR 'rozy'@'%' = 'rahasia';

# backup
mysqldump "nama database" --user root --password --result-file="filenya";

    #on docker use cmd
    docker exec "container" /usr/bin/mysqldump -u root --password="your password" "database" > backup.sql

    #bash
    docker exec -i mysql mysqldump -u root -p="your password" --databases belajar --skip-comments > backup1.sql

# restore
mysql --user=roott --password "nama database" < "filenya" 

    #on docker use cmd
    cat backup.sql | docker exec -i "container" /usr/bin/mysql -u root --password="your password" "your database"

    #bash
    cat backup.sql | docker exec -i "container" mysql -u root --password="your password" "your database"

# source
create database "nama database";

source "filenya"
