--서브쿼리문으로 원본 테이블 구조와 레코드를 복제한 테이블을 생성 =>emp16 복제본 테이블을 생성
create table emp16 as select * from emp15;--안만듬

select * from emp16;

select * from emp17;
select * from emp15;

--emp15 원본 테이블의 필요한 컬럼과 레코드만 복제한 emp17 테이블을 생성
create table emp17 as select empno, ename, sal, deptno from emp15;

--10번 부서 레코드 행만 복제
create table emp18 as select * from emp15 where deptno=10;

select * from emp18;

--조건식을 거짓으로 해서  테이블 구조 즉 컬럼만 복제하고 레코드는 복제하지 않는다.
create table emp19 as select * from emp15 where 10=0;

select * from emp19; --컬럼만 복제됨 (빈 테이블)

--테이블 구조 변경 실습을 위한 테이블을 생성
create table emp21(
	empno number(38) primary key
	,ename varchar2(50)
	,sal int
);

select * from emp21;

--job 필드 추가
alter table emp21 add(job varchar2(50));

--job 컬럼 자료형 크기 50을 30으로 변경
alter table emp21 modify(job varchar2(30));

--job 컬럼을 삭제
alter table emp21 drop column job;

--truncate 문에 의해서 모든 레코드 행을 삭제하기 위한 실습을 위해서 2개 레코드를 저장
insert into emp21 values(11,'홍길동',1000);
insert into emp21 values(12,'이순신',1200);

--모든 레코드 삭제 (테이블은 남음)
truncate table emp21; --많이 사용안됨

--emp21 테이블 명을 test테이블 명으로 변경
rename emp21 to test2;

select * from emp21;
select * from test2;

--test 테이블 삭제하면 구조 컬럼뿐만 아니라 레코드 등 모든것이 삭제
drop table test2;

--현재 접속중인 사용자로 사용할 수 있는 테이블명을 알고자 할 때
select table_name from user_tables order by table_name desc;