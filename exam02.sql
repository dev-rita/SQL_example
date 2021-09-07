set serveroutput on

declare
 vempno emp.empno%type;  --vempno변수는 emp테이블의 empno 컬럼 자료형 타입을 따라간다.
 vename emp.ename%type;
 vsal emp.sal%type;

begin 
 DBMS_OUTPUT.PUT_LINE('사번 / 사원명 / 급여');
 dbms_output.put_line('--------------------------------------------');

 select empno,ename,sal into vempno,vename,vsal --각 컬럼 레코드 값을 가져와서(into) vempno,vename,vsal 매개변수에 저장
 from emp where ename='홍길동';

   --각 변수에 저장된 값을 출력 
  DBMS_OUTPUT.PUT_LINE(vempno || '/' || vename || '/' || vsal);  

end;
/