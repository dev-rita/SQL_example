set serveroutput on

declare
vemp emp%rowtype; --한행 전체 레코드 행 값을 vemp변수에 저장
annsal number(7,2); --number(7,2)는 소수점을 포함한 전체자리수가 7, 소수점 자리수가 2

begin
--이순신 사원의 한행 전체 레코드 행값을 vemp변수에 저장
select * into vemp from emp where ename = '이순신';

if(vemp.comm is null) then --보너스가 null이면
 annsal := vemp.sal*12; --월급 *12
 
 else
 annsal := vemp.sal*12 +vemp.comm; --월급 * 12 +보너스
 end if;
 
 DBMS_OUTPUT.PUT_LINE('사원번호 / 사원명 / 연봉 ');
 DBMS_OUTPUT.PUT_LINE('---------------------------------------------------->');
 DBMS_OUTPUT.PUT_LINE(vemp.empno || '/'  || vemp.ename || '/' || annsal);

end;
/