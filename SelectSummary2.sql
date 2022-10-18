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

--�Լ� dual = �����ϰ� �Լ����� Ȯ���ϱ� ���� ����ϴ� ���̺�
--�����Լ� UPPER(��� ���ڸ� �빮�ڷκ�ȯ) LOWER(��� ���ڸ� �ҹ��ڷκ�ȯ) INITCAP(ù���ڸ� �빮�ڷκ�ȯ ������ ���ڴ� �ҹ��ڷ� ��ȯ)
select 'Welcom',upper('Welcome')
from dual;

select lower(ename),initcap(ename)
from emp;

select*
from emp
where ename = 'FORD';

select*
from emp
where lower(ename) = 'scott';

select ename,LENGTH(ename)
from emp;

select 'Welcome to Oracle',substr('Welcome to Oracle',-4,17)
from dual;

select instr('Welcome to Oracle','o')
from dual;

select instr('Welcome to Oracle','o',2)
from dual;

select instr('Welcome to Oracle','e',3,2)
from dual;

select replace('Welcome to Oracle','to',2)
from dual;

--select instr('Welcome to Oracle','e',3,2) (����,��ġã�⸦ ������ ��ġ, ���° ��������)
--select substr('Welcome to Oracle',-3,17) (����,��ġã�⸦ ������ ��ġ, �����)
--select replace('Welcome to Oracle','to','of') (����, �ٲ� ����, �ٲ���)

select 'oracle',
lpad('oracle', 10, '#') as lpad_1,
rpad('oracle', 10, '#') as rpad_1,
lpad('oracle', 10) as lpad_2,
rpad('oracle', 10) as rpad_2
from dual;

select rpad('940825-',14,'*')
from dual;

--lapd(���ڿ�,�������� �ڸ���, ������� ä�﹮��) as ���� �̸� �� �������� �е�
--Rapd(���ڿ�,�������� �ڸ���, ������� ä�﹮��) as ���� �̸� �� ���������� �е�

select concat(empno, ename), empno || '' || ename
from emp;
--concat�� �ΰ��� ���ڿ��� �ϳ��� ���ڿ��� �������ִ� ����

--�����Լ�
select round(1234.5678) as ROUND,
round(1234.5678, 1) as ROUND_1,
round(1234.5678, -1) as ROUND_MINUS1
from dual;
--round(����, �ݿø� �� ���� ��ġ����) as ���̸� // 1=�Ҽ��� ù°�ڸ� -1 = �����ڸ� as���̸��� �� �ʿ�� ����
--Ư����ġ���� �ݿø� �ϴ� round �Լ�

select trunc(1234.5678) as trunc,
trunc(1234.5678,1) as trunc_1,
trunc(1234.5678,-1) as turnc_minus2
from dual;
--trunc(����, ������ġ) as ���̸�  // 1=�Ҽ��� ù°�ڸ� -1 = �����ڸ� as���̸��� �� �ʿ�� ����
--Ư����ġ���� ������ trunc �Լ�

select ceil(3.14),
floor(3.14),
ceil(-3.14),
floor(-3.14)
from dual;
--ceil(����) �Էµ� ���ڿ� ���� ����� ū ���� 3.14 -> 4 -3.14 -> -3
--floor(����) �Էµ� ���ڿ� ���� ����� �������� 3.14 -> 3 -3.14 -> -4

select mod(15,6),
mod(10,2),
mod(11,2)   
from dual;

select*
from emp 
where mod(empno,2) = 1;

--mod(�������� �� ����, ��������) 
--���ڸ� ���� ������ ���� ���ϴ� mod �Լ�

--��¥�Լ�







