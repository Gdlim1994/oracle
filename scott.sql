--DQL(���Ǿ�)������ ��ȸ�� ���
--SELECT �÷���
--FROM ���̺��;

--��ü������
SELECT empno,ename,job,mgr,hiredate,sal,comm,deptno
From emp;


--�κ��÷� ������
select empno,ename,sal
from emp;
--��ü������ ���� 
SELECT
    * FROM emp;
    
select deptno
from emp;

select DISTINCT(sal)
from emp;
-- +,-,*,/ ��Ģ���길 ���� 
--�÷��� ������� �����Ѵ�.
--null ���� ���� �Ұ�.
--Ŀ�̼��� null�϶� ����ϴ� ��� null�� 0���� �ٲ��ش�.  nvl
--�÷��� ��Ī�� ����� �� �ִ�.  �÷� �ڿ� as ��Ī
select ename as �����,sal as ����,sal*12 + nvl(comm,0)as ���� ,comm
from emp;

--������ ����
--select �÷���
--from ���̺��
--order by �÷Ÿ� // (���ı����� �Ǵ� ��) asc(��������)�� ��������/desc(��������)
-- ����(1~10), ��¥(���ų�¥~�ֱٳ�¥),����(��������)

select*
FROM emp
ORDER BY sal desc;

select*
FROM emp
ORDER BY hiredate;

--������ ����
--select �÷���
--from ���̺��
--where ���ǽ�; <,>,=, != / <>, <=, >=, and, or
--and(��� ������ ���� ���) , or(������ �ϳ��� ���ΰ��) �� �߰��� �ؿ� ���´�
--and,or  ���������� ǥ���� �� ���.
--���ڸ� �������� ����Ҷ� ''�� ��ҹ��ڸ� ���� ��Ȯ�ϰ� �־��־���Ѵ�.

select*
FROM emp
where sal >= 6000
or deptno > 20 or comm > 300;

--��¥�� �������� ����Ҷ�
--''�� �� ����ؾ��Ѵ�.
--��¥�� ũ�Ⱑ �ִ�.
--80/12/20 -> 1980 12 20 �ð� �� �� ����
select*
FROM emp
where hiredate < '1982/01/01';

select*
FROM emp
where deptno = 10 and sal >= 2000;

-- not ������������
-- ������ ������ �����Ҷ� ���

select*
FROM emp
where sal != 3000;

select*
FROM emp
where not sal =  3000;

select*
FROM emp
where sal >=1000 and sal <= 3000;

select*
FROM emp
where sal <= 1000 or sal >=3000;

--between and
select*
FROM emp
where sal BETWEEN 1000 and 3000;

--in
select*
FROM emp
where sal = 800 or sal = 3000 or sal = 5000;

select*
FROM emp
where sal in (800,3000,5000);

--like������
--���� �Ϻθ� ������ �����͸� ��ȸ�Ѵ�.
--���̵� ī�带 ����Ѵ� (%[��繮�ڸ� ��ü�Ѵ�, _[�ѹ��ڸ� ��ü�Ѵ�])
select*
FROM emp
where ename like 'A%';

select*
FROM emp
where ename like '%D';

select*
FROM emp
where ename like '%O%';

select*
FROM emp
where ename like '___D';

select*
FROM emp
where ename like 'S___%';

--null ������
--is null / is not null
select*
FROM emp
where comm is not null;

--���տ�����
--2���� select ������ ����Ѵ�.
--�÷��� ������ �����ؾ��Ѵ�.
--�÷��� Ÿ���� �����ؾ��Ѵ�.
--�÷��� �̸��� �������.
--������(union), ������(interesct), ������(minus)

select empno,ename,sal,deptno
from emp
INTERSECT--���տ����ڸ� ���� �߰��� �׸��� ���� select�������� ;�� ������Ѵ�.
select empno,ename,sal,deptno
from emp
where deptno = 10;

--where
--�񱳿�����, ��������, like, is null / is not null, ���տ�����
--��,>,<=,>=,=,!=
--and,or,not, between and, in
--like (%,_)
--is null, is not null
--union, union all, minus, interesct

-- 1��
select*
FROM emp
where ename like '%S'; 

--2��
select EMPNO, ENAME, JOB, SAL, DEPTNO
FROM emp
where deptno like 30
and job = 'SALESMAN';

--3�� �ٸ� ���̺��� �������� in ���� ������ ����
select EMPNO, ENAME, JOB, SAL, DEPTNO
FROM emp
where deptno in (20,30)
and sal > 2000;

--4��
select *
FROM emp
where SAL < 2000
OR SAL > 3000;

--5��
select ENAME, EMPNO, SAL, DEPTNO
FROM emp
WHERE DEPTNO = 30
AND ENAME LIKE '%E%'
AND SAL NOT BETWEEN 1000 AND 2000;

--6��
select* 
FROM emp
where comm is null
AND MGR IS NOT NULL
AND JOB IN ('MANAGER', 'CLERK')
AND ENAME NOT LIKE '_L%';




