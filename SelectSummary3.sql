--조인(Join)
--2개이상의 테이블에서 데이터를 조회
--from절에 두개 이상의 테이블을 작성한다.
--where에 join 조건을 작성한다.
--cross join // where 절 없이 조인 // 잘 사용하지 않음
--equi join (where 등가연산자 : =)
--non equi join (where 범위연산자 : and ,or)
--self join (where 하나의 테이블을 사용한다)
--out join (where에 누락되는 데이터를 같이 조회하기위해 : (+)) // [left, rigth, full] outer join

select emp.ename,emp.job,emp.deptno,dept.dname,dept.loc
from emp,dept 
where emp.deptno = dept.deptno;

select ename,job,emp.deptno,dname,loc
from emp,dept 
where emp.deptno = dept.deptno;

select ename,job,e.deptno,dname,loc
from emp e, dept d --테이블에 별칭
where e.deptno = d.deptno;

select ename,job,e.deptno,dname,loc
from emp e, dept d --테이블에 별칭
where e.deptno = d.deptno
and sal >= 3000;

select ename,sal,grade,losal,hisal
from emp e,salgrade s
where e.sal >= s.losal and e.sal <= s.hisal;

select ename,sal,grade,losal,hisal
from emp e,salgrade s
where e.sal between s.losal and s.hisal;

--사번,이름,급여,부서번호,부서명,급여등급

select empno,ename,sal,d.deptno,dname,grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno
and e.sal between s.losal and s.hisal;

select e.ename,e.mgr,m.ename
from emp e, emp m --반드시 별칭부여***
where e.mgr = m.empno;

select ename,deptno
from emp e
where deptno = 20;

select work.ename, friend.ename
from emp work, emp friend 
where work.deptno = friend.deptno
and work.ename = 'SCOTT'
and friend.ename != 'SCOTT';

--외부조인
--등가시 누락되는 데이터를 같이 조회하기 위해서 사용
select e.ename,e.mgr,m.ename
from emp e, emp m --반드시 별칭부여***
where e.mgr = m.empno(+); -- 데이터가 없는 테이블쪽에 (+)표시를 붙인다.

select ename,sal,d.deptno,dname
from emp e, dept d
where e.deptno(+) = d.deptno;

--ANSI-JOIN(표준조인방식)
--cross join
--inner join(equi, non equi, self join) 
--outer join((+)) 
--natural join // 잘 사용하지 않음
select ename,sal,dname,loc
from emp e inner join dept d
on e.deptno = d.deptno;

select ename,sal,dname,loc
from emp e inner join dept d
using(deptno); --양쪽 테이블의 컬럼명이 동일한 경우 using(컬럼명)

select e.empno,e.ename,e.mgr,m.ename --양쪽 테이블이 같은경우에 앞에 별칭을 모두 붙여주어야한다.
from emp e inner join emp m
on e.mgr = m.empno;

select empno,ename,sal,grade
from emp e inner join salgrade s
on e.sal between s.losal and s.hisal;

select e.empno,e.ename,e.mgr,m.ename
from emp e left outer join emp m -- 데이터가 있는 쪽을 지정한다.
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
from emp  join dept using (deptno) --using() 별칭사용시 적용이 제한된다.
where sal > 2000;

--8-2
select deptno,dname,
       trunc(avg(sal)) as AVG_SAL,
       max(sal) as MAX_SAL,
       min(sal) as MIN_SAL,
       count(*) as CNT
from emp join dept using (deptno) --별칭 사용시 적용이 제한된다
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

--서브쿼리
--특수한 경우를 제외한 몇몇 경우를 제외하면 서브쿼리에서는 order by를 사용할 수 없다.
--연산자와 같은 비교 또는 조회대상의 오른쪽에 놓이며 괄호로 묶어서 사용한다.
--
select* -- 메인쿼리
from emp -- 메인쿼리
where sal  > (select sal  --서브쿼리
             from emp --서브쿼리
             where ename = 'JONES');--서브쿼리

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
--이름, 부서번호

select ename, deptno
from emp
where deptno = (select deptno
                from dept
                where loc = 'DALLAS');
                
--직속 상관이 king인 사원의 이름과 급여를 조회하세요

select ename, sal
from emp
where mgr = (select empno
               from emp
               where ename = 'KING'); 
               
select *
from emp
where sal in (5000,3000,2850);

--각 그룹에서 가장 많은 급료를 받는 사람들의 데이터
select*
from emp
where sal in (
            select max(sal)
            from emp
            group by deptno);
            
select*
from emp
where sal > any ( -- any를 사용할때는 부등호를 사용해야한다. 
select max(sal)
from emp
group by deptno);
            
select ename, sal
from emp
where sal > all ( -- all를 사용할때는 부등호를 사용해야한다. 
select sal
from emp
where deptno = 30);            

--다중행 서브쿼리
--in 결과중에 하나만 만족하면 된다
-- > any : 결과중에 하나이상 가장 작은값 보다 크면된다 < any 
-- all : 결과중에 가장 큰값보다 크면된다
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