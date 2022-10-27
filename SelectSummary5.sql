--foreign(�ܷ�Ű/����Ű)
--�θ�� �ڽ��� ���踦 ������ ���̺� �ڽ���
--�������� �׽�Ʈ �ÿ��� ���̺��� ���� �������Ѵ�.
insert into emp 
values (1111,'aaa','MANAGE',9999,SYSDATE,1000,NULL,50);

create table emp07(
empno number(4) CONSTRAINT emp07_empno_pk primary key,
ename varchar2(9)CONsTRAINT emp07_ename_nn not null,
job varchar2(9),
deptno number(2) constraint emp07_deptno_fk references dept07(deptno)
);

create table dept07(
deptno number(2) CONSTRAINT dept07_deptno_pk primary key,
dname varchar2(20) CONSTRAINT dept07_dname_nn not null,
loc varchar2(20) CONSTRAINT dept07_loc_nn not null
);


--������������ ����� ������ ����
insert into dept07  ------- �̰� �� �ȵǴ°���;; �Ǳ��ߴµ� �� dept07�� 3���� �ϸ� �Ǵ��� �˾ƺ���
select * from dept;

insert into emp07
select empno,ename,job,deptno from emp;

select*from emp07;
select*from dept07;


insert into emp 
values (1111,'aaa','MANAGE',50);

create table emp08(
empno number(4) primary key,
ename varchar(10) not null,
sal number(7) constraint emp08_sal_ck check(sal between 500 and 5000),
gender varchar(2)constraint emp_08_gender_ck check(gender in ('M','F'))
);

select*from emp08;

insert into emp08
values(1111,'hong',1000,'M');

create table dept08(
deptno number(2) primary key,
dname varchar2(10) not null,
loc varchar2(15) default 'SEOUL'
);

insert into dept08(deptno,dname)
values(10,'SALES');

select*from dept08;

insert into dept08(deptno,dname,loc)
values(20,'SALES','BUSAN');

--�������� �����ڽ�
--�÷� ������ ����(not null�� ������ �� �ִ�) **�÷� ���������� ��������
--���̺� ������ ����(not null�� ������ �� ����) 

create table emp09(
empno number(4),
ename varchar2(20) CONSTRAINT emp09_ename_nn not null,
job varchar2(20),
deptno number(20),

CONSTRAINT emp09_empno_pk primary key(empno),
CONSTRAINT emp09_job_uk unique(job),
CONSTRAINT emp09_deptno_fk foreign key(deptno) references dept(deptno)
);


select*from emp09;

insert into emp09
values (3333,'hong','PRESIDENT',80);

--����Ű(�⺻Ű�� �ΰ��� �÷��� ����ϴ� ���)
--���̺� ���� ������θ� ���밡��
--1.���̺�ȿ��� �����ϴ� ���
--2.Alter ��ɾ� ����ϴ� ���

create table member(
name varchar2(10),
address varchar2(30),
hphone varchar2(10),

CONSTRAINT member_name_address_pk primary key(name,address);
);

create table emp10(
empno number(4),
ename varchar2(20),
job varchar2(20),
deptno number(20)
);

alter table emp10
add constraint emp10_empno_pk primary key(empno);

alter table emp10
add constraint emp10_empno_fk foreign key(deptno) references dept(deptno);

--not null�� ������ ����(null -> not null)
--modify
alter table emp10
modify job constraint emp10_job_nn not null;

alter table emp10
modify ename constraint emp10_ename_nn not null;

--drop --�������Ǹ�(constraint) �Ǵ� ��������(primary key)

alter table emp10
drop constraint emp10_empno_pk;
------------------------------------------------
create table emp11(
empno number(4),
ename varchar2(20),
job varchar2(20),
deptno number(20)
);

alter table emp11
add constraint emp11_empno_pk primary key(empno);

alter table emp11
add constraint emp11_deptno_fk foreign key(deptno) references dept11(deptno);

create table dept11(
deptno number(2),
dname varchar2(10),
loc varchar2(15)
);

alter table dept11
add constraint dept11_deptno_pk primary key(deptno);

insert into dept11
select*from dept;

insert into emp11
select empno,ename,job,deptno
from emp;

select*from dept11;

delete from dept11
where deptno = 10;

alter table dept11
disable primary key cascade;

drop table dept11;

------------------------------------------p.394 ���̺����������

create table DEPT_CONST(
deptno number(2),
dname varchar2(14),
loc varchar2(13)
);

alter table DEPT_CONST
add constraint DEPTCONST_DEPTNO_PK primary key(deptno);

alter table DEPT_CONST
add constraint DEPTCONST_DNAME_UNQ unique(dname);

alter table DEPT_CONST
modify(loc constraint DEPTCONST_LOC_NN not null);

create table EMP_CONST(
empno number(4),
ename varchar2(10),
job varchar2(9),
tel varchar2(20),
hiredate date,
sal number(7,2),
comm number(7,2),
deptno number(2)
);

alter table EMP_CONST
add constraint EMPCONST_EMPNO_PK primary key(empno);

alter table EMP_CONST
modify(ename constraint EMPCONST_ENAME_NN not null);

alter table EMP_CONST
add constraint EMPCONST_TEL_UNQ unique(tel);

alter table EMP_CONST
add constraint EMPCONST_SAL_CHK check(sal between 1000 and 9999);

alter table EMP_CONST
add constraint EMPCONST_DEPTNO_FK foreign key(deptno) references DEPT_CONST(deptno);

insert into DEPT_CONST
select*from dept;

insert into EMP_CONST
select *
from emp;

select*from DEPT_CONST;

select*from EMP_CONST;

--------------------
--�� 
--1.����
--2.����Ұ�
--3.����
--c(create=insert)r(read=select)u(update)d(delete)

--��ü : table index view
--create or replace view �����̺��(alias)
--as
--��������(select)
--with check option
--with read only
--

create table dept_copy
as
select * from dept;

create table emp_copy  -- ����Ǵ� ���̺��� ���������� �Ѿ���� �ʴ´�.
as 
select * from emp;

alter table emp_copy
add constraint emp_copy_deptno_fk foreign key(deptno) references dept(deptno);

select * from emp_copy; -- 14

create or replace view emp_view30
as
select empno,ename,sal,deptno from emp_copy
where deptno = 30;

select *
from emp_view30;

select*
from emp_copy;

insert into emp_view30
values(1111,'kim',1200,30);

insert into emp_view30(empno,ename,sal,deptno)
values(3333,'tim',1000,50);

create or replace view emp_view(�����ȣ,�����,�޿�,�μ���ȣ)--�÷� �̸� �ѱ۷ε� ����! --�� ���� where(����)���� �������� �÷��� �ѱ۷� �ؾ���!
as
select empno,ename,sal,deptno
from emp_copy;

select*
from emp_view;

select*
from emp_view
where �μ���ȣ=20;

create or replace view emp_dept_view
as
select empno,ename,sal,e.deptno,dname,loc
from emp e inner join dept d
on e.deptno = d.deptno
order by empno desc;

select*
from emp_dept_view;

--�μ��� �ּұ޿��� �ִ�޿�
--dname min_sal max_sal
--

create or replace view sal_view
as
select dname,
min(sal) as min_sal,
max(sal) as max_sal
from emp join dept using(deptno)
group by dname;


select*from sal_view;
