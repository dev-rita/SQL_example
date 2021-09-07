set serveroutput on
 --오라클 환경변수로서  오라클에서 제공하는 프로시저를 사용하여  출력하는 내용을 화면에 보여주도록 설정하는 환경변수이다.

declare
  vempno number(38); --변수명 자료형(크기)로 선언
  vename varchar2(50);

begin
  vempno := 77; -- :=은 PL-SQL문에서 대입연산자이다.
  vename :='홍길동';

  DBMS_OUTPUT.PUT_LINE('사번 / 사원명');
  DBMS_OUTPUT.PUT_LINE('========================');
  DBMS_OUTPUT.PUT_LINE(vempno || '/' || vename); -- ||은 PL_SQL문에서 문자열 연결 연산자이다.
end;
/
