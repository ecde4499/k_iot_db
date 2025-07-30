### d_dml >> c_제약조건 ###
/*
	1. PK(PRIMARY KEY) - 중복 X(고유값) & 비워둘 수 없음(null 허용 X)
    2. FK(FOREIGN KEY) - 다른 테이블의 PK값을 참조하는 컬럼 (테이블 간의 연결)
    
    3. Unique
    : 특정 열의 값이 중복되면 안됨 - PK 공통점
    - null 허용 가느 (비워둘 수 있음) - PK 차이점
    - 한 테이블에 여러개 지정 가능 - PK 차이점
    Ex) 아이디, 이메일, 주민번호 등에 사용
*/

CREATE TABLE `users` (
	user_id BIGINT PRIMARY KEY,
    username VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    resident_number VARCHAR(100) UNIQUE    
);

INSERT INTO `users`
VALUE                                   
	(1, 'qwe123', 'qwe123123', 'qwe123@example.com', '123456');
    
-- INSERT INTO `users`
-- VALUE
-- 	(2, 'rty456', 'rty456456', 'qwe123@example.com', '654321');
# Error Code: 1062. Duplicate entry 'qwe123@example.com' for key 'users.email'

INSERT INTO `users`
VALUE
	(2, 'rty456', 'rty456456', null, '654321');
-- Unique는 null값 삽입 가능!

/*
	4. Check 제약 조건
    : 입력 값이 특정 조건을 만족해야만 삽입
*/

CREATE TABLE employees (
	employee_id BIGINT PRIMARY KEY,
    name VARCHAR(100),
    age INT, -- 정수의 최대값 제약
    # Check 제약 조건 사용 방법
    # Check(조건 작성 - 조건식은 다양한 연산자 사용)
    CHECK(age >= 20)
);

INSERT INTO `employees`
VALUES
	(1, '이상은', 30),
	(2, '홍기수', 20),
-- 	(3, '배혜진', 10),
	(4, '김태양', 30);
# Error Code: 3819. Check constraint 'employees_chk_1' is violated.

INSERT INTO `employees`
VALUES
	(5, '안미향', NULL); -- Check 제약 조건은 null 여부 확인 X
    
/*
	5. NOT NULL 제약 조건
    : 특정 열에 NULL 값을 허용하지 X
    - 비워질 수 X
*/
CREATE TABLE `contacts` (
	contact_id BIGINT PRIMARY KEY, -- PK는 자동 not null
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL
);

INSERT INTO `contacts`
VALUES
	(1, '권민현', '010-1111-2222'),
-- 	(2, '김세훈', NULL);
# Error Code: 1048. Column 'phone' cannot be null
	(2, '김세훈', '010-2222-3333');
    
/*
	6. Default 제약 조건
    : 테이블의 열에 값이 입력되지 않으면 자동으로 기본값을 넣어주는 제약조건
    - 선택적 필드에 대한 입력을 단순화 (데이터 무결성 유지)
*/

CREATE TABLE `carts` (
	cart_id BIGINT PRIMARY KEY,
    product_name VARCHAR(100),
    # default 제약조건
    # 컬럼명 데이터타입 default 기본값(데이터타입 지키기!)
    quantity INT DEFAULT 1
);

INSERT INTO `carts`
VALUES
	(1, '노트북', 3),
	(2, '스마트폰', NULL),
	(3, '태블릿', 2);
    -- default 설정 컬럼을 비워둘 수는 없음!
    -- null값 입력 시 null 값이 지정 가능 (기본값 설정 X)
    
SELECT * FROM `carts`;

# default 값 사용 방법
# 컬럼 자체에 값 대입 X
INSERT INTO `carts`
VALUES
	# carts의 컬럼을 정의 순서대로 데이터 전달
    # : quantity 수량을 제외한 데이터를 전달할 경우
    #	> 테이블 명 옆에 (삽입하고자 하는 컬럼명만 나열)
    ();

INSERT INTO `carts` (cart_id, product_name)
VALUES
	(4, '이어폰'),
	(5, '스마트폰');
    
SELECT * FROM `carts`;

# =============================================== #
# +) 제약 조건 사용 시 여러 개 동시 지정 가능
# Ex) NOT NULL + CHECK
CREATE TABLE `multiple` (
	multiple_col INT NOT NULL CHECK(multiple_col > 10)
);

INSERT INTO `multiple` 
-- VALUE (1);
VALUE (11);

DROP DATABASE if EXISTS `example`;




