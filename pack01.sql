create or replace package exam_pack --exam_pack 패키지 명 정의
is
  function cal_bonus(vempno in emp01.empno%type)
  return number;
  
  procedure cursor_sample01;
end;
/

create or replace package body exam_pack --exam_pack 몸체문장 정의
is
 function cal_bonus(vempno in emp01.empno%type)
 return number

 is
   vsal number(7,2);--급여를 저장할 실수타입 변수정의
 begin
   select sal into vsal from emp01 where empno=vempno;

   return  (vsal*100);--급여에 *100을 해서 반환
 end;

 procedure  cursor_sample01
 is 
 vdept dept71%rowtype; --로우 타입 변수 선언(한개의 레코드 행값을 저장할 변수)

 cursor c1 --c1 커서 선언
 is
 select * from dept71;

begin
  DBMS_OUTPUT.PUT_LINE('DEPTNO / DNAME / LOC');  --한글이면 cmd에서 @pack01에서 에러가난다. (해당 파일은 utf-8이라 괜찮지만 cmd는 다르기 때문)
  DBMS_OUTPUT.PUT_LINE('============================>');
  
  OPEN C1; --커서 열기
   LOOP
    FETCH c1 into vdept.deptno, vdept.dname, vdept.LOC; --읽어온 한개의 행 레코드값을 각 변수에 저장

    EXIT WHEN c1%NOTFOUND; --커서로 부터 더 이상 읽어들일 값이 없다면 반복문을 빠져 나간다.
    dbms_output.put_line(vdept.deptno || ' / ' || vdept.dname || ' / ' || vdept.LOC);
   END LOOP; --읽어온 값이 여러개의 행일때는 반복문을 사용함.

  CLOSE C1;--커서 닫기
end;
end;
/