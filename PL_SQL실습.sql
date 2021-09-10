--트리거 실습을 위한 급여정보를 저장하는 테이블 생성
create table sal01(
	salno number(38) primary key
	,sal number(7,2)
	,empno int references emp01(empno) --외래키 설정
);

select * from sal01 order by salno;

--sal01_salno_seq 시퀀스 생성
create sequence sal01_salno_seq
start with 1
increment by 1
nocache;

/*
 * cmd에서 실행
 * @파일명 (ex. @proc03)
 * 
 * proc03 에서 ename 과  result 출력
 * variable var_ename varchar2(20);
 * variable var_sal number;
 * execute sel_empno(101,:var_ename, :var_sal)
 * 
 * print var_ename;
 * 
 * variable result number;
 * execute : result := cal_bonus(101);
 * print result;
 * 
 * execute cursor_sample01;
 * 
 * <pack01.sql>
 * execute exam_pack.cursor_sample01;
 * 
 * <trig01,02.sql>
 * set serveroutput on
 * insert into emp01 values(1,'홍길동','java 개발자');
 * commit;
 * 
 * <trig03.sql>
 * delete from emp01 where empno=102;
 * commit;
 * 
 */