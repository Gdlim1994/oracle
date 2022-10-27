/*PL/SQL(확장되어진 SQL언어)
변수,조건문,반복문
declare
[실행에 필요한 여러 요소 선언]; 변수정의
begin
[작업을 위해 실제 실행하는 명령어];SQl 구문 작성, 출력구문 작성(커리문의 수행결과를 반드시 출력함수를 통해서 확인해야한다)
exception
[PL/SQL수행 도중 발생하는 오류 처리]; 예외처리 구문
end;
/    슬래쉬를 빼먹으면안됨 중요! */

set serveroutput on; -- 실행 결과를 화면에 출력

begin
dbms_output.put_line('Hello World');
end;
/

declare
   -- vempno number(4); --변수의 선언
   -- vename varchar2(10);
    
    vempno constant number(4) :=7777; -- 상수(constant)
    vename varchar(10) not null := 'SCOTT'; -- null 값을 변수의 값으로 사용할 수 없다.
begin
   -- vempno := 7777;
   -- vename := 'SCOTT';
    
    dbms_output.put_line( '사원 / 이름 ');
    dbms_output.put_line( vempno ||' '|| vename);
end;
/

declare
    --스칼라 방식
    --vempno number(4);
    --레퍼런스방식
    vempno emp.empno%type :=7777; -- %(참조의 의미) 기존 테이블의 컬럼의 타입을 참조한다.
begin
    --vempno := 7777;
    dbms_output.put_line(vempno);
end;
/

declare
    --레퍼런스방식
    vempno emp.empno%type; -- %(참조의 의미) 기존 테이블의 컬럼의 타입을 참조한다.
    vename emp.ename%type;
begin
    select  empno,ename into vempno,vename --(into절도 반드시 사용)
    from emp;
   -- where empno = 7788;  --(select절에서 반드시 where절 사용)
    dbms_output.put_line('사번 / 이름 ');
    dbms_output.put_line(vempno || ' ' || vename);
exception 
    when too_many_rows then dbms_output.put_line('행의수가 여러개 입니다.');
    when others then dbms_output.put_line('모든 예외에 대한 처리');
end;
/

