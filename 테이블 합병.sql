--테이블 합병을 위한 원본 테이블 emp생성
create table emp(
	empno number(38) primary key
	,ename varchar2(50)
	,job varchar2(50)
	,sal int
	,deptno int
);

insert into emp values(101,'홍길동','개발부',5000,10);
insert into emp values(102,'이순신','개발부',5000,10);
insert into emp values(103,'강감찬','디자인부',3000,20);

select * from emp order by empno asc;

--emp01 복사본 테이블 생성
create table emp1 as select * from emp;

--개발부만 복제
create table emp2 as select * from emp where job='개발부';

update emp2 set job='test';
insert into emp2 values(104,'을지문덕','top',2000,30);

select * from emp2;

--테이블 병합
emerge into emp1
using emp2
on(emp1.empno = emp2.empno)
when matched then
update set
	emp1.ename=emp2.ename,
	emp1.job=emp2.job,
	emp1.sal=emp2.sal,
	emp1.deptno=emp02.deptno
	
when not matched then
insert values(emp2.empno,emp2.ename,emp2.job,emp02.sal,emp2.deptno);