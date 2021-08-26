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

--외래키가 있는 사원 테이블 생성
create table emp71(
	empno number(38) constraint emp71_empno_pk primary key--사원번호
	,ename varchar2(50) constraint emp71_ename_nn not null --사원이름
	,job varchar2(100) --직종
	,deptno number(38) constraint emp71_deptno_fk references dept71(deptno) --외래키 정의
);

insert into emp71 values(11,'홍길동','관리사원',10);
insert into emp71 values(12,'이순신','영업사원',20);

select * from emp71 order by empno asc;

insert into emp71 values(13,'강감찬','경리원',50); --부모키의 없는 부서번호를 저장하려다가 참조 무결성 제약조건 에러가 발생한다.

--생성된 테이블의 제약조건 타입, 이름등을 확인
select table_name,constraint_type,constraint_name,r_constraint_name from user_constraints
where table_name in('DEPT71','EMP71');

--r_constraint_name 컬럼에는 외래키가 어느 기본키를 참조하고 있는지에 대한 정보를 담고 있다. 테이블명은 영문 대문자로 해야함

--ANSI 미국 표준 협회 Inner Join실습)
select * from dept71 inner join emp71 on dept71.deptno = emp71.deptno;

--기본키가 있는 학과 테이블 생성
create table depart71(
	deptcode varchar2(6) constraint depart71_deptcode_pk primary key--학과 코드
	,deptname varchar2(50) constraint depart71_deptnae_nn not null --학과이름
);

insert into depart71 values('a001','영어교육학과');
insert into depart71 values('a002','수학교육학과');

select * from depart71 order by deptcode asc; --asc문은 생략 가능

--외래키가 있는 학생테이블 생성
create table student71(
	sno number(38) constraint student71_sno_pk primary key --학번
	,sname varchar2(50) constraint student71_sname_nn not null --학생이름
);