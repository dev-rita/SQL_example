--현재 만들어진 시퀀스 이름과 시퀀스 증가값 확인
select sequence_name,increment_by from user_sequences;

--dept_deptno_seq 시퀀스 생성
create sequence dept_deptno_seq
start with 1
increment by 1
nocache;

--처음 생성된 시퀀스를 nextval하지 않고 현재 값을 가져오는 currval하면 에러가 발생한다.
--cmd에서 실행 가능
select dept_deptno_seq.currval from dual;

select dept_deptno_seq.nextval from dual;

--삭제할 시퀀스 생성
create sequence dept_del_seq;

--시퀀스 삭제
drop sequence dept_del_seq;
drop sequence dept_deptno_seq;

--최대값을 설정하는 시퀀스 생성
create sequence dept_deptno_Seq
start with 10 --10부터 시작
increment by 10 --10씩 증가
maxvalue 30; --시퀀스 최대값 30

--생성된 시퀀스 이름, 최대값, 증가값 확인
select sequence_name, max_value, increment_by from user_sequences;

--최대값 30을 넘을 때 까지 시퀀스 생성
select dept_deptno_seq.nextval from dual;

--alter 문으로 시퀀스 최대값을 1000으로 수정
alter sequence dept_deptno_seq
maxvalue 1000;

