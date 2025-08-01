### k_정규화 >>> d_제3정규형 ###

## 제3정규화(3NF: Thid Normal Form) ###
# : 정규화의 세 번째 단계
# - 2NF(제2정규형)를 만족하는 테이블에서, 모든 비기본 속성이 기본키에만! 함수적으로 종속
#		> 이행적 종속을 제거

# cf) 이행적 종속성
# : 어떤 속성 A가 다른 속성 B에 종속되고
#		, B가 또 다른 속성 C에 종속된 경우
# >>> A가 C에 이행적으로 종속됨 ( A > B > C: A > C)

# 제3정규형의 핵심 조건
# : 이행적 종속성을 제거하는 것!

/*
	학번(1) / 이름(정은혜) / 학과ID(101) / 학과명(코리아) / 학과위치(부산)
    
    기본키(PK): 학번
    비기본 속성: 이름, 학과ID, 학과명, 학과 위치
    
    함수 종속 관계
    - 학번 > 학과 ID (학생은 특정 학과에 소속)
    - 학과 ID > 학과명, 학과 위치 (학과 ID로 학과 정보 확인)
    
    이행적 종속
    - 학번 > 학과ID > 학과명, 학과 위치

*/

# 제 3정규형 예시 #
drop database if exists `normal`;
create database if not exists `normal`;

use `normal`;

drop table department;
create table `department` (
	department_id int primary key,
    department_name varchar(100),
    location varchar(100)
);
drop table student;
create table `student` (
	student_id int primary key,
    name varchar(100),
    department_id int, -- 학과 id만 저장 (학과 정보 생략)
    foreign key (department_id) references department(department_id)
);

-- 정보 입력
insert into department
values
	(101, '컴공', '서울'),
	(102, '통계', '부산');
    
insert into student
values
	(1, '최광섭', 101),
	(2, '손태경', 101),
	(3, '박현우', 102);
    
# 학생 번호 > 걍의 ID
# 강의 ID > 강의 위치 (이행적 종속성 분리 - 구조화)
# : 학생의 정보와 강의 위치를 한 번에 파악 >> 조인(JOIN)

select * from department;
select * from student;

select
	S.student_id, S.name, D.department_name, D.location
from
	student S
    join department D
    on S.department_id = D.department_id;
    
### 제3정규화 장점 ###

### 제 3정규화 모범 사례 ###
# : 서로 다른 종류의 정보를 따로 담아야 안전
# - 무조건적인 정규화는 오히려 효율성 저하 (JOIN 증가)
# - 경우에 따라 반정규화(역정규화) 고려
# >> '기본적인 정규화 원칙' 이해 적용이 필수!






