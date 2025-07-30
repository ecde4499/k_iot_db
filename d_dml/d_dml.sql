### d_dml >>> d_dml ###

# cf) ddl (defintion 정의) - DB 정의 언어
# : CREATE(생성), ALTER(수정), DROP(삭제), TRUNCATE(데이터 삭제)

### DML(Data Manipulation Language) ###
# : 데이터 조작(관리) 언어
# - 데이터를 삽입, 조회, 수정, 삭제 (CRUD)

CREATE DATABASE IF NOT EXISTS `company`;
USE `company`;

CREATE TABLE `example01` (
	name VARCHAR(100),
    age INT,
    major VARCHAR(100)
);

/*
	1. 데이터 삽입 (INSERT)
    : 테이블에 행 데이터(레코드)를 입력
    
    # 기본 형식 #
    INSERT INTO 테이블명 (열1, 열2, ... )
    VALUES (값1, 값2, ... );
    
    cf) 테이블명 뒤 열 이름의 나열을 생략할 경우
		: VALUES 뒤의 값 순서는 테이블 정의 시 작성한 열의 순서 & 개수와 동일
		>> name(문자), age(숫자), major(문자) 순
        
	cf) 전체 테이블의 컬럼 순서 & 개수와 차이가 나는 경우 반드시! 원하고자하는 열 이름 나열!
*/

# 1) 컬럼명 지정 X
INSERT INTO `example01`
VALUES
	('오신혁', 20, 'IT');
    
-- INSERT INTO `example01`
-- VALUES
-- 	('박진영', 20);
# > major 값 누락 오류!

-- INSERT INTO `example01`
-- VALUES
-- 	('박진영', 'cooking', 20);
# > 컬럼 정렬 순에 맞지 않는 오류!

# 2) 컬럼명 지정 O
INSERT INTO `example01` (major, name)
VALUES
	('Health', '손태경');
    
# 데이터 삽입 시 NULL 허용 컬럼에 값 입력이 이루어지지 않은 경우
# : 자동으로 NULL값 지정(삽입)

# cf) "auto_increment"
#	: 열을 정의할 때 1부터 1씩 증가하는 값을 입력
# 	- INSERT에서는 해당 열이 없다고 가정하고 입력
#	- 해당 옵션이 지정된 컬럼은 반드시! PK 값으로 지정! (하나의 테이블에 한 번만 지정 가능!)
CREATE TABLE `example02` (
	# 컬럼명 데이터타입 [PRIMARY KEY] [auto_increment] / 옵션 순서 상관 없음
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO `example02` (name)
VALUES
	('최광섭'),
	('정은혜'),
	('정지훈');
    
SELECT * FROM `example02`;

INSERT INTO `example02`
VALUES
	(null, '김승민');
    
SELECT * FROM `example02`;

# cf) auto_increment 최대값 확인
# SELECT MAX(auto_increment컬럼명) FROM `테이블명`;
SELECT MAX(id) FROM `example02`;

# cf) 시작 값 변경
ALTER TABLE `example02` AUTO_INCREMENT = 100; # 테이블 생성 시에도 동일

INSERT INTO `example02`
VALUES
	(null, '박현우');

SELECT * FROM `example02`;

# cf) 다른 테이블의 데이터를 한번에 삽입하는 구문

# INSERT INTO `삽입받을 테이블`
# SELECT ~~~(조회구문작성)

CREATE TABLE `example03` (
	id int,
    name varchar(100)
);

INSERT INTO `example03`
SELECT * FROM `example02`; # 컬럼의 순서, 개수, 자료형이 반드시 일치 (옵션은 상관 없음)

SELECT * FROM `example03`;

/*
	2. 데이터 수정(update)
    : 테이블의 내용을 수정
    
    # 기본 형식 #
    UPDATE `테이블명`
    SET 열1=값1, 열2=값2, ...
    (where 조간);
    
    cf) where 조건이 없는 경우
		: 해당 열(컬럼)의 데이터가 해당 값으로 모두 변경
    
    
*/
UPDATE `example02`
SET name = '권지애';

SELECT * FROM `example02`;

# Error Code: 1175. You are using safe update mode and you tried to update a table 
# without a WHERE that uses a KEY column. 
# To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

# cf) Safe Update Mode 설정 위치 (MySQL Workbench 기준)
# Edit > Preferences > SQL Editor
# 맨 아래 Safe Updates 옵션 해제(Where 조건 제약 X)  / 체크(Where 조건 제약 O)
# +) 재시작 해야 적용 됨!

# cf) 실행 중인 세션에서 일시적으로 Safe 모드 해제
SET SQL_SAFE_UPDATES = 1; # 1: 모드 사용
SET SQL_SAFE_UPDATES = 0; # 0: 모드 해제

UPDATE `example02`
SET name = '김동후'
where id = 1;

SELECT * FROM `example02`;

/*
	3. 데이터 삭제(DELETE)
    : 테이블의 데이터를 삭제하기 위한 키워드
    
    # 기본 형태 #
    DELETE FROM `테이블명`
    Where 조건;
*/

SET SQL_SAFE_UPDATES = 0;
DELETE FROM `example02`;

SELECT * FROM `example02`;

SET SQL_SAFE_UPDATES = 1;

DELETE FROM `example02`
WHERE id=1;







