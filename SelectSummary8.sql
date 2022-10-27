--저장 프로시져
--1.생성(create)
--2.실행(execute or exec)
/*
create or replace procedure 프로시져명(매개변수)

is or as
    변수정의
begin
    SQL
    출력구문
    조건문,반복문
end;
/
*/

drop table emp01;

set serveroutput on;

create table emp01
as
select *from emp;

create or replace procedure emp01_print
is 
    vempno number(10);
    vename varchar2(10);
begin
    vempno :=1111;
    vename :='Hong';    
    dbms_output.put_line(vempno ||''|| vename);
end;
/

execute emp01_print;

create or replace procedure emp01_del
is
    
begin
    delete from emp01;
end;
/

execute emp01_del;

select *from emp01;

create or replace procedure del_ename(vename emp01.ename%type)
is

begin
    delete from emp01
    where ename = vename;
end;
/

exec del_ename('SCOTT');
exec del_ename('SMITH');
/*
--저장 프로시져의 매개변수 유형
in, out, in out
in: 값을 전달받는 용도
out: 프로시져 내부의 실행 결과를 실행을 요청한쪽으로 전달
in out: in + out
*/

create or replace procedure sel_empno
(
    vempno in emp.empno%type,
    vename out emp.ename%type,
    vsal out emp.sal%type,
    vjob out emp.job%type
)
is

begin
    select ename,sal,job
    into vename,vsal,vjob
    from emp
    where empno = vempno;
end;
/
-- 바인드 변수 바인드 변수는 PL/SQL 또는 SQL 쿼리문에서 WHERE 절에 value 값을 (?) 로 사용하는 변수이다.
-- number는 따로 값을 지정하지 않는다.
--print 명령어를 사용해서 변수를 확인할 수 있다.
variable var_ename varchar2(15);
variable var_sal number;
variable var_job varchar2(9);

exec sel_empno(7499,:var_ename,:var_sal,:var_job); 

print var_ename;
print var_sal;
print var_job;

-- 사원 정보를 저장하는 저장 프로시져를 만드세요
-- 사번, 이름, 직책, 매니져, 부서
-- 사원 정보는 매개변수를 사용해서 받아온다

drop table emp02;

create table emp02
as
select empno,ename,job,mgr,deptno
from emp
where 1 != 1;



create or replace procedure emp_info
(
    vempno in emp02.empno%type,
    vename in emp02.ename%type,
    vjob in emp02.job%type,
    vmgr in emp02.mgr%type,
    vdeptno in emp02.deptno%type
)
is
begin
   insert into emp02
   values(vempno, vename, vjob, vmgr, vdeptno);
end;
/

exec emp_info(1111,'hong','sales',2222,10);

select * from emp02;

/*
--저장함수  
-저장함수와 저장 프로시져의 차이점 : return값의 유무
-1.생성(create)
-2.실행(excute)
create or replace function 함수명(매개변수)
 return값의 타입 -- 세미콜론 생략
is

begin
    SQL구문
    출력함수
    조건문,반복문
    
    return 리턴값; -- 세미콜론 사용
end;
/
*/

create or replace function cal_bonus(vempno emp.empno%type)
    return number
is
    vsal number(7,2);    
begin
    select sal
    into vsal
    from emp
    where empno = vempno;
    
    return vsal * 200;
end;
/

variable var_res number;

execute :var_res := cal_bonus(7788); 
-- exec 뒤쪽에 변수를 선언해야한다.
print :var_res;


/*
--커서
declare

begin
    select*
    into 변수
    from emp 
    --where 조건식
end;
/

*/
--커서 : select 구문이 실행하는 결과를 가리킨다.
declare
    cursor c1 is select * from emp; 
    vemp emp%rowtype;
begin
    open c1;
    loop
    fetch c1 into vemp; 
    exit when c1%notfound;
    dbms_output.put_line(vemp.empno || ' ' ||vemp.ename|| ' ' || vemp.job || ' '|| vemp.mgr|| ' '||vemp.sal|| ' '||vemp.comm|| ' '||vemp.deptno|| ' '||vemp.hiredate);
    end loop;
    close c1;
end;
/

declare 
cursor c1 is select * from dept; 
    vdept dept%rowtype;
begin
    for vdept in c1 loop
            exit when c1%notfound;
    dbms_output.put_line(vdept.deptno ||' '||vdept.dname||' '||vdept.loc);
    end loop;        
end;
/

--employees, departments
select employee_id,first_name,last_name,department_name
from employees e inner join departments d
on e.department_id = d.department_id;

select * from employees
where department_id is null;



