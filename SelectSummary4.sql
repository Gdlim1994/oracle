-- DML(데이터조작어) : 테이블의 데이터를 저장, 수정, 삭제 
-- 종류 : insert , update, delete


-- insert : 테이블에 데이터를 삽입하는 것.
-- insert into 테이블명 (컬럼명1, 컬럼명2,...)
-- values(값1, 값2, ...)
-- ★컬럼과 값의 타입과 갯수가 일치해야 한다. (1 : 1)
-- ★작성 순서대로 1:1 매칭 된다.

create table dept_temp
as
select * from dept;

select *
from dept_temp;

--신규로 데이터를 추가 하고 싶을 때
insert into dept_temp (DEPTNO, DNAME, LOC)
values (50,'DATABASE','SEOUL');  --기존 테이블에 사용된 타입을 알아야 하고, insert into과 values에 지정된 갯수가 같아야 하고, 문자열의 같은 경우 ' ' 필수사용

INSERT INTO dept_temp -- 컬럼생략을 하면 이 테이블에 있는 모든 열에 추가 삽입을 하겠다는 뜻
values (70,'HTML','SEOUL');

--두가지만 데이터 추가하고 싶을 때
INSERT INTO dept_temp(DEPTNO, DNAME) --(묵시적 NULL데이터 삽입)
values (60,'JSP');
-- 이렇게 할 경우, LOC는 NULL데이터가 자동으로 삽입된다.

insert into dept_temp -- 컬럼생략을 하고 값의 갯수를 넣고 싶으면 NULL 데이터를 넣으면 된다. (명시적 NULL데이터 삽입)
values (80,NULL,'SEOUL');


-- 날짜데이터 다루기
create table emp_temp
as
select * from emp
where 1 != 1; -- 데이터는 없애고 컬럼 구조만 만드는 방법임.

select *
from emp_temp; -- 결과 : 값이 하나도 없고, 컬럼명만 나옴

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values (9999,'홍길동','PRESIDENT',NULL,'2001/01/01',5000,1000,10);

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values (3111,'심청이','MANAGER',9999,SYSDATE,4000,NULL,30);
--오늘 날짜로 자동으로 데이터가 삽입된다.


-- update : 컬럼의 데이터를 변경(수정) 
-- update 테이블명
-- set 값을 바꿔주고 싶은 컬럼명 = 바꿀 값 (최소 1개 이상)
-- where 필요에 따라 조건식 사용 가능하나 조건식은 거의 필수임.
-- 조건절을 사용하지 않으면 해당 컬럼이 모두 변경된다.★

--만들어진 테이블을 삭제 하고 싶을 때.
drop table dept_temp2;

create table dept_temp2
as
select * from dept;

--update dept_temp2
--set loc = 'SEOUL';
--dept_temp2 의 테이블에서 모든 loc 컬럼의 데이터를 SEOUL로 변경한다.

update dept_temp2
set dname = 'DATABASE', loc = 'SEOUL'
where deptno = 40;
--deptno의 값이 40인 곳만 부서의 이름과 근무지를 변경한다.



-- delete (데이터 삭제)
-- delete from 삭제할 테이블명
-- where 조건식
-- 조건절을 사용하지 않으면 모든 데이터가 삭제된다. ★

create table emp_temp2
as
select * from emp;

delete from emp_temp2
where ename = 'SCOTT';
--이름이 SCOTT인 사람만 삭제한다.



-- TCL (트랜잭션 데이터의 영구 저장, 취소 등과 관련된 명령어)
-- commit , rollback, savepoint(자주 사용하지는 않음)
-- commit : 데이터 영구 저장 (테이블의 데이터를 반영)
                    -- create구문을 사용해서 객체를 생성할 때 자동으로 commit된다.
-- rollback : 데이터 변경 취소  (테이블의 데이터 미반영) 원상복귀
                    -- 천재지변, 전기가 나가거나, 전쟁 같은 경우에 자동으로 rollback된다.

create table dept01
as
select * from dept;

select *
from dept01;

delete from dept01; 

-- 작업하는 작업자에게만 삭제된 것 처럼 보일 뿐, 실제로 외부에서 접속했을 때는 삭제 안된 상태가 보여짐
-- 데이터를 완전하게 삭제하려고 하면 위의 과정에서 commit을 사용해야한다. 

commit;

