set serveroutput on

declare
--테이블의 여러개의 컬럼 한행의 레코드 값을 저장할 때 레코드 타입 변수를 사용한다.
type emp_record_type is record(
    v_empno emp.empno%type,
    v_ename emp.ename%type,
    v_job emp.job%type,
    v_deptno emp.deptno%type
);

--레코드 타입 변수 정의
emp_record emp_record_type;

begin
--강감찬 사원정보를 레코드 타입 변수에 저장
select empno,ename,job,deptno into emp_record from emp where ename='강감찬';

--레코드 변수에 저장된 값을 출력 emp_record.v 는 emp_record의 변수를 뜻함

DBMS_OUTPUT.PUT_LINE('사원번호:' || emp_record.v_empno);
DBMS_OUTPUT.PUT_LINE('사원명:' || emp_record.v_ename);
DBMS_OUTPUT.PUT_LINE('직종:' || emp_record.v_job);
DBMS_OUTPUT.PUT_LINE('부서번호:' || emp_record.v_deptno);

end;
/