/*PL/SQL(Ȯ��Ǿ��� SQL���)
����,���ǹ�,�ݺ���
declare
[���࿡ �ʿ��� ���� ��� ����]; ��������
begin
[�۾��� ���� ���� �����ϴ� ��ɾ�];SQl ���� �ۼ�, ��±��� �ۼ�(Ŀ������ �������� �ݵ�� ����Լ��� ���ؼ� Ȯ���ؾ��Ѵ�)
exception
[PL/SQL���� ���� �߻��ϴ� ���� ó��]; ����ó�� ����
end;
/    �������� ��������ȵ� �߿�! */

set serveroutput on; -- ���� ����� ȭ�鿡 ���

begin
dbms_output.put_line('Hello World');
end;
/

declare
   -- vempno number(4); --������ ����
   -- vename varchar2(10);
    
    vempno constant number(4) :=7777; -- ���(constant)
    vename varchar(10) not null := 'SCOTT'; -- null ���� ������ ������ ����� �� ����.
begin
   -- vempno := 7777;
   -- vename := 'SCOTT';
    
    dbms_output.put_line( '��� / �̸� ');
    dbms_output.put_line( vempno ||' '|| vename);
end;
/

declare
    --��Į�� ���
    --vempno number(4);
    --���۷������
    vempno emp.empno%type :=7777; -- %(������ �ǹ�) ���� ���̺��� �÷��� Ÿ���� �����Ѵ�.
begin
    --vempno := 7777;
    dbms_output.put_line(vempno);
end;
/

declare
    --���۷������
    vempno emp.empno%type; -- %(������ �ǹ�) ���� ���̺��� �÷��� Ÿ���� �����Ѵ�.
    vename emp.ename%type;
begin
    select  empno,ename into vempno,vename --(into���� �ݵ�� ���)
    from emp;
   -- where empno = 7788;  --(select������ �ݵ�� where�� ���)
    dbms_output.put_line('��� / �̸� ');
    dbms_output.put_line(vempno || ' ' || vename);
exception 
    when too_many_rows then dbms_output.put_line('���Ǽ��� ������ �Դϴ�.');
    when others then dbms_output.put_line('��� ���ܿ� ���� ó��');
end;
/

declare
    --���̺� type(����� ���� ���� Ÿ��)
    --�迭�� ����(
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
    
    enameArr ename_table_type; -- �迭������ ���� ����
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
--���ڵ� stpe(�������� ������ ��� ����Ѵ�) => ����� ���� ���� Ÿ��
--Ŭ������ �����ϴ�.

type emp_record_type is record(
    v_empno emp.empno%type,
    v_ename emp.ename%type,
    v_job emp.job%type,
    v_deptno emp.deptno%type
    );
    
    emp_record emp_record_type; -- ���ڵ� Ÿ���� ���� ����
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

----���ǹ�

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
-- %rowtype :���̺��� ��� �÷��� �̸��� ������ �����Ѵ�.
-- �÷����� ���������� ���ǰ� Ŀ���� Ÿ���� ������ Ÿ������ ����Ѵ�.
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
-��Į����
-���۷������
1.emp.empno%type
2.emp%rowtype

-����� ���� ���� Ÿ��
1.���̺� type
    -type xxxx
2.���ڵ� type
    -
-���ǹ�
1.if then end if;
2.if then else end if;
3.if then elsif then end if;

-�ݺ���
loop
    ���๮(���ѹݺ�)
    ���ѹݺ����� ����
    1.exit then ���ǽ�;
    2.if then end if;
end loop;


*/

---------------------------
--�ش� ����� ������ ��� �ϼ���.  �� Ŀ�̼��� null�� ��� 0���� ���ǰ� �ϼ���.
declare
-- %rowtype :���̺��� ��� �÷��� �̸��� ������ �����Ѵ�.
-- �÷����� ���������� ���ǰ� Ŀ���� Ÿ���� ������ Ÿ������ ����Ѵ�.
   vemp emp%rowtype;
   annsal number(7,2);
   
begin
   dbms_output.put_line(' ��� / �̸� / ���� ');
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
   dbms_output.put_line(' ��� / �̸� / ���� ');
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
    exit when n > 10; -- ��������
    end loop;
end;
/

--while

declare

begin
    for n in 1..10 loop -- in �ּҰ�..�ִ밪 1�� ����
    dbms_output.put_line(n);
    end loop;
end;
/

declare

begin
    for n in reverse 1..10 loop -- in �ּҰ�..�ִ밪 �ִ밪���� 1�� ���� 
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

