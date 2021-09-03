--사용자에게 부여된 권한 조회
select grantee, table_name, grantor, privilege from user_tab_privs_made;

--user011 사용자에게 night계정의 emp테이블의 검색 즉 select 권한을 철회
revoke select on emp from user011;

--cmd에서 실습 진행

conn 아이디/비번 --연결

--세션 변경
alter session set "_oracle_script"=true;

--롤 생성
create role mrole;

--사용자 생성
create user user01 identified by tiger;

--권한부여
grant connect,resource to user01;
grant create session, create table, create view to mrole;
grant select on emp to mrole;

--롤 삭제
drop role mrole;

select username, granted_role from user_role_privs;