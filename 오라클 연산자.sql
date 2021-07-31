/* 비교 연산자 종류)
	=(같다), >(~보다 크다), <(~보다 작다), >=(~보다 크거나 같다), <=(~보다 작거나 같다), 같지않다(<>,!=,^=)
*/

select *from emp01;

--11번 사원이 아닌 사원을 검색
select empno,ename from emp01 where empno^=11;
select empno,ename from emp01 where empno<>11;
select empno from emp01 where empno!=11;

/*SQL문은 영문 대소문자를 구분하지 않지만, 테이블 컬럼에 저장된 영문 레코드값은 대소문자를 구분한다.*/

/* 논리연산자 종류)
 * AND:두가지 조건 모두 만족해야 검색됨
 * OR:두가지 조건중에 한가지만 만족하면 검색
 * NOT:조건에 만족하지 못하는 것만 검색
 */

--부서번호가 10이고 사원이름이 홍길동인 경우
select * from emp01 where deptno=10 and ename='홍길동';

--부서번호가 10이거나 사원번호가 13이면 검색
select * from emp01 where deptno=10 or empno=13;

--부서번호가 10이 아닌 자료를 검색
select * from emp01 where not deptno=10;

--급여가 1000이상 1100이하인 자료를 검색
select * from emp01 where sal>=1000 and sal<=1100;

--보너스가 100이거나 110이거나 null인 경우 자료를 검색. null은 is null로 검색한다.
select * from emp01 where comn=100 or comn=110 or comn is null;

/* BETWEEN A AND B연산  : 오라클에서 특정 범위의 값을 조회하기 위해서 사용되는 연산자이다.
 * A에는 범위내의 최소값을 B에는 범위내의 최대값을 기술한다.
 */
select * from emp01 where sal>=1000 and sal<=2000;
--급여가 1000에서 2000사이 자료가 검색됨. 이 조건연산을 between a and b로 변경 가능하다
select * from emp01 where sal between 1000 and 2000;

/*in 연산자는 특정 컬럼의 값이 여러 개의 값 중에서 하나인지를 물어 보아야 하는 경우 사용되는 연산자가 in 연산자이다.
  in 연산자 사용형식)
    컬럼명 in(A,B,C) -> 특정 컬럼의 값이 A,B,C중 어느 하나만 만족하더라도 자료가 검색된다.
*/
select * from emp01 where empno in(11,12,13);--사원번호가 11, 12, 13이면 검색

--like 검색 연산자를 위한 테이블 생성
create table emp7(
empno number(38) --사원번호
,ename varchar2(30)--사원명
,job varchar2(50) --직무 부서
,sal int --급여
,comm int --보너스
);

insert into emp7 values(7310,'smith','saleman',1000,100);
insert into emp7 (empno,ename,job,sal) values(7311,'king','manager',2000);
insert into emp7 values(7312,'clerk','salesman',1500,150);

--사원명이 s로 시작되는 사원을 검색
select * from emp7 where ename like 's%';

--사원명에서 i만 포함되어져 있어도 검색
select * from emp7 where ename like '%i%';

--사원명에서 두번째 글자가 m이고 그 뒤는 무엇이든 상관없는 사원을 검색
select * from emp7 where ename like '_m%';

--사원명에서 세번째 글자가 e이고 그 뒤는 무엇이든 상관없는 사원을 검색
select * from emp7 where ename like '__e%';

select * from emp7;

select * from emp7 where comm=null;-- =로 보너스가 null인 사원을 검색하면 해당 자료를 찾지 못한다.
select * from emp7 where comm is null;-- 보너스가 null인 사원 검색
select * from emp7 where comm is not null;-- 보너스가 null이 아닌 사원 검색

/* 오름차순 정렬)
 * 1. 숫자는 작은 숫자부터 먼저 정렬
 * 2. 한글은 가나다 순으로 정렬
 * 3. 영어는 알파벳 순으로 정렬
 * 4. 날짜는 빠른 날짜 순으로 정렬
 */

--급여를 기준으로 오름차순 정렬, asc문은 생략 가능(defalut)
select * from emp7 order by sal asc;

/* 내림차순 정렬)
 * 1. 숫자는 큰숫자 부터 정렬
 * 2. 한글은 가나다 역순으로 정렬
 * 3. 영어는 알파벳 역순으로 정렬
 * 4. 날짜는 늦은 날짜 순으로 정렬
 */
--급여를 기준으로 내림차순 정렬, desc문은 생략 불가
select * from emp7 order by sal desc;