declare
    --테이블 type(사용자 정의 변수 타입)
    --배열의 형식(
    --vename varchar2(10)
    type ename_table_type is table of emp.ename%type
    index by binary_integer;
    
    type job_table_type is table of emp.job%type
    index by binary_integer;
    
    type empno_table_type is table of emp.empno%type
    index by binary_integer;
    
    type mgr_table_type is table of emp.mgr%type
    index by binary_integer;
    
    type hiredate_table_type is table of emp.hiredate%type
    index by binary_integer;
    
    type sal_table_type is table of emp.sal%type
    index by binary_integer;
    
    type comm_table_type is table of emp.comm%type
    index by binary_integer;
    
    type deptno_table_type is table of emp.deptno%type
    index by binary_integer;
    
    enameArr ename_table_type; -- 배열형식의 변수 선언
    jobArr job_table_type;
    empnoArr empno_table_type;
    mgrArr mgr_table_type;
    hiredateArr hiredate_table_type;
    salArr sal_table_type;
    commArr comm_table_type;
    deptnoArr deptno_table_type;
    
    i binary_integer :=0;
begin
    for k in (select * from emp) loop
    i := i + 1;
    enameArr(i) := k.ename;
    jobArr(i) := k.job;
    empnoArr(i) := k.empno;
    mgrArr(i) := k.mgr;
    hiredateArr(i) := k.hiredate;
    salArr(i) := k.sal;
    commArr(i) := k.comm;
    deptnoArr(i) := k.deptno;
end loop;

for j in 1..i loop
dbms_output.put_line(enameArr(j)|| ' ' ||jobArr(j)|| ' ' ||empnoArr(j)|| ' ' ||mgrArr(j)|| ' ' ||hiredateArr(j)|| ' ' ||salArr(j)|| ' ' ||commArr(i)|| ' ' ||deptnoArr(i));
end loop;
end;
/

declare
--레코드 stpe(여러개의 변수를 묶어서 사용한다) => 사용자 정의 변수 타입
--클래스와 유사하다.

type emp_record_type is record(
    v_empno emp.empno%type,
    v_ename emp.ename%type,
    v_job emp.job%type,
    v_deptno emp.deptno%type
    );
    
    emp_record emp_record_type; -- 레코드 타입의 변수 선언
begin
    select empno,ename,job,deptno 
    into emp_record
    from emp
    where empno = 7788;
    dbms_output.put_line(emp_record.v_empno || ' ' || emp_record.v_ename|| ' ' || emp_record.v_job|| ' ' || emp_record.v_deptno);
end;
/

create table dept_record
as
select * from dept;

declare
    type rec_dept is record(
        v_deptno dept_record.deptno%type,
        v_dname dept_record.dname%type,
        v_loc dept_record.loc%type
    );
    dept_rec rec_dept;
begin
    dept_rec.v_deptno := 50;
    dept_rec.v_dname := 'DEV';
    dept_rec.v_loc := 'BUSAN';
    
    insert into dept_record
    values dept_rec;
end;
/

select * from dept_record;


declare
    type rec_dept is record(
        v_deptno number(2) not null := 99,
        v_dname dept.dname%type,
        v_loc dept_record.loc%type
    );
    dept_rec rec_dept;
begin
    dept_rec.v_deptno := 50;
    dept_rec.v_dname := 'INSA';
    dept_rec.v_loc := 'SEOUL';
    
    update dept_record
    set dname = dept_rec.v_dname, loc = dept_rec.v_loc
    where deptno = dept_rec.v_deptno;
end;
/

declare
v_deptno dept_record.deptno%type := 50;
begin
delete from dept_record
where deptno = v_deptno;
end;
/

----조건문

declare
    vempno number(4);
    vename varchar2(10);
    vdeptno varchar2(10);
    vdname varchar2(10) := null;
begin
    select empno,ename,deptno
    into vempno,vename,vdeptno
    from emp
    where empno = 7788;    
        if (vdeptno = 10) then 
        vdname := 'AAA';    
        end if;
        if(vdeptno = 20) then 
        vdname := 'BBB';
        end if;
        if(vdeptno = 30) then 
        vdname := 'CCC';
        end if;
        if(vdeptno = 40) then 
        vdname := 'DDD';      
        end if;
     dbms_output.put_line(vdname);
end;
/

declare
-- %rowtype :테이블의 모든 컬럼의 이름과 변수를 참조한다.
-- 컬럼명이 변수명으로 사용되고 커럼의 타입을 변수의 타입으로 사용한다.
    vemp emp%rowtype;
    
begin
    select*
    into vemp
    from emp 
    where empno = 7788;
    
    dbms_output.put_line(vemp.empno);
    dbms_output.put_line(vemp.ename);
    dbms_output.put_line(vemp.deptno);
end;
/

/*
-스칼라방식
-레퍼런스방식
1.emp.empno%type
2.emp%rowtype

-사용자 정의 변수 타입
1.테이블 type
    -type xxxx
2.레코드 type
    -
-조건문
1.if then end if;
2.if then else end if;
3.if then elsif then end if;

-반복문
loop
    실행문(무한반복)
    무한반복문의 제어
    1.exit then 조건식;
    2.if then end if;
end loop;


*/

---------------------------
--해당 사원의 연봉을 출력 하세요.  단 커미션이 null인 경우 0으로 계산되게 하세요.
declare
-- %rowtype :테이블의 모든 컬럼의 이름과 변수를 참조한다.
-- 컬럼명이 변수명으로 사용되고 커럼의 타입을 변수의 타입으로 사용한다.
   vemp emp%rowtype;
   annsal number(7,2);
   
begin
   dbms_output.put_line(' 사번 / 이름 / 연봉 ');
   dbms_output.put_line('----------------- ');
   
   select * 
   into vemp
   from emp
   where empno = 7788;
   
   if(vemp.comm is null) then
   vemp.comm := 0;
   end if;
   annsal := vemp.sal*12 + vemp.comm;
   dbms_output.put_line(vemp.empno||'/'||vemp.ename||'/'||annsal);
end;
/

declare

   vemp emp%rowtype;
   annsal number(7,2);
   
begin
   dbms_output.put_line(' 사번 / 이름 / 연봉 ');
   dbms_output.put_line('----------------- ');
   
   select * 
   into vemp
   from emp
   where empno = 7788;
   
   if(vemp.comm is null) then
   annsal := vemp.sal*12;
   else
   annsal := vemp.sal*12 + vemp.comm;
   end if;
   dbms_output.put_line(vemp.empno||'/'||vemp.ename||'/'||annsal);
end;
/

declare
    vemp emp%rowtype;
    vdname varchar2(10);
begin
    select*
    into vemp
    from emp
    where empno = 7788;
    
    if (vemp.deptno = 10) then 
        vdname := 'AAA';    
      elsif(vemp.deptno = 20) then 
        vdname := 'BBB';
      elsif(vemp.deptno = 30) then 
        vdname := 'CCC';
        elsif(vemp.deptno = 40) then 
        vdname := 'DDD';      
    
    end if;
    dbms_output.put_line(vdname);
end;
/

declare
    n number := 1;
begin
    loop
    dbms_output.put_line(n);
    n := n + 1;
    exit when n > 10; -- 종료조건
    end loop;
end;
/

--while

declare

begin
    for n in 1..10 loop -- in 최소값..최대값 1씩 증가
    dbms_output.put_line(n);
    end loop;
end;
/

declare

begin
    for n in reverse 1..10 loop -- in 최소값..최대값 최대값에서 1씩 감소 
    dbms_output.put_line(n);
    end loop;
end;
/

declare
    vdept dept%rowtype;
begin
    for n in 1..4 loop
    select *
    into vdept
    from dept
    where deptno = 10 * n;
    DBMS_OUTPUT.put_line(vdept.deptno || ' ' || vdept.dname || ' ' || vdept.loc);
    end loop;
end;
/

declare
    n number := 1;
begin
    while(n <= 10) loop
        DBMS_OUTPUT.PUT_LINE(n);
        n := n + 1;
    end loop;
end;
/

