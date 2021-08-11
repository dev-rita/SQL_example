--단일행 서브 쿼리문 실습을 위한 테이블 생성
create table dept15(
deptno number(10) primary key --부서번호
,dname varchar2(100) --부서명
);

insert into dept15 values(10,'관리부');
insert into dept15 values(20,'영업부');
insert into dept15 values(30,'연구부');

select * from dept15 order by deptno asc;

create table emp15(
 empno number(38) primary key --사원번호
 ,ename varchar2(20) --사원명
 ,job varchar2(50)--직종
 ,sal int--급여
 ,comm int--보너스
 ,deptno number(10)--부서번호
);

insert into emp15 values(21,'홍길동','관리사원',1500,0,10);
insert into emp15 values(22,'이순신','영업사원',1200,100,20);
insert into emp15 values(23,'강감찬','영업사원',1500,200,20);
insert into emp15 values(24,'신사임당','연구사원',3000,300,30);
insert into emp15 values(25,'세종대왕','연구사원',2500,250,30);

select * from emp15 order by empno; --오름차순 정렬 asc문은 생략

--단일행 서브쿼리문 실습
select dname from dept15 where deptno=(select deptno from emp15 where ename='홍길동');

--사원들의 급여 평균
select avg(sal) from emp15;

select ename,sal from emp15 where sal >1400;

--평균 급여보다 더 많은 급여를 받는 사원을 단일 행 서브 쿼리로 검색
select ename,sal from emp15 where sal >(select avg(sal) from emp15);

select distinct deptno from emp15 where sal >=1800; --distinct는 중복 부서번호를 제거

--서브쿼리의 검색 결과 레코드행이 복수개 이상일 때는 단일행 서브쿼리(=) 연산자를 사용할 수 없다.
select ename,sal,deptno from emp15 where deptno=(select distinct deptno from emp15 where sal>=1200);

-- =대신 in을 사용할 수 있다.
select ename,sal,deptno from emp15 where deptno in(select distinct deptno from emp15 where sal>=1200);
/*in 다중행 서브쿼리 연산자는 서브 쿼리문 검색 결과 값 중 하나라도 일치하면 참이 된다.*/

--20번 부서의 최대급여
select max(sal) from emp15 group by deptno having deptno=20;

--단일행 서브쿼리로 20번 부서의 최대 급여보다 큰 사원명과 급여, 부서번호를 구한다.
select ename,sal,deptno from emp15 where sal > (select max(sal) from emp15 group by deptno having deptno=20);

--20번 부서의 급여를 검색
select sal from emp15 where deptno=20;

/* >ALL 다중행 서브쿼리 연산자는 20번 부서의 급여중 최대 급여보다 크면  참이 되는 연산이다. 
 * (서브 쿼리의 최대급여인 1500보다 큰 데이터가 출력됨.)
 * 즉 20번 부서의 최대급여보다 큰 사원명, 급여, 부서번호를 검색
 */
select ename, sal, deptno from emp15 where sal>ALL (select sal from emp15 where deptno=20);

--20번 부서의 최소값
select min(sal) from emp15 group by deptno having deptno=20;

select ename,sal from emp15 where sal > (select min(sal) from emp15 group by deptno having deptno=20);

--20번 부서의 최소급여보다 큰 사원명과 급여를 검색
select ename,sal from emp15 where sal >ANY (select sal from emp15 where deptno=20);
/* >ANY 다중행 서브쿼리 연산자는 20번 부서의 급여중 최소값보다 크면 참이되는 연산이다. 
 * 즉 20번 부서의 최소 급여보다 큰 사원명과 급여를 검색한다.
 */
