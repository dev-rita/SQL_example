--미국 표준협회에서 제시한 ANSI 조인을 위한 테이블 생성
create table depart11(--학과 테이블 생성
 dept_code varchar2(20) primary key --강의실 호수, primary key 제약조건은 해당 컬럼에 중복값 저장 금지, null 저장금지
 ,dept_name varchar2(30) not null --강의실 담당 선생님. not null 제약조건은 null 저장 금지
);

insert into depart11 values('601','신사임당샘');
insert into depart11 values('602','이순신샘');

select * from depart11 order by dept_code;

--학생테이블 생성
create table student11(
	st_no number(38) primary key --학번
	,st_name varchar2(20) --학생명
	,st_gender varchar2(10)--성별
	,dept_code varchar2(20)--강의실 호수
);

insert into student11 values(11,'홍길동','남','601');
insert into student11 values(12,'홍길순','여','602');
insert into student11 values(13,'강감찬','남','602');

select * from student11 order by st_no asc;

--ANSI coross join
select * from depart11 cross join student11;

--on절 조건문을 사용한 ANSI inner join
select * from depart11 inner join student11 on depart11.dept_code=student11.dept_code;

--강감찬 학생을 검색하는 ANSI inner join
select st_no,st_name,st_gender,depart11.dept_code,dept_name from depart11 inner join student11 
on depart11.dept_code=student11.dept_code and st_name='강감찬';

--using 절문을 사용한 inner join 
select st_no,st_name,st_gender,dept_code,dept_name from depart11 inner join student11 using (dept_code);

--natural join 조건절 생략하고 자동적으로 공통 컬럼 조사해서 조인(공통컬럼을 만들어 줘야 사용 가능)
select * from depart11 natural join student11;

--outer join을 위한 테이블 생성
create table dept21(
	deptno number(20) primary key --부서번호
	,dname varchar2(50) --부서명
);

insert into dept21 values (10,'ACCOUNTING');
insert into dept21 values(20,'RESEARCH');

select * from dept21 order by deptno asc;

--dept22 테이블 생성
create table dept22(
	deptno number(20) primary key
	,dname varchar2(50)
);

insert into dept22 values(10,'ACCOUNTING');
insert into dept22 values(30,'SALES');

--LEFT OUTER JOIN
select * from dept21 left outer join dept22 on dept21.deptno=dept22.deptno;
--dept21테이블에는 자료가 있지만 dept22테이블에는 레코드가 없는 경우 왼쪽을 기준으로 left outer join이 된다.

select * from dept21 right outer join dept22 using(deptno);
--두 테이블간 조인 조건에 사용되는 컬럼명이 같다면 on문 대신 using절문을 사용할 수 있다. 이런 경우는 컬럼명만 명시한다.
--dept21 테이블에 해당 자료가 없는 경우 오른쪽을 기준으로 해서 자료가 출력되지 않는 점을 해결하기 위한 조인 기법이다.

--full outer join=left outer join+right outer join
select * from dept21 full outer join dept22 using(deptno);
select * from dept21 cross join dept22;