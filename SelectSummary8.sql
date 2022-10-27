--���� ���ν���
--1.����(create)
--2.����(execute or exec)
/*
create or replace procedure ���ν�����(�Ű�����)

is or as
    ��������
begin
    SQL
    ��±���
    ���ǹ�,�ݺ���
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
--���� ���ν����� �Ű����� ����
in, out, in out
in: ���� ���޹޴� �뵵
out: ���ν��� ������ ���� ����� ������ ��û�������� ����
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
-- ���ε� ���� ���ε� ������ PL/SQL �Ǵ� SQL ���������� WHERE ���� value ���� (?) �� ����ϴ� �����̴�.
-- number�� ���� ���� �������� �ʴ´�.
--print ��ɾ ����ؼ� ������ Ȯ���� �� �ִ�.
variable var_ename varchar2(15);
variable var_sal number;
variable var_job varchar2(9);

exec sel_empno(7499,:var_ename,:var_sal,:var_job); 

print var_ename;
print var_sal;
print var_job;

-- ��� ������ �����ϴ� ���� ���ν����� ���弼��
-- ���, �̸�, ��å, �Ŵ���, �μ�
-- ��� ������ �Ű������� ����ؼ� �޾ƿ´�

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
--�����Լ�  
-�����Լ��� ���� ���ν����� ������ : return���� ����
-1.����(create)
-2.����(excute)
create or replace function �Լ���(�Ű�����)
 return���� Ÿ�� -- �����ݷ� ����
is

begin
    SQL����
    ����Լ�
    ���ǹ�,�ݺ���
    
    return ���ϰ�; -- �����ݷ� ���
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
-- exec ���ʿ� ������ �����ؾ��Ѵ�.
print :var_res;


/*
--Ŀ��
declare

begin
    select*
    into ����
    from emp 
    --where ���ǽ�
end;
/

*/
--Ŀ�� : select ������ �����ϴ� ����� ����Ų��.
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



