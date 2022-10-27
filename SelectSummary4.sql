-- DML(���������۾�) : ���̺��� �����͸� ����, ����, ���� 
-- ���� : insert , update, delete


-- insert : ���̺� �����͸� �����ϴ� ��.
-- insert into ���̺�� (�÷���1, �÷���2,...)
-- values(��1, ��2, ...)
-- ���÷��� ���� Ÿ�԰� ������ ��ġ�ؾ� �Ѵ�. (1 : 1)
-- ���ۼ� ������� 1:1 ��Ī �ȴ�.

create table dept_temp
as
select * from dept;

select *
from dept_temp;

--�űԷ� �����͸� �߰� �ϰ� ���� ��
insert into dept_temp (DEPTNO, DNAME, LOC)
values (50,'DATABASE','SEOUL');  --���� ���̺� ���� Ÿ���� �˾ƾ� �ϰ�, insert into�� values�� ������ ������ ���ƾ� �ϰ�, ���ڿ��� ���� ��� ' ' �ʼ����

INSERT INTO dept_temp -- �÷������� �ϸ� �� ���̺� �ִ� ��� ���� �߰� ������ �ϰڴٴ� ��
values (70,'HTML','SEOUL');

--�ΰ����� ������ �߰��ϰ� ���� ��
INSERT INTO dept_temp(DEPTNO, DNAME) --(������ NULL������ ����)
values (60,'JSP');
-- �̷��� �� ���, LOC�� NULL�����Ͱ� �ڵ����� ���Եȴ�.

insert into dept_temp -- �÷������� �ϰ� ���� ������ �ְ� ������ NULL �����͸� ������ �ȴ�. (����� NULL������ ����)
values (80,NULL,'SEOUL');


-- ��¥������ �ٷ��
create table emp_temp
as
select * from emp
where 1 != 1; -- �����ʹ� ���ְ� �÷� ������ ����� �����.

select *
from emp_temp; -- ��� : ���� �ϳ��� ����, �÷��� ����

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values (9999,'ȫ�浿','PRESIDENT',NULL,'2001/01/01',5000,1000,10);

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values (3111,'��û��','MANAGER',9999,SYSDATE,4000,NULL,30);
--���� ��¥�� �ڵ����� �����Ͱ� ���Եȴ�.


-- update : �÷��� �����͸� ����(����) 
-- update ���̺��
-- set ���� �ٲ��ְ� ���� �÷��� = �ٲ� �� (�ּ� 1�� �̻�)
-- where �ʿ信 ���� ���ǽ� ��� �����ϳ� ���ǽ��� ���� �ʼ���.
-- �������� ������� ������ �ش� �÷��� ��� ����ȴ�.��

--������� ���̺��� ���� �ϰ� ���� ��.
drop table dept_temp2;

create table dept_temp2
as
select * from dept;

--update dept_temp2
--set loc = 'SEOUL';
--dept_temp2 �� ���̺��� ��� loc �÷��� �����͸� SEOUL�� �����Ѵ�.

update dept_temp2
set dname = 'DATABASE', loc = 'SEOUL'
where deptno = 40;
--deptno�� ���� 40�� ���� �μ��� �̸��� �ٹ����� �����Ѵ�.



-- delete (������ ����)
-- delete from ������ ���̺��
-- where ���ǽ�
-- �������� ������� ������ ��� �����Ͱ� �����ȴ�. ��

create table emp_temp2
as
select * from emp;

delete from emp_temp2
where ename = 'SCOTT';
--�̸��� SCOTT�� ����� �����Ѵ�.



-- TCL (Ʈ����� �������� ���� ����, ��� ��� ���õ� ��ɾ�)
-- commit , rollback, savepoint(���� ��������� ����)
-- commit : ������ ���� ���� (���̺��� �����͸� �ݿ�)
                    -- create������ ����ؼ� ��ü�� ������ �� �ڵ����� commit�ȴ�.
-- rollback : ������ ���� ���  (���̺��� ������ �̹ݿ�) ���󺹱�
                    -- õ������, ���Ⱑ �����ų�, ���� ���� ��쿡 �ڵ����� rollback�ȴ�.

create table dept01
as
select * from dept;

select *
from dept01;

delete from dept01; 

-- �۾��ϴ� �۾��ڿ��Ը� ������ �� ó�� ���� ��, ������ �ܺο��� �������� ���� ���� �ȵ� ���°� ������
-- �����͸� �����ϰ� �����Ϸ��� �ϸ� ���� �������� commit�� ����ؾ��Ѵ�. 

