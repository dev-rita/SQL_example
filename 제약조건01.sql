--기본키와 not null 제약조건 실습을 위한 테이블을 생성
create table dept60(
	deptno number(38) primary key --부서번호
	,dname varchar2(30) not null --부서명
	,LOC varchar2(50) --지역
);

insert into dept60 values(10,'영업부','서울');
insert into dept60 values(10,'영업부','부산');
--deptno컬럼은 기본키 즉 primary key로 설정되었기 때문에 중복 부서번호는 저장할 수 없다.

insert into dept60 values(20,null,'서울');
--dname컬럼은 not null 제약조건이기 때문에 null을 저장할 수 없다.

select * from dept60;

select constraint_name, constraint_type, table_name from user_constraints where table_name in('DEPT60');
--DEPT60테이블의 제약조건명, 제약조건타입등을 확인 가능하다.

--not null 제약조건 실습을 위한 테이블 생성
create table emp101(
	empno number(38)
	,ename varchar2(50) --사원명, null제약조건
	,job varchar2(20) --직종
	,deptno number(38) --부서번호
);

insert into emp101 values(null,null,'영업부',20);

select * from emp101;

create table emp102(
	empno number(38) not null
	,ename varchar2(50) not null
	,job varchar2(50)	
	,deptno number(38)
);

insert into emp102 values(null,null,'관리부',10);
insert into emp102 values(501,'이순신','관리부',10);

select * from emp102;

--unique 제약조건 실습을 위한 테이블 생성
create table emp103(
	empno number(38) unique
	,ename varchar2(50) not null
	,job varchar2(30)
	,deptno number(38)
);

insert into emp103 values(502,'홍길동','인사부',40);
insert into emp103 values(502,'이신수','개발부',10);
--사원번호는 unique제약조건이기 때문에  중복 사원번호는 저장 못함.

insert into emp103 values(null,'강감찬','관리부',50);
insert into emp103 values(null,'신사임당님','개발부',10);--unique제약조건은 null저장을 허용하고 중복저장도 허용한다.

select * from emp103;

--constraint 키워드로 사용자 정의 제약조건명 만들기 실습
create table emp105(
	empno number(38) constraint emp105_empno_pk primary key
	,ename varchar2(100) constraint emp105_ename_nn not null
	,job varchar2(50)
	,deptno int
);

--생성된 테이블 제약조건명 확인
select table_name, constraint_name from user_constraints where table_name in('EMP105');

--중복사원번호 저장
insert into emp105 values(101,'james','sales',10);
insert into emp105 values(101,'smith','management',20);

insert into emp105 values(null,'jones','sales',10);--기본 컬럼에 null 저장금지

--외래키(foreign key) 제약조건 실습을 위한 테이블 생성
create table dept71(
	deptno number(38) constraint dept71_deptno_pk primary key --부서번호
	,dname varchar2(100) constraint dept71_dname_nn not null --부서명
	,LOC varchar2(50) --부서지역
);

insert into dept71 values(10,'관리부','서울');
insert into dept71 values(20,'영업부','부산');
insert into dept71 values(30,'개발부','판교');

select * from dept71 order by deptno asc;