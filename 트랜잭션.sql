--트랜잭션 실습을 위한 테이블 생성
create table dept51(
	deptno number(38) primary key --부서번호
	,dname varchar2(50) --부서명
);

insert into dept51 values(101,'영업부');
insert into dept51 values(102,'인사부');

select * from dept51 order by deptno asc;

--복제본 테이블 dept52 생성
create table dept52 as select * from dept51;

select * from dept52; --오토커밋이기 때문에 cmd에서 실습을 해야한다

--테이블 삭제후 rollback;을 입력하면 삭제 전으로 돌아갈 수 있다.
--삭제 후 commit;을 입력하면 rollback;을 입력해도 삭제 전으로 돌아갈 수 없다.
--savepoint 세이브명;으로 저장점을 생성할 수 있다. rollback to 세이브명;으로 해당 저장점으로 돌아갈 수 있다.

--복제본 테이블 dept53 생성
create table dept53 as select * from dept51;

select * from dept53 order by deptno asc;

insert into dept53 values(10,'경리부');
insert into dept53 values(20,'개발부');
insert into dept53 values(30,'총무부');
insert into dept53 values(40,'인사부');