--가상테이블 뷰 실습을 위한 원본테이블 생성
create table emp_copy(
	empno int primary key
	,ename varchar2(50)
	,job varchar2(50)
	,sal number(38)
	,comm number(38)--보너스
	,deptno number(38)
);

insert into emp_copy values(201,'홍길동','관리사원',100,10,101);
insert into emp_copy values(202,'이순신','개발사원',200,20,102);

select * from emp_copy;

--emp_view30 가상테이블 생성 (>뷰 생성 권한이 없다 error) system 으로 cmd 로그인하고
--grant create view to night; 로 권한을 부여한다.
create view emp_view30
as 
select empno, ename, deptno from emp_copy where deptno=101;

--뷰를 통해 실제 테이블 레코드 검색
select * from emp_view30;

--생성된 뷰 이름과 서브쿼리문을 확인
select view_name, text from user_views;

--뷰를 통해 레코드 저장 >> 실제 테이블에 저장됨
insert into emp_view30 values(203,'신사임당님',102);

--가상테이블 뷰를 사용하는 이유에 대한 실습
--기본키가 있는 부모테이블 dept86 생성
create table dept86(
	deptno number(38) constraint dept86_deptno_pk primary key 
	,dname varchar2(50) constraint dept86_dname_nn not null --부서명
	,LOC varchar2(50) --부서지역
);

insert into dept86 values(10,'영업부','서울');
insert into dept86 values(20,'인사부','인천 송도');

--외래키가 있는 종속테이블 생성
create table emp86(
	empno number(38) constraint emp86_empno_pk primary key --사원번호
	,ename varchar2(50) constraint emp86_ename_nn not null --사원명
	,sal number(38)
	,job varchar2(20)
	,comm int -- 보너스
	,deptno number(38) constraint emp86_deptno_fk references dept86(deptno) --외래키 설정
);

insert into emp86 values(101,'이순신',3000,'영업사원',300,10);
insert into emp86 values(102,'강감찬',6000,'영업과장',600,10);
insert into emp86 values(103,'신사임당',6000,'인사과장',0,20);

--조인검색
select empno,ename,job,sal,comm,d.deptno,dname from dept86 d, emp86 e
where d.deptno = e.deptno and e.deptno=10
order by empno asc;

--복잡한 쿼리문을 뷰를 통해 단순화
create view join_view
as
select empno,ename,job,sal,comm,d.deptno,dname from dept86 d, emp86 e
where d.deptno = e.deptno and e.deptno=10
order by empno asc;

select * from join_view;
