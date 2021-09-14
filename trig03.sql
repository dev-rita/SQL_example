create or replace trigger trg_03
after delete on emp01 -- emp01테이블로 부터 레코드 삭제 이후 begin ~end사이의 문장이 실행됨.

for each row
begin
 delete from sal01 where empno = :old.empno; -- :old.empno는 삭제된 사원번호
 end;
 /