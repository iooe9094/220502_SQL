-- 그룹함수
-- SUM : 누적합계를 반환
-- AVG : 그룹의 평균을 반환
-- COUNT : 그룹의 개수를 반환
-- MAX : 그룹의 최대값을 반환
-- MIN : 그룹의 최소값을 반환

SELECT SUM(SALARY) AS "급여 총액",
           TRUNC (AVG(SALARY)) AS "급여 평균",
           MAX(SALARY) AS "최대 급여",
           MIN(SALARY) AS "최저 급여"
FROM EMPLOYEE;

-- 문제 4) 최근에 입사한 사원과 가장 오래전에 입사한 사원의 입사일 출력하기
-- 사원 : EMPLOYEE / 입사일컬럼 : HIREDATE
SELECT MAX(HIREDATE) AS "최근 입사",
           MIN(HIREDATE) AS "오래전 입사"
FROM EMPLOYEE;

-- 그룹함수 VS NULL
-- 그룹함수에서는 NULL을 내부적으로 제외하고 계산함
SELECT SUM(COMMISSION) AS "커미션"
FROM EMPLOYEE;

-- COUNT : 건 수 세기
SELECT COUNT(*)
FROM EMPLOYEE;
-- COMMISSION을 받는 사원의 수를 알고 싶을 경우
-- 그룹함수는 NULL을 제외하기 때문에 COMMISSION 개수 구할 수 있음
SELECT COUNT(COMMISSION)
FROM EMPLOYEE
WHERE COMMISSION IS NOT NULL;
-- 활용 예시 -> 중복 제거 전
SELECT COUNT(JOB) AS "직업의 개수"
FROM EMPLOYEE;
-- 활용 예시 -> 중복 제거 후 (DISTINCT)
SELECT COUNT(DISTINCT JOB) AS "중복 제거 직업의 개수"
FROM EMPLOYEE;

-- 그룹 함수 사용 시 유의할 점
-- 1. 일반 컬럼과 함께 사용 불가능, 그룹함수끼리 사용
SELECT COUNT(ENO), MAX(SALARY)
FROM EMPLOYEE;

-- ** GROUP BY 절
-- 그룹함수 : 하나의 결과값을 보여줌(COUNT, MAX, SUM)
-- 예시) 부서별로 평균 급여를 알고 싶을 경우
-- GROUP BY 컬럼명 -> SELECT 컬럼명 동일해야함
-- 아래처럼 SELECT DNO의 경우 GROUP BY DNO처럼 DNO 맞춰야함
SELECT DNO AS "부서번호",
           AVG(SALARY) AS "평균급여"
FROM EMPLOYEE
GROUP BY DNO; -- 부서 번호로 그룹화

-- 잘못된 사용법 : ENAME -> GROUP BY 절에 없는 컬럼이므로 실행 X
SELECT DNO AS "부서번호",
           ENAME,
           TRUNC(AVG(SALARY)) AS "평균급여"
FROM EMPLOYEE
GROUP BY DNO; -- 부서 번호로 그룹핑

-- 도전과제) 부서별, 직급별 총 급여를 계산하여 출력
-- 부서: DNO / 직급: JOB / 대상테이블: EMPLOYEE
-- 단, 부서별, 직급별로 오름차순으로 정렬
SELECT DNO AS "부서번호",
           JOB AS "직급",
           SUM(SALARY) AS "총 급여의 합"
FROM EMPLOYEE
GROUP BY DNO, JOB
ORDER BY SUM(SALARY) DESC;

-- GROUP BY 절에 조건걸기 (HAVING)
-- HAVING + 조건
-- 부서별로 최대 급여를 구하는데 3000 이상 되는 것만 출력하기
SELECT DNO, 
           MAX(SALARY) 
FROM EMPLOYEE
GROUP BY DNO
HAVING MAX(SALARY) > 3000;

-- 도전과제) 1. MANAGER를 제외하고 2. 급여 총액이 5000 이상인 직급별 급여 총액(SUM) 구하기
SELECT JOB AS 직급,
           SUM(SALARY) AS 급여총액
FROM EMPLOYEE
WHERE JOB NOT LIKE '%MANAGER%'
GROUP BY JOB
HAVING SUM(SALARY) >= 5000
ORDER BY SUM(SALARY) DESC;

