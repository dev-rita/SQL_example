/* DDL 데이터 정의어 종류)
 * create(데이터 베이스 생성문), alter(테이블 수정문), 
 * drop(데이터 베이스 삭제문, 테이블 명 변경문), truncate(데이터 베이스 저장공간 삭제문, 테이블 전체 자료 삭제문)
 */
--dept01 테이블 생성
create table dept01(
	deptno number(4)--부서번호
	,dname varchar2(100)--부서명
	,LOC varchar2(100)--지역
);

--dept01 테이블의 dname 컬럼 자료형 크기를 변경
alter table dept01 modify(dname varchar2(300));--dname 컬럼 크기를 100에서 300으로 변경

--테이블 구조 확인
desc dept01;--이클립스에서는 실행이 되지 않음(cmd에서 실행 가능)
describe dept01;--이클립스에서 실행이 되지 않음(cmd에서 실행 가능)

--rename으로 테이블 명 변경
rename dept01 to dept02; --dept01테이블명에서 dept02 테이블명으로 변경

--night사용자가 소유하고 있는 테이블 정보를 확인
select * from tab; --tab는 table의 약자이다.

/*DML 데이터 조작어 : INSERT(자료 저장문), UPDATE(자료 수정문), DELETE(자료 삭제문),  
 */ 
 insert into dept02 values(10,'총무부','서울');
 insert into dept02 (deptno,dname,LOC) values(20,'개발부','판교');
 
 --자료 검색문
 select * from emp01;
 
 --자료 수정문
 update dept02 set dname='영업부' where deptno=10;
 
 --자료 삭제문
 delete from dept02 where deptno=10; --10번 부서번호 레코드 삭제
 
 --DDL의 truncate문으로 전체 자료 삭제(잘 안쓰임)
 truncate table dept02;
 
 --DDL의 drop문으로 테이블 삭제 >>테이블 구조 삭제
 drop table dept02;
 
 /*오라클 산술연산자 종류)
  * +(덧셈), -(뺄셈), *(곱셈), /(나눗셈)
  */
 select 100*12 from dual;--dual 테이블은 오라클 설치시 설치되는 임시 테이블로 시퀀스 번호값, 연산 결과값, 오라클 함수 값 확인 용도로 활용됨.
 
 --emp01 테이블 생성
 create table emp01(
 empno number(38)--사원번호
 ,ename varchar2(20)--사원명
 ,sal int--월급
 ,comn int--보너스
 ,deptno int--부서번호
 );
 
 insert into emp01 values(11,'홍길동',1000,100,10);
 insert into emp01 values(12,'이순신',1100,110,10);
 insert into emp01 (empno,ename,sal,deptno) values(13,'ㅠㅠㅠ',1000,20);
 
 select * from emp01 order by empno asc;--사원번호를 기준으로 오름차순 정렬, asc문은 생략 가능
 
 --보너스를 뺀 연봉
 select ename, sal, sal*12 from emp01;
 --보너스가 포함된 연봉
 select ename, sal, comn, sal*12+comn from emp01;--ㅠㅠㅠ는 보너스가 null이어서 연봉도 null로 나온다.
 --nvl()함수로 null을 0으로 변경한 다음 연봉을 계산
 select ename, sal, comn, nvl(comn,0),sal*12+nvl(comn,0) from emp01;
 
 --as문으로 출력 레코드 컬럼 별칭이름을 지정. 원래 컬럼명 즉 필드명은 변경되지 않는다.
 select ename, sal,nvl(comn,0), sal*12+nvl(comn,0) as 연봉 from emp01;
 
 select deptno from emp01;
 
 --distinct 키워드로 중복자료에 대해서 중복을 제거하고 한 번만 출력
 select distinct deptno from emp01;
 
 