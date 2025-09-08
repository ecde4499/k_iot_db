CREATE DATABASE IF NOT EXISTS `test`;

-- 1-1. member 테이블 생성 (7점)
CREATE TABLE IF NOT EXISTS `member` (
	member_id BIGINT AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    gender ENUM('M', 'F') NULL,
    join_date DATETIME DEFAULT NOW(),
    PRIMARY KEY (`member_id`)
);

SELECT * FROM `member`;

-- 1-2. product 테이블 생성 (6점)
CREATE TABLE IF NOT EXISTS `product` (
	product_id BIGINT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(30) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock INT NOT NULL CHECK (stock >= 0),
    PRIMARY KEY (`product_id`)
);

-- 1-3. buy 테이블 생성 (5점)
CREATE TABLE IF NOT EXISTS `buy` (
	buy_id BIGINT AUTO_INCREMENT,
    member_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 1),
    payment ENUM ('CARD','BANK','CASH') NOT NULL,
    status ENUM ('PAID','CANCEL') NOT NULL DEFAULT 'PAID',
    buy_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`buy_id`)
);

-- 2-1. 외래키 추가 (6점)
ALTER TABLE `buy`
ADD CONSTRAINT FOREIGN KEY (member_id) REFERENCES member(member_id)
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `buy`
ADD CONSTRAINT FOREIGN KEY (product_id) REFERENCES product(product_id)
ON DELETE RESTRICT ON UPDATE CASCADE;

-- 2-2. 스키마 변경 (6점)
ALTER TABLE `member`
ADD COLUMN email VARCHAR(100) NULL UNIQUE;

-- ALTER TABLE `product`
-- ALTER COLUMN

ALTER TABLE `buy`
ALTER COLUMN `status` SET DEFAULT 'CANCEL';


SELECT * FROM `member`;
-- 3-1. member 3건 삽입 (4점)
INSERT INTO `member` (name, phone, gender)
VALUES ('홍길동', '010-1234-5678', 'M');

INSERT INTO `member` (name, phone)
VALUES ('김이름', '010-4321-8765');

INSERT INTO `member` (name, phone, gender, join_date)
VALUES ('이민영', '010-6543-9876', null, '2025-08-20');


SELECT * FROM `product`;
-- 3-2. product 3건 삽입 (4점)
INSERT INTO `product` (name, category, price, stock)
VALUES
('노트북', '가전제품', 500000, 1),
('소파', '가구', 300000, 3),
('의자', '가구', 200000, 5);


SELECT * FROM `buy`;
-- 3-3. buy 삽입 (4점)
INSERT INTO `buy` (member_id, product_id, quantity, payment)
VALUES 
(1, 3, 2, 'CARD'),
(2, 2, 1, 'BANK'),
(3, 1, 1, 'CASH');

INSERT INTO `buy` (member_id, product_id, quantity, payment)
VALUES 
(1, 2, 2, 'CASH');

-- 4-1. 카테고리별 가격 인상 (6점)
-- FOOD 카테고리 상품 가격을 10% 인상(소수 둘째 자리 반올림)
-- ALTER TABLE `product`
-- ALTER COLUMN `category`

-- 4-2. 취소 주문 정리 (8점)
-- buy에서 status='CANCEL'이고 buy_date가 오늘로부터 30일 이전인 레코드를 삭제
DELETE FROM `buy`
WHERE status = 'CANCEL' AND buy_date < now() - 30;

