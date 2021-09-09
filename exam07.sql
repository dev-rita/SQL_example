set serveroutput on

declare
vemp emp%rowtype;
vdname varchar2(30);

begin
select * into vemp from emp where ename='강감찬';

if (vemp.deptno =10) then
vdname :='개발부';
elsif (vemp.deptno =20)then
vdname :='디자인부';
else
vdname := '연구부';
end if;

DBMS_OUTPUT.PUT_LINE('사원번호 / 사원이름 / 부서명');
DBMS_OUTPUT.PUT_LINE('===============================>');
DBMS_OUTPUT.PUT_LINE(vemp.empno || '/' || vemp.ename || '/' || vdname);


end;
/