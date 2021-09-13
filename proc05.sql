set serveroutput on

create or replace procedure cursor_sample01

is
 vdept dept71%rowtype; --로우 타입 변수 선언(한 개의 레코드 행값을 저장할 변수)
 
 cursor c1 --c1커서 정의
 is
 select * from dept71;
 
begin
    DBMS_OUTPUT.PUT_LINE('DEPTNO / DNAME / LOC'); --한글이면 cmd에서 @proc05에서 에러가난다.
    DBMS_OUTPUT.PUT_LINE('============================>');
    
    open c1; --커서 열기
        loop  --반복문 시작
            fetch c1 into vdept.deptno, vdept.dname, vdept.LOC; --읽어온 한 개의 레코드 행 값을 각 변수에 저장
            
            exit when c1%notfound;  --커서로 부터 더이상 읽을 값이 없다면 반복문을 빠져 나간다.
            DBMS_OUTPUT.PUT_LINE(vdept.deptno || '/' || vdept.dname || '/' || vdept.LOC);
        end loop; --반복문 끝
    close c1; --커서 닫기
end;
/