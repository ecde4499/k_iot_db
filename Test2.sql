-- 공통 시나리오
-- ※ 데이터베이스 이름: school_db

-- ※ 테이블 구조:

-- student(student_id PK, name, grade, phone, dept_id FK)

-- department(dept_id PK, dept_name, office)

-- enroll(enroll_id PK, student_id FK, subject, score)

-- 문제 1. 데이터 조회 (SELECT) — 20점
-- 다음 요구사항에 맞는 SQL을 작성하시오.

-- 1-1 (7점)
-- student 테이블에서 2학년(grade=2) 학생의 이름과 전화번호를 출력하시오.
SELECT name, phone
FROM student
WHERE grage = 2;

-- 1-2 (7점)
-- department와 student를 조인하여, 각 학생의 이름과 소속 학과 이름을 출력하시오.
SELECT S.name, D.dept_name
FROM department D
	LEFT JOIN student S
    ON D.dept_id = S.dept_id;

-- 1-3 (6점)
-- enroll 테이블에서 score가 90점 이상인 학생의 학번(student_id)과 과목명을 출력하시오.
SELECT student_id, subject
FROM enroll
WHERE score >= 90;

-- 문제 2. 데이터 입력 (INSERT) — 15점
-- 다음 요구사항을 만족하는 SQL을 작성하시오.

-- 2-1 (5점)
-- 새로운 학과 (dept_id=5, dept_name='컴퓨터공학과', office='201호')를 추가하시오.
INSERT INTO department (dept_id, dept_name, office)
VALUE (5, '컴퓨터공학과', '201호');

-- 2-2 (5점)
-- 새로운 학생 (student_id=101, name='홍길동', grade=1, phone='010-9999-1111', dept_id=5)을 추가하시오.
INSERT INTO student (student_id, name, grade, phone, dept_id)
VALUE (101, '홍길동', 1, '010-9999-1111', 5);

-- 2-3 (5점)
-- 학생 101번이 과목 ‘Database’ 과목을 수강 등록하면서 점수 95점을 부여받았다고 가정하고 enroll 테이블에 입력하시오.
INSERT INTO enroll (student_id, subject, score)
VALUE (101, 'Database', 95);

-- 문제 3. 데이터 갱신 (UPDATE) — 15점
-- 3-1 (5점)
-- 학생 student_id=101의 학년을 2학년으로 변경하시오.
UPDATE student
SET grade = 2
WHERE student_id = 101;

-- 3-2 (5점)
-- department 테이블에서 컴퓨터공학과의 office를 305호로 변경하시오.
UPDATE department
SET office = '305호'
WHERE dept_name ='컴퓨터공학과';

-- 3-3 (5점)
-- enroll 테이블에서 ‘Database’ 과목 점수가 60점 미만인 학생은 모두 60점으로 수정하시오.
UPDATE enroll
SET score = 60
WHERE subject = 'Database' AND score < 60;


-- 문제 4. 데이터 삭제 (DELETE) — 10점
-- 4-1 (4점)
-- enroll 테이블에서 subject='Database'인 수강 내역을 모두 삭제하시오.
DELETE FROM enroll
WHERE subject = 'Database';

-- 4-2 (3점)
-- student_id=101인 학생의 데이터를 student 테이블에서 삭제하시오.
DELETE FROM student
WHERE student_id = 101;

-- 4-3 (3점)
-- department 테이블에서 dept_name='컴퓨터공학과' 학과를 삭제하시오.
DELETE FROM department
WHERE dept_name = '컴퓨터공학과';


-- 문제 5. 종합 응용 (JOIN + GROUP BY + 조건) — 10점
-- 5-1 (4점)
-- student와 enroll을 조인하여 학생별 평균 점수를 구하고, 평균 점수가 80점 이상인 학생의 학번과 평균 점수를 출력하시오.
SELECT S.student_id, AVG(E.score)
FROM student S
	LEFT JOIN enroll E
    ON S.student_id = E.student_id
GROUP BY
	S.student_id
HAVING
	AVG(E.score) >= 80;

-- 5-2 (3점)
-- department별 학생 수를 구하여 학과 이름과 학생 수를 출력하시오.
SELECT D.dept_name, COUNT(S.student_id)
FROM department D
	LEFT JOIN student S
    ON D.dept_id = S.dept_id
GROUP BY
	D.dept_name;

-- 5-3 (3점)
-- student와 department를 조인하여, dept_name='컴퓨터공학과'에 속한 모든 학생의 이름과 학년을 출력하시오.
SELECT S.name, S.grade
FROM department D
	LEFT JOIN student S
    ON D.dept_id = S.dept_id
WHERE
	dept_name = '컴퓨터공학과';