-- 연습문제 1) 모든 사원의 최대 급여와 최저 급여, 총액, 평균 급여를 출력하기
-- 컬럼의 별칭 : 최대급여, 최저급여, 급여총액, 급여평균 / 실수일 경우 반올림 처리
SELECT MAX(SALARY) AS 최대급여,
           MIN(SALARY) AS 최저급여,
           SUM(SALARY) AS 급여총액,
           ROUND(AVG(SALARY)) AS 급여평균
FROM EMPLOYEE;

-- 연습문제 2) 각 담당 업무 유형별로 최대급여, 최저급여, 총액 및 평균을 출력하기
SELECT JOB,
           MAX(SALARY) AS 최대급여,
           MIN(SALARY) AS 최저급여,
           SUM(SALARY) AS 급여총액,
           ROUND(AVG(SALARY)) AS 급여평균
FROM EMPLOYEE
GROUP BY JOB;

-- 연습문제 3) COUNT(*) 함수를 이용하여 담당 업무가 동일한 사원 수를 출력하기
SELECT JOB,
           COUNT(JOB)
FROM EMPLOYEE
GROUP BY JOB;

-- 연습문제 4) 관리자 수를 나열하기
SELECT MANAGER, 
           COUNT(MANAGER) -- COUNT는 NULL값 제외하고 계산 처리
FROM EMPLOYEE
GROUP BY MANAGER;

-- 연습문제 5) 최대급여, 최저급여의 차액을 출력하기
SELECT MAX(SALARY)
           - MIN(SALARY) AS 급여차액
FROM EMPLOYEE;

-- 연습문제 6) 직급별 사원의 최저 급여를 출력하고, 
-- 관리자를 알 수 없는 사원 및 최저 급여가 2000 미만인 그룹은 제외하고 급여에 대한 내림차순 정렬하기
SELECT JOB,
           MIN(SALARY)
FROM EMPLOYEE
WHERE MANAGER IS NOT NULL -- 관리자를 알 수 없는 사원 
GROUP BY JOB -- 그룹함수는 NULL은 제외가 된다
HAVING  NOT MIN(SALARY) < 2000 -- HAVING MIN(SALARY) > 2000
ORDER BY MIN(SALARY) DESC;

-- 연습문제 7) 각 부서에 대해 부서번호, 사원수, 부서 내 모든 사원의 평균 급여를 출력
--                  평균급여는 소수점 두 번째 반올림 처리
SELECT DNO AS 부서번호,
           COUNT(*) 사원수,
           ROUND(AVG(SALARY), 2) AS 평균급여
FROM EMPLOYEE
GROUP BY DNO, JOB;

-- 연습문제 8) 각 부서에 대해 부서이름, 지역명, 사원수, 부서별 사원 평균 급여 출력 (DECODE, CASE WHEN)
-- 1차 DECODE(CASE WHEN) 빼고 구하기
--SELECT DNO,
--           COUNT(*) AS "사원수",
--           TRUNC(AVG(SALARY)) AS "평균급여"
--FROM EMPLOYEE
--GROUP BY DNO;
-- 2차 DECODE(CASE WHEN) 합해서 구하기
SELECT DECODE(DNO,10, 'ACCOUNTING',
                                20, 'RESEARCH',
                                30, 'SALES',
                                40, 'OPERATION') AS 부서이름,
           DECODE(DNO,10, 'ACCOUNTING',
                                20, 'DALLAS',
                                30, 'CHICAGO',
                                40, 'BOSTON') AS 지역명,
           COUNT(*) AS "사원수",
           TRUNC(AVG(SALARY)) AS "평균급여"
FROM EMPLOYEE
GROUP BY DNO;

-- 조인
-- 사원 번호가 7788인 직원의 부서명은 ?
SELECT DNO FROM EMPLOYEE WHERE ENO = 7788;

SELECT DNAME FROM DEPARTMENT WHERE DNO = 20;

SELECT COUNT(*) FROM EMPLOYEE;
SELECT COUNT(*) FROM DEPARTMENT;

-- 성능을 좋게 하기 위해서는 목록이 작은 것을 FROM 앞에서 사용
-- 일반 JOIN(EQUAL(=) JOIN, INNER JOIN) : 교집합
SELECT A.DNO, A.DNAME, A.LOC
           FROM DEPARTMENT A,
           EMPLOYEE B
WHERE B.DNO = A.DNO;
-- AS 생략 가능
           
           
           