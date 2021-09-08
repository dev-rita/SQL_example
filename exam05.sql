set serveroutput on

declare
vempno number(38);
vename varchar2(50);
vdeptno emp.deptno%type;
vdname varchar2(50) := '';

begin
select empno, ename, deptno into vempno, vename, vdeptno from emp where empno=102;

if (vdeptno =10) then
vdname := '개발부';
end if;

if (vdeptno =20) then
vdname := '디자인부';
end if;

DBMS_OUTPUT.PUT_LINE('사번 / 사원명 / 부서번호 / 부서명');
DBMS_OUTPUT.PUT_LINE('=======================================>');
DBMS_OUTPUT.PUT_LINE(vempno || '/' || vename || '/' || vdeptno ||'/'|| vdname);

end;
/