--����(Join)
--2���̻��� ���̺��� �����͸� ��ȸ
--from���� �ΰ� �̻��� ���̺��� �ۼ��Ѵ�.
--where�� join ������ �ۼ��Ѵ�.
--cross join // where �� ���� ���� // �� ������� ����
--equi join (where ������� : =)
--non equi join (where ���������� : and ,or)
--self join (where �ϳ��� ���̺��� ����Ѵ�)
--out join (where�� �����Ǵ� �����͸� ���� ��ȸ�ϱ����� : (+)) // [left, rigth, full] outer join

select emp.ename,emp.job,emp.deptno,dept.dname,dept.loc
from emp,dept 
where emp.deptno = dept.deptno;

select ename,job,emp.deptno,dname,loc
from emp,dept 
where emp.deptno = dept.deptno;

select ename,job,e.deptno,dname,loc
from emp e, dept d --���̺� ��Ī
where e.deptno = d.deptno;

select ename,job,e.deptno,dname,loc
from emp e, dept d --���̺� ��Ī
where e.deptno = d.deptno
and sal >= 3000;

select ename,sal,grade,losal,hisal
from emp e,salgrade s
where e.sal >= s.losal and e.sal <= s.hisal;

select ename,sal,grade,losal,hisal
from emp e,salgrade s
where e.sal between s.losal and s.hisal;

--���,�̸�,�޿�,�μ���ȣ,�μ���,�޿����

select empno,ename,sal,d.deptno,dname,grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno
and e.sal between s.losal and s.hisal;

select e.ename,e.mgr,m.ename
from emp e, emp m --�ݵ�� ��Ī�ο�***
where e.mgr = m.empno;

select ename,deptno
from emp e
where deptno = 20;

select work.ename, friend.ename
from emp work, emp friend 
where work.deptno = friend.deptno
and work.ename = 'SCOTT'
and friend.ename != 'SCOTT';

--�ܺ�����
--��� �����Ǵ� �����͸� ���� ��ȸ�ϱ� ���ؼ� ���
select e.ename,e.mgr,m.ename
from emp e, emp m --�ݵ�� ��Ī�ο�***
where e.mgr = m.empno(+); -- �����Ͱ� ���� ���̺��ʿ� (+)ǥ�ø� ���δ�.

select ename,sal,d.deptno,dname
from emp e, dept d
where e.deptno(+) = d.deptno;

--ANSI-JOIN(ǥ�����ι��)
--cross join
--inner join(equi, non equi, self join) 
--outer join((+)) 
--natural join // �� ������� ����
select ename,sal,dname,loc
from emp e inner join dept d
on e.deptno = d.deptno;

select ename,sal,dname,loc
from emp e inner join dept d
using(deptno); --���� ���̺��� �÷����� ������ ��� using(�÷���)

select e.empno,e.ename,e.mgr,m.ename --���� ���̺��� ������쿡 �տ� ��Ī�� ��� �ٿ��־���Ѵ�.
from emp e inner join emp m
on e.mgr = m.empno;

select empno,ename,sal,grade
from emp e inner join salgrade s
on e.sal between s.losal and s.hisal;

select e.empno,e.ename,e.mgr,m.ename
from emp e left outer join emp m -- �����Ͱ� �ִ� ���� �����Ѵ�.
on e.mgr = m.empno;

select empno,ename,sal,d.deptno,dname,grade
from emp e inner join dept d 
on e.deptno = d.deptno
inner join salgrade s
on e.sal between s.losal and s.hisal;

select ename,sal,d.deptno,dname
from emp e,dept d
where e.deptno(+) = d.deptno;

select e.empno,e.ename,d.deptno,d.dname
from emp e full outer join dept d
on e.deptno = d.deptno;

--8-1
select d.deptno,d.dname,e.empno,e.ename,e.sal
from emp e, dept d
where e.deptno = d.deptno
and sal > 2000;

select deptno,dname,empno,ename,sal
from emp  join dept using (deptno) --using() ��Ī���� ������ ���ѵȴ�.
where sal > 2000;

--8-2
select deptno,dname,
       trunc(avg(sal)) as AVG_SAL,
       max(sal) as MAX_SAL,
       min(sal) as MIN_SAL,
       count(*) as CNT
from emp join dept using (deptno) --��Ī ���� ������ ���ѵȴ�
group by deptno, dname;

--8-3
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e right outer join dept d
on e.deptno = d.deptno
order by d.deptno, e.ename;

--8-4
select d.deptno, d.dname, e.empno, e.ename, e.mgr, e.sal, e.deptno, s.losal, s.hisal, s.grade,
e2.empno as MGR_EMPNO ,e2.ename as MGR_ENAME
from emp e right outer join dept d
on e.deptno = d.deptno
left outer join salgrade s 
on e.sal between s.losal and s.hisal
left outer join emp e2
on e.mgr = e2.empno
order by d.deptno, e.ename;

--��������
--Ư���� ��츦 ������ ��� ��츦 �����ϸ� �������������� order by�� ����� �� ����.
--�����ڿ� ���� �� �Ǵ� ��ȸ����� �����ʿ� ���̸� ��ȣ�� ��� ����Ѵ�.
--
select* -- ��������
from emp -- ��������
where sal  > (select sal  --��������
             from emp --��������
             where ename = 'JONES');--��������

select dname
from dept
where deptno = (select deptno
                from emp
                where ename = 'SCOTT');
                
select ename,sal
from emp
where sal = (select max(sal)
             from emp);
             
--DALLAS
--�̸�, �μ���ȣ

select ename, deptno
from emp
where deptno = (select deptno
                from dept
                where loc = 'DALLAS');
                
--���� ����� king�� ����� �̸��� �޿��� ��ȸ�ϼ���

select ename, sal
from emp
where mgr = (select empno
               from emp
               where ename = 'KING'); 
               
select *
from emp
where sal in (5000,3000,2850);

--�� �׷쿡�� ���� ���� �޷Ḧ �޴� ������� ������
select*
from emp
where sal in (
            select max(sal)
            from emp
            group by deptno);
            
select*
from emp
where sal > any ( -- any�� ����Ҷ��� �ε�ȣ�� ����ؾ��Ѵ�. 
select max(sal)
from emp
group by deptno);
            
select ename, sal
from emp
where sal > all ( -- all�� ����Ҷ��� �ε�ȣ�� ����ؾ��Ѵ�. 
select sal
from emp
where deptno = 30);            

--������ ��������
--in ����߿� �ϳ��� �����ϸ� �ȴ�
-- > any : ����߿� �ϳ��̻� ���� ������ ���� ũ��ȴ� < any 
-- all : ����߿� ���� ū������ ũ��ȴ�
select*
from emp
where sal in (
            select max(sal)
            from emp
            group by deptno);

select*
from emp
where (deptno,sal) in ( 
select deptno,max(sal)
from emp
group by deptno);