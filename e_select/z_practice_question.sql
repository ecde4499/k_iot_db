### e_select 폴더 >>> z_practice_question 파일 ###

use `korea_db`;
# members, purchases 테이블 사용
SELECT * FROM `members`;
SELECT * FROM `purchases`;

-- 1. 모든 회원의 이름, 연락처, 회원등급을 조회하시오.
SELECT name, contact, grade
FROM `members`;

-- 2. 'SEOUL'에 거주하는 회원의 이름과 회원등급을 조회하시오.
SELECT name, grade
FROM `members`
WHERE area_code = 'SEOUL';

-- 3. 회원등급이 'Gold' 이상인 회원의 이름과 가입일을 조회하시오.
SELECT name, join_date, grade
FROM `members`
WHERE grade IN ('Gold', 'Platinum', 'Diamond');

-- 4. 2023년도에 가입한 회원의 이름과 가입일을 조회하시오.
SELECT name, join_date
FROM `members`
WHERE year(join_date) = 2023;

-- 5. 100포인트 이상을 가진 회원의 이름과 포인트를 조회하시오.
SELECT name, points
FROM `members`
WHERE points >= 100;

-- 6. 'Male' 성별의 회원 중에서 'Gold' 등급 이상의 회원을 조회하시오.
SELECT name, gender, grade
FROM `members`
WHERE
	gender = 'Male' AND grade = 'Gold';

-- 7. 최근에 구매한 회원과 구매일을 조회하시오. (가장 최근 구매일 기준 상위 3명)
-- group by, 집계함수, order by, limit
SELECT * FROM `members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id;

SELECT
	M.name, MAX(P.purchase_date) last_purchases, M.member_id
FROM
	`members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id
GROUP BY
	M.member_id
ORDER BY
	MAX(P.purchase_date) DESC
LIMIT 3;


SELECT 
	member_id, max(purchase_date) last_purchases
FROM `purchases`
GROUP BY
	member_id
ORDER BY
	max(purchase_date) DESC
LIMIT 3;

-- 8. 회원별로 구매한 총 금액(amount의 합)을 조회하시오.
-- group by, 집계함수
SELECT * FROM `members`;
SELECT * FROM `purchases`;

SELECT * FROM `members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id;

select
	M.name, P.member_id, sum(amount)
FROM
	`purchases` P
    JOIN `members` M
    ON M.member_id = P.member_id
group by
	member_id;



