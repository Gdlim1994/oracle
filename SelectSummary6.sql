--��� ��ü�� �̸��� �ߺ��ɼ� ����.
--���� Ȱ��
--TOP-N ��ȸ�ϱ�
--ROWNUM ���������� ��ȸ
create or replace view view_chk30
as
select empno,ename,sal,comm,deptno
from emp_copy
where deptno = 30 with check option; -- �������� �÷��� �������� ���ϰ� �Ѵ�.

update view_chk30
set deptno = 10;

create or replace view view_read30
as
select empno,ename,sal,comm,deptno
from emp_copy
where deptno = 30 with read only; -- ��� �÷��� ���� C U D �� �Ұ��� �ϴ�.(��ȸ�� ����)

update view_read30
set deptno = 10;
--�б� ���� �信���� DML �۾��� ������ �� �����ϴ�. -> (insert,update,delete)

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
where rownum between 1 and 5;--rownum�� �������� ���� ���� �ݵ�� 1�� �����ϴ� ���ǽ��� �������Ѵ�.

create or replace view view_hiredate10
as
select rownum rm,empno,ename,hiredate
from view_hiredate; --rownum �� rm�̶�� ���Ӱ� �÷��� ����� rm�� �̿��� �������� 1�� �������� ���� ���ǽ��� ���� �� �ִ�.

select rm,empno, ename,hiredate
from view_hiredate10
where rm between 2 and 5;

--�ζ��κ�
select rm,b.*
from(
select rownum rm, a.*
from(
select empno,ename,hiredate
from emp
order by hiredate asc)a
)b
where rm between 1 and 5;
--�ζ��κ� ���·� �Ի����� ���� ���� 5���� ��ȸ�Ͻÿ�

select rownum, a.*
from(
select empno,ename,hiredate
from emp
order by hiredate asc)a
where rownum <= 5;

--������
--�ڵ����� ��ȣ�� ������Ű�� ��ɼ���
--create, drop

--create sequence ��������
--start with  ���۰� ->  1
--increment by  ������ -> 1
--maxvalue �ִ밪 -> 10�� 1027
--minvalue �ּҰ� -> 10�� -1027

create sequence dept_deptno_seq
increment by 10
start with 10;

select dept_deptno_seq.nextval --���� ������Ű�� �÷� nextval
from dual;

select dept_deptno_seq.currval --���簪�� ����ϴ��÷� currval
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
values('pid'|| idx_product_id.nextval,'ġ��',5000);

select*from product1;

--����ڰ���
--create, drop, alter(����)
--create user ������
--identified by �н����� ��ҹ��ڸ� �����ؼ� �ؾ���
--system ������������� �ְ� ���Ѻο��� ���־���Ѵ�.
--���Ѻο��� grant create session to ������

create user user01 identified by 1234;

alter user user01 identified by tiger;

drop user user01 cascade;

--DCL(�����) ������ ��� ���Ѱ� ���õ� ��ɾ�
--grant(���Ѻο�), revoke(����ȸ��)
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
--���Ѻο�
--grant ��ü���� ����
--on ��ü��
-- ������
grant select
on emp
to user01;

--����ȸ��
--revoke ��ü���� ����
--on ��ü��
--from ������
revoke select
on emp 
from user01;

--
create user user02 identified by 1234;

create user nbac identified by 1234;

drop user nbac ;

-- ����� ���� ��
-- ������ ���������� ����
-- create role �Ѹ�
-- grant ���� to �Ѹ�
--�ý��� ����(create ...) �����ڰ��ο�
--��ü ���� (select ...) �����ְ� �ο�

create role mrole;

grant create session, create table, create view
to mrole;

create user user04 identified by 1234;

grant mrole
to user04;

alter user user04
quota 2m on users; --  2m�� ������ �ο�

--������ ���ѿ��� �� ����
create role mrole2;

--��ü������ �ش� ����� �������� ����
--scott ���� emp�� �������ؼ� scott���� �����Ѱ�
grant select
on emp 
to mrole2;

--�� ������ ������ ���������� ����!!
grant mrole2
to user04;

--------------------------------- �� emp�� ��ȸ�� �ȵɱ� set role all;�� �ؾ����� ���̴µ� �� �� Ȱ��ȭ�� �ȵǴ°ɱ� 

create user user05 identified by  1234;

grant connect,resource
to user05;

grant select
on emp 
to mrole3;

-------------------------