commit;

drop table dept_dept01; -- ���̺� �����ϴ� ���

create table dept_dept01
as
select * from dept;

--�����͸� �����ϴ� ������ delete ���� �ϳ��� �� ����.
delete from dept01; 
truncate table dept01; -- rollback ��� �Ұ��� ( �ڵ����� commit �߻�)
rollback; -- �����غ��� rollback �ȵ�.


-- DDL (���̺�(��簴ü)�� ����, ����, ���� �� �� ����Ѵ�.)
-- create(����), alter(����), drop(����)

--create table ���̺��( -- table(��ü)
--        �÷���1 Ÿ��,       -- column(�Ӽ�)
--        �÷���2 Ÿ��,
--        �÷���3 Ÿ��
--       );
        
-- ���� ���̺� ����� ���        
create table emp_ddl(
--  ���, �̸�, ��å, ������, �Ի���, �޿�, ������, �μ���ȣ
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    mgr number(4),
    hiredate date, --��¥�����͸� �޴� �÷��̱� ������ date
    sal number(7,2), -- ��ü�����δ� 7�ڸ��� ���ڸ� ���������, 2�ڸ��� �Ҽ������� ����ϰڴٴ� ��. �� 5�ڸ��� ����.
    comm number(7,2),
    deptno number(2)
);

insert into emp_ddl
values (9999,'�̼���','MANAGER',1111,SYSDATE,1000,NULL,10);

--������ �ִ� ���̺��� �����ϴ� ���(�׽�Ʈ�� �����ϰų�, ������ ������ ���� ��� ����ϱ� ���ؼ�)
create table dept_ddl
as
select * from dept;

--�μ��� 30���� ���̺��� ����� ���� ��
create table dept_30
as
select * from dept
where deptno = 30;

--dept�� dname,loc�� �����ͼ� ���̺��� ����� ���� ��
create table dept_m
as
select dname,loc
from dept;

--������ ������ ������ ����� ���� ��
create table dept_d
as
select * from dept
where 1 != 1; -- ���̺��� ������ �����ϰڴٴ� �ǹ�.


-- ������� ���̺��� �����ϱ� (�÷��� ���� ����)
-- 1. ���ο� �÷� �߰�(add), 2. �÷��� �̸� ����(rename column), 3. �ڷ����� ����(modify), 4. �÷��� ����(drop column)
-- alter    

--�������̺� �ϳ� �����
create table emp_alter
as
select * from emp;

--���̺��� �� ����������� Ȯ���ϴ� �۾�
select *
from emp_alter;

--���ο� �÷� �߰�
alter table emp_alter
    add address varchar2(100);
    
--�÷��� �̸� ����    
alter table emp_alter
    rename column address to addr;
    
--������ Ÿ��, ũ�� ����
alter table emp_alter
    modify empno number(10); -- ������ ũ�⺸�� �۰Դ� �ȵ����� ũ�Դ� �����ϴ�.

--�÷� ����    
alter table emp_alter
    drop column addr;

--���� ���̺� �����ϱ�
--drop table ���̺��
drop table emp_alter;    
    
--���̺��� ����� �����ƴ��� Ȯ���ϱ�    
select *
from emp_alter;

--����1��
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
    
--����2��    
alter table emp_hw
    add bigo varchar2(20);

--����3��
alter table emp_hw
    modify bigo varchar2(30);
    
--����4��
alter table emp_hw
    rename column bigo to remark;

--����5��
insert into emp_hw
select empno, ename, job, mgr, hiredate, sal, comm, deptno,NULL
from emp;
    
--����6��    
drop table emp_hw;

--�����ͻ���
desc user_tables; 

-- ���� ����ڰ� ���� ����ϰ� �ִ� ���̺� ���� Ȯ���ϱ�
select table_name
from user_tables;

--���� ���� ���̺� ���� Ȯ���ϱ�
select table_name
from all_tables; 

--���� ���� ���̺��� ���� ���� Ȯ���ϱ�
select owner, table_name
from all_tables; 

--index(�˻��ӵ��� ����ϱ� ���� ����Ѵ�.) index�� ��ü�̴�.
--������ ���� create �����Ҷ��� drop 
--select ������ �˻� �ӵ��� ��� ��Ų��.
--��ü ���ڵ��� 3% ~ 5% �϶� �ӵ��� ������. 
--index��ü�� �÷��� �����ؼ� ����Ѵ�.

