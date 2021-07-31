select 12*60 from dual; --dual 테이블은 오라클 설치시 설치되는 임시 테이블로 오라클 연산, 함수, 시퀀스 값등 확인 용도로 사용됨.

select sysdate from dual; --sysdate 오라클 날짜함수는 시간과 날짜값 확인가능.

select -10, abs(-10) from dual;

select 34.5678, Floor(34.5678) from dual; --floor()함수는 소수점 이하를 버린다.

select 34.5678, round(34.5678,2) from dual; --round(,2)함수는 소수점 셋째 자리에서 반올림해 소수점 둘째 자리까지 구한다.

select trunc(34.5678,2) from dual; --trunc(34.5678,2)는 소수점 이하 세번째 자리에서 버림연산을 한다.

select mod(27,2), mod(27,5), mod(27,7) from dual; --mod함수는 나머지를 구함.

select 'Welcome to Oracle', upper('Welcome to Oracle') from dual; --upper()함수는 영문 대문자로 변경.

select 'Welcome to Oracle', lower('Welcome to Oracle') from dual; --lower()함수는 영문 소문자로 변경.

select LTrim(' Oracle ')from dual;--LTrim()함수는 왼쪽 공백을 제거

select rTrim(' Oracle ')from dual;--rTrim()함수는 오른쪽 공백을 제거

select trim(' Oracle ')from dual;--trim()함수는 양쪽 공백을 제거

select sysdate from dual; --sysdate는 날짜와 시간을 확인가능한 함수

/* 형변환 함수 종류)
 * 1.to_char : 날짜형 혹은 숫자형을 문자형으로 변환
 * 2.to_Date : 문자형을 날짜형으로 변환
 * 3.to_number : 문자형을 숫자형으로 변환
 */

select * from emp01;

select ename, sal, comn, sal*12+comn from emp01;--sal*12+comm에서 comm컬럼 보너스가 null이면 제대로 된 연봉 계산을 못한다.

select ename, sal, comn, nvl(comn,0), sal*12+nvl(comn,0) from emp01;--nvl(comn,0)는 null이 아니면 comn, null면 0으로 바꿔준다.

drop table emp01;--emp01 테이블 삭제

--switch ~case 문과 같은 기능을 하는 decode 함수를 위한 테이블을 생성
create table emp01(
	deptno number(38)--부서번호
	,ename varchar2(30)--사원명
);

insert into emp01 values(10,'Miller');
insert into emp01 values(20,'Smith');
insert into emp01 values(20,'Jones');
insert into emp01 values(30,'Allen');

select * from emp01 order by deptno asc;

--decode함수 실습
select ename,deptno,decode(deptno,10,'ACCOUNTING',
								  20,'RESEARCH',
								  30,'SALES')
								  AS DNAME
FROM emp01;

--if / else if/ else문과 같은 같은 기능을 하는 CASE 함수 실습
select ename,deptno,
		case when deptno=10 then 'ACCOUNTING'
		     when deptno=20 then 'RESEARCH'
		     when deptno=30 then 'SALES'
		     END AS DNAME
from emp01;

--그룹함수를 위한 테이블 삽입
create table emp02(
dept_no number(38)--부서번호
,ename varchar2(20)--사원명
,sal int--급여
,comm int--보너스
,job varchar2(50)--업무부서
);

insert into emp02 values(10,'Scott',1000,100,'salesman');
insert into emp02 values(10,'Tiger',1500,150,'salesman');
insert into emp02 values(10,'Hover',1500,150,'salesman');
insert into emp02 values(10,'Amy',2500,150,'salesman');
insert into emp02 values(10,'Betty',2000,250,'salesman');
insert into emp02 (dept_no,ename,sal,job) values(20,'James',2000,'manager');
insert into emp02 (dept_no,ename,sal,job) values(20,'King',2500,'manager');

select * from emp02 order by dept_no asc,sal asc;

--전체 사원의 총 급여 합
select sum(sal) from emp02;

select sum(comm) from emp02;--그룹함수를 사용하면 보너스 컬럼에서 다른 연산과는 달리 NULL을 제외하고 보너스 총합을 구한다.

--사원들의 급여 평균
select avg(sal) from emp02;

--급여의 최대,최소값을 구함
select max(sal), min(sal) from emp02;

--보너스를 받는 사원수, 결국 null을 제외한다.
select count(comm) from emp02;

--전체 사원수
select count(*) from emp02;

--중복이 포함된 직업의 개수
select count(job) from emp02;

--중복을 제거한 직업의 개수
select count(distinct job) from emp02;

--부서별 급여 평균
select dept_no, avg(sal) from emp02 group by dept_no;

--부서별 급여 총합과 평균
select dept_no,sum(sal),avg(sal) from emp02 group by dept_no;

--부서별 최대급여와 최소 급여
select dept_no, max(sal), min(sal) from emp02 group by dept_no;

--부서별 사원수와 보너스를 받는 사원수
select dept_no, count(*), count(comm) from emp02 group by dept_no;

--부서별 평균 급여
select dept_no, avg(sal) from emp02 group by dept_no;

--부서별 평균 급여가 2000이상인 경우 부서번호, 부서별 평균 급여
select dept_no,avg(sal) from emp02 group by dept_no having avg(sal)>=2000;

--부서별 최대 급여가 2000을 초과한 경우에 맞는 부서별 번호, 부서별 최대값, 최소값 급여
select dept_no, max(sal), min(sal) from emp02 group by dept_no having max(sal)>2000;