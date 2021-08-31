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

--삭제할 del_view 가상테이블 생성
create view DEL_VIEW as select empno,ename from emp86;

select * from del_view;

--생성된 뷰 이름을 확인
select view_name from user_views;

--DEL_VIEW 가상테이블 삭제
DROP VIEW DEL_VIEW;

--re_view 가상 테이블 생성
create view re_view as select empno,ename from emp86;

select * from re_view;

--or replace 옵션으로 기존 뷰를 수정
create or replace view re_view
as select empno,ename,sal from emp86;

--force 옵션으로 기존테이블이 없어도 가상테이블 뷰를 생성
select * from abc;

create or replace force view for_view
as select empno,ename from abc;

--조건 제시된 20번 부서번호를 수정 못하게 한다.
select * from emp86;
create or replace view view_check as select empno,ename,deptno from emp86 where deptno=20 with check option;

update view_check set deptno=10 where empno=103;

--with read only 옵션 
create or replace view only_view
as
select empno,ename,sal,comm,deptno from emp86 where deptno=20 with read only;

select * from only_view;

--뷰를 통해서 부서번호 20번의 보너스를 수정 > 읽기전용 뷰를 통해서 수정작업 불가
update only_view set comm=100 where deptno=20;

--rownum컬럼 실습을 위한 테이블 생성
create table emp92(
	empno number(38) primary key
	,ename varchar2(50)
	,sal int
);

insert into emp92 values(1,'홍길동',1000);
insert into emp92 values(2,'이순신',2000);
insert into emp92 values(3,'강감찬',3000);

select rownum,empno,ename,sal from emp92 order by empno asc;
select rownum,empno,ename,sal from emp92 order by empno desc;

--뷰생성
create or replace view row_view
as select empno,ename,sal from emp92 order by empno desc;

select rownum,empno,ename,sal from row_view;

--가장 최근에 입사한 사원을 뷰를 통해서 구함
select rownum,empno,ename,sal from row_view where rownum <=1;

--가장 최근에 입사한 사원을 인라인 뷰 서브쿼리문으로 구함
select rownum,empno,ename,sal from (select empno,ename,sal from emp92 order by empno desc) where rownum <=1;