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

--함수 dual = 간단하게 함수값을 확인하기 위해 사용하는 테이블
--문자함수 UPPER(모든 문자를 대문자로변환) LOWER(모든 문자를 소문자로변환) INITCAP(첫문자를 대문자로변환 나머지 문자는 소문자로 변환)
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

--select instr('Welcome to Oracle','e',3,2) (문자,위치찾기를 시작할 위치, 몇번째 문자인지)
--select substr('Welcome to Oracle',-3,17) (문자,위치찾기를 시작할 위치, 몇글자)
--select replace('Welcome to Oracle','to','of') (문자, 바꿀 문자, 바뀔문자)

select 'oracle',
lpad('oracle', 10, '#') as lpad_1,
rpad('oracle', 10, '#') as rpad_1,
lpad('oracle', 10) as lpad_2,
rpad('oracle', 10) as rpad_2
from dual;

select rpad('940825-',14,'*')
from dual;

--lapd(문자열,데이터의 자릿수, 빈공간에 채울문자) as 열의 이름 행 왼쪽으로 패딩
--Rapd(문자열,데이터의 자릿수, 빈공간에 채울문자) as 열의 이름 행 오른쪽으로 패딩

select concat(empno, ename), empno || '' || ename
from emp;
--concat는 두개의 문자열을 하나의 문자열로 연결해주는 역할

--숫자함수
select round(1234.5678) as ROUND,
round(1234.5678, 1) as ROUND_1,
round(1234.5678, -1) as ROUND_MINUS1
from dual;
--round(숫자, 반올림 된 숫자 위치선택) as 열이름 // 1=소숫점 첫째자리 -1 = 일의자리 as열이름은 꼭 필요는 없음
--특정위치에서 반올림 하는 round 함수

select trunc(1234.5678) as trunc,
trunc(1234.5678,1) as trunc_1,
trunc(1234.5678,-1) as turnc_minus2
from dual;
--trunc(숫자, 버림위치) as 열이름  // 1=소숫점 첫째자리 -1 = 일의자리 as열이름은 꼭 필요는 없음
--특정위치에서 버리는 trunc 함수

select ceil(3.14),
floor(3.14),
ceil(-3.14),
floor(-3.14)
from dual;
--ceil(숫자) 입력된 숫자와 가장 가까운 큰 정수 3.14 -> 4 -3.14 -> -3
--floor(숫자) 입력된 숫자와 가장 가까운 작은정수 3.14 -> 3 -3.14 -> -4

select mod(15,6),
mod(10,2),
mod(11,2)   
from dual;

select*
from emp 
where mod(empno,2) = 1;

--mod(나눗셈이 될 숫자, 나눌숫자) 
--숫자를 나눈 나머지 값을 구하는 mod 함수

--날짜함수







