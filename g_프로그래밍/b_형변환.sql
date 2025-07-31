### g_프로그래밍 >>> b_형변환 ###
# : 한 데이터 타입을 다른 데이터 타입으로 바꾸는 것
USE `market_db`;

### 1) 명시적 형 변환
# case(값 as 데이터형식)
# convert(값, 데이터형식)
# > 두 문법은 형식만 다르고 기능은 동일

SELECT * FROM buy;

SELECT 
	avg(price) AS '평균 가격'
FROM
	buy;
    
# cf) 형 변환 시 정수형 데이터 타입
#		> signed, unsigned만 사용 가능 (tinyint, int 등 사용 불가!)
#		- signed: 부호가 있는 정수 (양수/음수 모두 가능)

SELECT
	avg(price) AS '평균 가격',
	CAST(AVG(price) AS UNSIGNED) '정수 평균 가격', -- 143
	CONVERT(AVG(price), UNSIGNED) '정수 평균 가격'
FROM
	buy;
    
-- 날짜 형 변환 (포맷 지정)
# date 타입: YYYY-MM-DD
# > MySQL은 문자형식을 자동으로 분석하여 YYYY-MM0DD 형식으로 변환
# cf) 형식이 너무 벗어나는 경우 오류 발생 (변환 X)

SELECT CAST('2025$07$31' AS DATE);
SELECT CAST('2025@07@31' AS DATE);
SELECT CAST('2025^07^31' AS DATE);

SELECT CONVERT('07.31.2025', DATE); -- null

# cast: SQL 표준
# convert: MySQL 고유 문법

### 2) 묵시적 행 변환
# : 자동으로 데이터를 변환하는 것
SELECT '100' + '200'; -- 100200 X, 300

# cf) 문자열을 이어서 작성
# concat('a', 'b') 함수를 사용
SELECT concat('100', '200');









