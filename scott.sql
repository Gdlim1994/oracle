--DQL(질의어)데이터 조회시 사용
--SELECT 컬럼명
--FROM 테이블명;

--전체데이터
SELECT empno,ename,job,mgr,hiredate,sal,comm,deptno
From emp;


--부분컬럼 데이터
select empno,ename,sal
from emp;
--전체데이터 사용시 
SELECT
    * FROM emp;
    
select deptno
from emp;

select DISTINCT(sal)
from emp;
-- +,-,*,/ 사칙연산만 가능 
--컬럼을 대상으로 연산한다.
--null 값은 연산 불가.
--커미션이 null일때 계산하는 방법 null을 0으로 바꿔준다.  nvl
--컬럼에 별칭을 사용할 수 있다.  컬럼 뒤에 as 별칭
select ename as 사원명,sal as 월급,sal*12 + nvl(comm,0)as 연봉 ,comm
from emp;

--데이터 정렬
--select 컬럼명
--from 테이블명
--order by 컬렴명 // (정렬기준이 되는 값) asc(오름차순)은 생략가능/desc(내림차순)
-- 숫자(1~10), 날짜(과거날짜~최근날짜),문자(사전순서)

select*
FROM emp
ORDER BY sal desc;

select*
FROM emp
ORDER BY hiredate;

--데이터 정렬
--select 컬럼명
--from 테이블명
--where 조건식; <,>,=, != / <>, <=, >=, and, or
--and(모든 조건이 참인 경우) , or(조건이 하나라도 참인경우) 은 추가로 밑에 적는다
--and,or  범위조건을 표현할 때 사용.
--문자를 조건절에 사용할때 ''와 대소문자를 따져 정확하게 넣어주어야한다.

select*
FROM emp
where sal >= 6000
or deptno > 20 or comm > 300;

--날짜를 조건절에 사용할때
--''를 꼭 사용해야한다.
--날짜도 크기가 있다.
--80/12/20 -> 1980 12 20 시간 분 초 요일
select*
FROM emp
where hiredate < '1982/01/01';

select*
FROM emp
where deptno = 10 and sal >= 2000;

-- not 논리부정연산자
-- 현재의 조건을 부정할때 사용

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

--like연산자
--값의 일부만 가지고 데이터를 조회한다.
--와이드 카드를 사용한다 (%[모든문자를 대체한다, _[한문자를 대체한다])
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

--null 연산자
--is null / is not null
select*
FROM emp
where comm is not null;

--집합연산자
--2개의 select 구문을 사용한다.
--컬럼의 갯수가 동일해야한다.
--컬럼의 타입이 동일해야한다.
--컬럼의 이름은 상관없다.
--합집합(union), 교집합(interesct), 차집합(minus)

select empno,ename,sal,deptno
from emp
INTERSECT--집합연산자를 구문 중간에 그리고 앞의 select구문에는 ;를 빼줘야한다.
select empno,ename,sal,deptno
from emp
where deptno = 10;

--where
--비교연산자, 논리연산자, like, is null / is not null, 집합연산자
--ㅡ,>,<=,>=,=,!=
--and,or,not, between and, in
--like (%,_)
--is null, is not null
--union, union all, minus, interesct

-- 1번
select*
FROM emp
where ename like '%S'; 

--2번
select EMPNO, ENAME, JOB, SAL, DEPTNO
FROM emp
where deptno like 30
and job = 'SALESMAN';

--3번 다른 테이블을 쓸떼에는 in 말고 집합을 쓰자
select EMPNO, ENAME, JOB, SAL, DEPTNO
FROM emp
where deptno in (20,30)
and sal > 2000;

--4번
select *
FROM emp
where SAL < 2000
OR SAL > 3000;

--5번
select ENAME, EMPNO, SAL, DEPTNO
FROM emp
WHERE DEPTNO = 30
AND ENAME LIKE '%E%'
AND SAL NOT BETWEEN 1000 AND 2000;

--6번
select* 
FROM emp
where comm is null
AND MGR IS NOT NULL
AND JOB IN ('MANAGER', 'CLERK')
AND ENAME NOT LIKE '_L%';




