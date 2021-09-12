create or replace procedure sel_empno(
    vempno in emp.empno%type,
    vename out emp.ename%type,
    vsal out emp.sal%type
)
is
begin
    select ename,sal into vename,vsal from emp where empno=vempno;
end;
/