--create index �ε�����
--on ���̺� �̸�(
--                �÷���1 asc or desc
--                �÷���2 asc or desc
--                �÷���3 asc or desc
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
select * from emp01; -- 917,504 ���� ���Եɶ������� �ϰ� ���߱�

insert into emp01(empno, ename)
values (1111,'bts');

--index ���� �� 0.029 ~ 0.04 ����
--index ���� �� 0.001��
select empno, ename
from emp01
where ename = 'bts';

--index ����
create index idx_emp01_ename
on emp01(ename);

--index ����
drop index idx_emp01_ename;

--���̺� ������ ���󺹱�
show recyclebin; --��ɾ� ������ ��, 
flashback table emp_alter
    to before drop;

--������ ���� ���
purge recyclebin;


--��������
--���̺��� ���� �� ����ϴ� ��
--���������� ���Ἲ�� �����ϱ� ���Ͽ� �����ϴ� ���̸�, ���Ἲ�̶� �߸��� ���� �����ͷ� ������ ���ϰ� �ϴ� ���̴�.
--not null
--unique
--primary key (�⺻Ű)
--foreign key
--check

-- emp, dept
insert into emp
values (1111,'aaa','MANAGER','9999',SYSDATE,1000,NULL,50);
--���� ���� -
--ORA-02291: ���Ἲ ��������(SCOTT.FK_DEPTNO)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
--�������� �Էµ� �μ���ȣ 50�̱� �����̴�. dept�� �μ���ȣ���� 50�� ����.

drop table emp02; -- ���̺� ����

--not null(�ݵ�� null�� �ƴ� �����Ͱ� ���;� �Ѵ�.)
create table emp02(
    empno number(4) not null,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
    );

insert into emp02
values (null,null,'MANAGER',30);
--���� ���� -
--ORA-01400: NULL�� ("SCOTT"."EMP02"."EMPNO") �ȿ� ������ �� �����ϴ�

insert into emp02
values (1111,'ȫ�浿','MANAGER',30);

insert into emp02
values (1111,'�̼���','MANAGER',20);
--���� ȫ�浿�� �����ȣ�� �����ѵ��� ������ �� �ִٴ� ������ ����.

delete from emp02; -- ������ ����




--unique(������ ���� ������ ���� ������ �Ѵ�. NULL�� �ߺ����� ���ܵȴ�.)
create table emp02(
    empno number(4) not null unique,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
    );
    
insert into emp02
values (1111,'ȫ�浿','MANAGER',30);

insert into emp02
values (1111,'�̼���','MANAGER',20);
--���� ���� -
--ORA-00001: ���Ἲ ���� ����(SCOTT.SYS_C0011056)�� ����˴ϴ�

insert into emp02
values (null,'������','SALESMAN',20);
--���� ���� -
--ORA-01400: NULL�� ("SCOTT"."EMP02"."EMPNO") �ȿ� ������ �� �����ϴ�


--primary key(�⺻Ű - ������ ���� ������ ���̸鼭 �ߺ��� �� ���� ��. ���̺� �ϳ��� ���� �����ϴ�.)
create table emp02(
    empno number(4) primary key,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
    );
    
insert into emp02
values (1111,'ȫ�浿','MANAGER',30);

insert into emp02
values (2222,'ȫ�浿','MANAGER',30);

insert into emp02
values (null,'������','SALESMAN',20);
--���� ���� -
--ORA-01400: NULL�� ("SCOTT"."EMP02"."EMPNO") �ȿ� ������ �� �����ϴ�

insert into emp02
values (2222,'������','SALESMAN',10);
--���� ���� -
--ORA-00001: ���Ἲ ���� ����(SCOTT.SYS_C0011061)�� ����˴ϴ�


--�������Ǹ� �ۼ��ϱ� (constraint ���̺��_�÷���_��� ��������)
create table emp02(
    empno number(4) constraint emp02_empno_pk  primary key,
    ename varchar2(10) constraint emp02_empno_nn not null,
    job varchar2(9),
    deptno number(2)
    );
        
insert into emp02
values (1111,'ȫ�浿','MANAGER',30);

insert into emp02
values (2222,'ȫ�浿','MANAGER',30);

insert into emp02 
values (null,'������','SALESMAN',20);
--���� ���� -
--ORA-01400: NULL�� ("SCOTT"."EMP02"."EMPNO") �ȿ� ������ �� �����ϴ�

insert into emp02
values (2222,'������','SALESMAN',10);
--���� ���� -
--ORA-00001: ���Ἲ ���� ����(SCOTT.EMP02_EMPNO_PK)�� ����˴ϴ� 