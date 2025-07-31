### h_트리거 >>> trigger_practice ###

-- 	문제1
-- 	선수(players)가 삭제될 때, 
-- 	해당 선수의 이름과 삭제 시각을 player_delete_logs 테이블에 기록하는 트리거를 생성
--     
-- 	>> 로그 테이블이 없으면 먼저 생성하고, 트리거명: after_player_delete
use baseball_league;
select * from players;

create table player_delete_logs (
	name varchar(8),
	deleteDate date
);

drop trigger if exists after_player_delete;

delimiter $$
create trigger after_player_delete
	after delete
    on players
    for each row
begin
	insert into player_delete_logs
    value (
		OLD.name, curdate()
    );
end $$

delimiter ;

select * from players;
delete from players
where name = 'LDK';
select * from player_delete_logs;

-- 	문제2
-- 	선수(players)의 포지션(position)이 변경될 경우
-- 		, 이전 포지션과 변경된 포지션, 선수 이름을 player_position_logs에 기록하는 트리거를 생성
-- 	
--     >> 로그 테이블이 없으면 먼저 생성하고,트리거명: after_player_position_update

create table player_position_logs (
	position varchar(8),
	newPosition varchar(8),
	name varchar(8)
);

drop trigger if exists after_player_position_update;

delimiter $$
create trigger after_player_position_update
	after update
    on players
    for each row
begin
	insert into player_position_logs
    values (
		OLD.position, NEW.position, OLD.name
    );
end $$

delimiter ;

select * from players;
update players
set position = '투수'
where name = 'LSA';
select * from player_position_logs;
-- 문제3
-- 	선수가 추가되거나 삭제될 때마다 해당 팀의 선수 수(player_count)를 자동으로 업데이트하는 트리거 2개	
--     (after_player_insert_count, after_player_delete_count)
--     >> ※ teams 테이블에 player_count 컬럼이 이미 존재한다고 가정함
--     ALTER TABLE teams ADD COLUMN player_count INT DEFAULT 0;
ALTER TABLE teams ADD COLUMN player_count INT DEFAULT 0;

drop trigger if exists after_player_insert_count;
delimiter $$
create trigger after_player_insert_count
	after update
    on teams
    for each row
begin
    UPDATE team
    SET player_count = player_count + 1
    WHERE team_id = NEW.team_id;
end $$
delimiter ;

drop trigger if exists after_player_delete_count;
delimiter $$
create trigger after_player_delete_count
	after update
    on teams
    for each row
begin
	update teams
    set player_count = player_count + 1
    WHERE team_id = OLD.team_id;
end $$
delimiter ;

select * from teams;
delete from players
where name = 'LDK';
select * from player_delete_logs;








