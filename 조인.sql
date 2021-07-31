--조인 실습을 위한 테이블 생성
create table dept05(
	deptno number(38) primary key --부서번호, primary key제약조건은 중복 부서번호 저장 금지, 빈 값 즉 null 저장 금지
	,dname varchar2(100) --부서명
);

insert into dept05 values(10,'관리부');
insert into dept05 values(20,'영업부');
insert into dept05 values(30,'연구부');

select * from dept05 order by deptno asc;

--사원 테이블 생성
create table emp05(
	empno number(38) primary key --사원번호
	,ename varchar2(20)--사원명
	,job varchar2(20)--직종
	,sal number(38)--급여
	,comm int--보너스
	,deptno number(38)--부서번호
);

insert into emp05 values(7001,'홍길동','관리사원',1500,0,10);
insert into emp05 values(7002,'이순신','영업사원',1200,100,20);
insert into emp05 values(7003,'강감찬','영업사원',1300,130,20);
insert into emp05 values(7004, '홍길순','연구원',2000,20,30);

select * from emp05 order by deptno asc;

--cross join
select * from dept05, emp05;

--강의실 호수와 강의실 담당샘
create table room(
	roomno int primary key --강의실 호수
	,roomname varchar2(100) --강의실 담당 선생님
);

insert into room values(601,'홍길동 샘');
insert into room values(602,'이순신 샘');

select * from room order by roomno asc;

create table st03(
	stno number(38) primary key --학번
	,stname varchar2(20)--학생명
	,roomno int--강의실 호수
);

insert into st03 values(1,'홍길순 학생',601);
insert into st03 values(2,'강감찬 학생',602);
insert into st03 values(3,'신사임당 학생',602);

select *n from st03 order by stno asc;

--cross join
select * from room,st03;

--Equi 조인 검색
select * from room,st03 where room.roomno = st03.roomno;

--신사임당 학생 Equi 조인 검색
select stno,stname,room.roomno,roomname from room,st03 where room.roomno=st03.roomno and stname='신사임당 학생';

--학생이름에서 길만 알고 있을 경우 Equi 조인 검색
select stno, stname, room.roomno,roomname from room,st03 where room.roomno=st03.roomno and stname like '%길%';
/* 1.like 검색 연산자는 정확한 값을 모를 경우 사용한다.
 * 2.%와일드 카드는 하나이상의 임의의 모르는 문자와 매핑 대응한다.
 */

--테이블에 별칭을 주고 EQUI 조인검색/ 신으로 시작되는 학생의 EQUI 조인 검색
select stno,stname,r.roomno,roomname from room r,st03 s where r.roomno=s.roomno and s.stname like '신%';

--Non Equi 조인 검색을 위한 salgrade테이블을 생성
create table salgrade(
	grade number(38) primary key --급여등급
	,LOSAL number(38) --최소급여
	,HISAL number(38) --최대 급여
);

insert into salgrade values(1,700,1200);
insert into salgrade values(2,1201,1400);
insert into salgrade values(3,1401,2000);

drop table salgrade;

select * from salgrade order by grade; --asc문이 생략된 오름차순 정렬

--Non EQUI 조인 검색
select ename,sal,grade from emp05,salgrade where sal between LOSAL AND HISAL;

select e.ename, e.sal, s.grade from emp05 e,salgrade s where e.sal >= s.LOSAL and e.sal<=s.HISAL;

--사원테이블과 부서테이블은 EQUI JOIN+ 급여등급 테이블과는 NON EQUI 조인검색을 통한 3개 테이블 조인 검색
select e.ename,e.sal,s.grade,d.dname from emp05 e, salgrade s, dept05 d where e.deptno = d.deptno and e.sal between s.LOSAL and s.HISAL;