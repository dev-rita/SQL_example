create or replace function cal_bonus(
    vempno in emp01.empno%type
)
return number  --함수에 의해서 반환 되는 값의 정수 자료형

is
    vsal number(7,2);
begin
    select sal into vsal from emp01 where empno=vempno;

return (vsal*200); --월급에 *200한 값을 반환
end;
/