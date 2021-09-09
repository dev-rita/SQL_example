set serveroutput on

declare
    i number(38) := 1;
begin 

    loop --반복문 시작
    DBMS_OUTPUT.PUT_LINE(i);

    i := i+1; --1씩 증가
    
    if i>5 then
    exit;  -- 반복문 종료
    end if; 
    
    end loop;  --반복문 끝

end;
/