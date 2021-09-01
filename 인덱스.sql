--기본키로 된 컬럼에 생성된 인덱스 확인
create table emp201(
	empno int primary key
	,ename varchar2(50)
	,sal number(38)
);

insert into emp201 values(11,'홍길동',100);

select * from emp201;

--복사본 테이블 EMP202를 생성
create table emp202 as select * from emp201;

--생성된 인덱스명 확인
select table_name,index_name,column_name from user_ind_columns
where table_name in('EMP201','EMP202');
--서브쿼리로 복제된 emp202 테이블에는 인덱스가 없다. 기본키 제약조건은 복제되지 않기 때문이다.