drop table dept_dept01; -- 테이블 삭제하는 방법

create table dept_dept01
as
select * from dept;

--데이터를 삭제하는 구문이 delete 말고도 하나가 더 있음.
delete from dept01; 
truncate table dept01; -- rollback 사용 불가임 ( 자동으로 commit 발생)
rollback; -- 실행해보면 rollback 안됨.


-- DDL (테이블(모든객체)을 생성, 변경, 삭제 할 때 사용한다.)
-- create(생성), alter(변경), drop(삭제)

--create table 테이블명( -- table(객체)
--        컬럼명1 타입,       -- column(속성)
--        컬럼명2 타입,
--        컬럼명3 타입
--       );
        
-- 직접 테이블 만드는 방법        
create table emp_ddl(
--  사번, 이름, 직책, 관리자, 입사일, 급여, 성과금, 부서번호
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    mgr number(4),
    hiredate date, --날짜데이터를 받는 컬럼이기 때문에 date
    sal number(7,2), -- 전체적으로는 7자리의 숫자를 사용하지만, 2자리는 소숫점으로 사용하겠다는 뜻. 즉 5자리는 정수.
    comm number(7,2),
    deptno number(2)
);

insert into emp_ddl
values (9999,'이순신','MANAGER',1111,SYSDATE,1000,NULL,10);

--기존에 있는 테이블을 복사하는 방법(테스트를 진행하거나, 원본에 문제가 있을 경우 사용하기 위해서)
create table dept_ddl
as
select * from dept;

--부서가 30번인 테이블을 만들고 싶을 때
create table dept_30
as
select * from dept
where deptno = 30;

--dept의 dname,loc만 가져와서 테이블을 만들고 싶을 때
create table dept_m
as
select dname,loc
from dept;

--데이터 제외한 구조만 만들고 싶을 때
create table dept_d
as
select * from dept
where 1 != 1; -- 테이블의 구조만 복사하겠다는 의미.


-- 만들어진 테이블을 변경하기 (컬럼의 정보 수정)
-- 1. 새로운 컬럼 추가(add), 2. 컬럼의 이름 변경(rename column), 3. 자료형의 변경(modify), 4. 컬럼을 삭제(drop column)
-- alter    

--복사테이블 하나 만들기
create table emp_alter
as
select * from emp;

--테이블이 잘 만들어졌는지 확인하는 작업
select *
from emp_alter;

--새로운 컬럼 추가
alter table emp_alter
    add address varchar2(100);
    
--컬럼의 이름 변경    
alter table emp_alter
    rename column address to addr;
    
--데이터 타입, 크기 변경
alter table emp_alter
    modify empno number(10); -- 기존의 크기보다 작게는 안되지만 크게는 가능하다.

--컬럼 삭제    
alter table emp_alter
    drop column addr;

--만든 테이블 삭제하기
--drop table 테이블명
drop table emp_alter;    
    
--테이블이 제대로 삭제됐는지 확인하기    
select *
from emp_alter;

--문제1번
create table emp_hw(
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2)
    );
    
--문제2번    
alter table emp_hw
    add bigo varchar2(20);

--문제3번
alter table emp_hw
    modify bigo varchar2(30);
    
--문제4번
alter table emp_hw
    rename column bigo to remark;

--문제5번
insert into emp_hw
select empno, ename, job, mgr, hiredate, sal, comm, deptno,NULL
from emp;
    
--문제6번    
drop table emp_hw;

--데이터사전
desc user_tables; 

-- 현재 사용자가 만들어서 사용하고 있는 테이블 정보 확인하기
select table_name
from user_tables;

--남이 만든 테이블 정보 확인하기
select table_name
from all_tables; 

--남이 만든 테이블의 주인 정보 확인하기
select owner, table_name
from all_tables; 

--index(검색속도를 향상하기 위해 사용한다.) index는 객체이다.
--생성할 때는 create 삭제할때는 drop 
--select 구문의 검색 속도를 향상 시킨다.
--전체 레코드의 3% ~ 5% 일때 속도가 빠르다. 
--index객체를 컬럼에 생성해서 사용한다.

--create index 인덱스명
--on 테이블 이름(
--                컬럼명1 asc or desc
--                컬럼명2 asc or desc
--                컬럼명3 asc or desc
--                );
                
create table emp01
as
select * from emp;

insert into emp01
select * from emp;

