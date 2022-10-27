--모든 객체의 이름은 중복될수 없다.
--뷰의 활용
--TOP-N 조회하기
--ROWNUM 낮은순부터 조회
create or replace view view_chk30
as
select empno,ename,sal,comm,deptno
from emp_copy
where deptno = 30 with check option; -- 조건절의 컬럼을 수정하지 못하게 한다.

update view_chk30
set deptno = 10;

create or replace view view_read30
as
select empno,ename,sal,comm,deptno
from emp_copy
where deptno = 30 with read only; -- 모든 컬럼에 대한 C U D 가 불가능 하다.(조회만 가능)

update view_read30
set deptno = 10;
--읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다. -> (insert,update,delete)

DESC emp;

select rownum,ename,hiredate,empno
from emp
where rownum <=14
order by hiredate asc;

create or replace view view_hiredate
as
select empno,ename,hiredate
from emp
order by hiredate asc;

select*from view_hiredate;

select rownum,empno,ename,hiredate
from view_hiredate
where rownum <= 7;


select rownum,empno,ename,hiredate
from view_hiredate
where rownum <= 7;

select rownum empno,ename,hiredate
from view_hiredate
where rownum between 1 and 5;--rownum은 조건절에 직접 사용시 반드시 1을 포함하는 조건식을 만들어야한다.

create or replace view view_hiredate10
as
select rownum rm,empno,ename,hiredate
from view_hiredate; --rownum 을 rm이라는 새롭게 컬럼을 만들고 rm을 이용해 조건절에 1을 포함하지 않은 조건식을 만들 수 있다.

select rm,empno, ename,hiredate
from view_hiredate10
where rm between 2 and 5;

--인라인뷰
select rm,b.*
from(
select rownum rm, a.*
from(
select empno,ename,hiredate
from emp
order by hiredate asc)a
)b
where rm between 1 and 5;
--인라인뷰 상태로 입사일이 가장 빠른 5명을 조회하시오

select rownum, a.*
from(
select empno,ename,hiredate
from emp
order by hiredate asc)a
where rownum <= 5;

--시퀸스
--자동으로 번호를 증가시키는 기능수행
--create, drop

--create sequence 시퀀스명
--start with  시작값 ->  1
--increment by  증가값 -> 1
--maxvalue 최대값 -> 10의 1027
--minvalue 최소값 -> 10의 -1027

create sequence dept_deptno_seq
increment by 10
start with 10;

select dept_deptno_seq.nextval --값을 증가시키는 컬럼 nextval
from dual;

select dept_deptno_seq.currval --현재값을 출력하는컬럼 currval
from dual;

create sequence emp_seq
start with 1
increment by 1
maxvalue 1000;

drop table emp01;

create table emp01
as
select empno,ename,hiredate from emp
where 1 != 1;

select *from emp01;

insert into emp01
values (emp_seq.nextval,'hong',sysdate);

drop table product1;

drop sequence idx_product_id;

create table product1(
pid varchar2(10) ,
pname varchar2(10),
price number(5),

constraint product_pid_pk primary key(pid)
);

create sequence idx_product_id
start with 1000;

insert into product1
values('pid'|| idx_product_id.nextval,'치즈',5000);

select*from product1;

--사용자관리
--create, drop, alter(변경)
--create user 계정명
--identified by 패스워드 대소문자를 구분해서 해야함
--system 계정에서만들수 있고 권한부여를 해주어야한다.
--권한부여는 grant create session to 계정명

create user user01 identified by 1234;

alter user user01 identified by tiger;

drop user user01 cascade;

--DCL(제어어) 데이터 사용 권한과 관련된 명령어
--grant(권한부여), revoke(권한회수)
create table test
(
id varchar2(10)
);

select*from test;

insert into test
values ('aaa');

alter user user01
quota 2m on users;
--------------------------
--권한부여
--grant 객체권한 종류
--on 객체명
-- 계정명
grant select
on emp
to user01;

--권한회수
--revoke 객체권한 종류
--on 객체명
--from 계정명
revoke select
on emp 
from user01;

--
create user user02 identified by 1234;

create user nbac identified by 1234;

drop user nbac ;

-- 사용자 정의 롤
-- 관리자 계정에서만 가능
-- create role 롤명
-- grant 권한 to 롤명
--시스템 권한(create ...) 관리자가부여
--객체 권한 (select ...) 소유주가 부여

create role mrole;

grant create session, create table, create view
to mrole;

create user user04 identified by 1234;

grant mrole
to user04;

alter user user04
quota 2m on users; --  2m의 데이터 부여

--관리자 권한에서 롤 생성
create role mrole2;

--객체권한은 해당 사용자 계정에서 가능
--scott 접속 emp를 보기위해서 scott으로 접속한것
grant select
on emp 
to mrole2;

--롤 권한은 관리자 계정에서만 가능!!
grant mrole2
to user04;

--------------------------------- 왜 emp가 조회가 안될까 set role all;을 해야지만 보이는데 왜 롤 활성화가 안되는걸까 

create user user05 identified by  1234;

grant connect,resource
to user05;

grant select
on emp 
to mrole3;

-------------------------