drop table emp01;

create table emp01
as
select * from emp;

insert into emp01
select * from emp01; -- 917,504 행이 삽입될때까지만 하고 멈추기

insert into emp01(empno, ename)
values (1111,'bts');

--index 생성 전 0.029 ~ 0.04 사이
--index 생성 후 0.001초
select empno, ename
from emp01
where ename = 'bts';

--index 생성
create index idx_emp01_ename
on emp01(ename);

--index 삭제
drop index idx_emp01_ename;

--테이블 삭제후 원상복구
show recyclebin; --명령어 실행한 뒤, 
flashback table emp_alter
    to before drop;

--휴지통 비우는 방법
purge recyclebin;


--제약조건
--테이블을 만들 때 사용하는 것
--제약조건은 무결성을 구현하기 위하여 설정하는 것이며, 무결성이란 잘못된 값이 데이터로 사용되지 못하게 하는 것이다.
--not null
--unique
--primary key (기본키)
--foreign key
--check

-- emp, dept
insert into emp
values (1111,'aaa','MANAGER','9999',SYSDATE,1000,NULL,50);
--오류 보고 -
--ORA-02291: 무결성 제약조건(SCOTT.FK_DEPTNO)이 위배되었습니다- 부모 키가 없습니다
--마지막에 입력된 부서번호 50이기 때문이다. dept의 부서번호에도 50은 없음.

drop table emp02; -- 테이블 삭제

--not null(반드시 null이 아닌 데이터가 들어와야 한다.)
create table emp02(
    empno number(4) not null,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
    );

insert into emp02
values (null,null,'MANAGER',30);
--오류 보고 -
--ORA-01400: NULL을 ("SCOTT"."EMP02"."EMPNO") 안에 삽입할 수 없습니다

insert into emp02
values (1111,'홍길동','MANAGER',30);

insert into emp02
values (1111,'이순신','MANAGER',20);
--위의 홍길동과 사원번호가 동일한데도 삽입할 수 있다는 오류가 있음.

delete from emp02; -- 데이터 삭제




--unique(지정한 열이 유일한 값을 가져야 한다. NULL은 중복에서 제외된다.)
create table emp02(
    empno number(4) not null unique,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
    );
    
insert into emp02
values (1111,'홍길동','MANAGER',30);

insert into emp02
values (1111,'이순신','MANAGER',20);
--오류 보고 -
--ORA-00001: 무결성 제약 조건(SCOTT.SYS_C0011056)에 위배됩니다

insert into emp02
values (null,'김유신','SALESMAN',20);
--오류 보고 -
--ORA-01400: NULL을 ("SCOTT"."EMP02"."EMPNO") 안에 삽입할 수 없습니다


--primary key(기본키 - 지정한 열이 유일한 값이면서 중복될 수 없는 것. 테이블에 하나만 지정 가능하다.)
create table emp02(
    empno number(4) primary key,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
    );
    
insert into emp02
values (1111,'홍길동','MANAGER',30);

insert into emp02
values (2222,'홍길동','MANAGER',30);

insert into emp02
values (null,'김유신','SALESMAN',20);
--오류 보고 -
--ORA-01400: NULL을 ("SCOTT"."EMP02"."EMPNO") 안에 삽입할 수 없습니다

insert into emp02
values (2222,'옥동자','SALESMAN',10);
--오류 보고 -
--ORA-00001: 무결성 제약 조건(SCOTT.SYS_C0011061)에 위배됩니다


--제약조건명 작성하기 (constraint 테이블명_컬럼명_약어 제약조건)
create table emp02(
    empno number(4) constraint emp02_empno_pk  primary key,
    ename varchar2(10) constraint emp02_empno_nn not null,
    job varchar2(9),
    deptno number(2)
    );
        
insert into emp02
values (1111,'홍길동','MANAGER',30);

insert into emp02
values (2222,'홍길동','MANAGER',30);

insert into emp02 
values (null,'김유신','SALESMAN',20);
--오류 보고 -
--ORA-01400: NULL을 ("SCOTT"."EMP02"."EMPNO") 안에 삽입할 수 없습니다

insert into emp02
values (2222,'옥동자','SALESMAN',10);
--오류 보고 -
--ORA-00001: 무결성 제약 조건(SCOTT.EMP02_EMPNO_PK)에 위배됩니다 