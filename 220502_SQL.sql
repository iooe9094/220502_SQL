-- 2022-05-02 실습
-- 왼쪽 자리를 특정 기호로 채우는 내장함수
SELECT LPAD(SALARY, 10, '*') FROM EMPLOYEE;

DESC EMPLOYEE;

-- RPAD(컬럼명, 자리수, 채울문자)
-- 오른쪽(RIGHT) 자리를 특정 기호로 채우는(PAD) 내장함수
SELECT RPAD(SALARY, 10, '*') FROM EMPLOYEE;

-- LTRIM(문자열) : 왼쪽 공백 제거
-- RTRIM(문자열) : 오른쪽 공백 제거
-- TRIM(문자열) : 양쪽 공백 제거
SELECT '  Oracle mania  ',
   LTRIM( '  Oracle mania  ' ),
   RTRIM( '  Oracle mania   '),
   TRIM( '  Oracle mania   ')
FROM DUAL;

-- 숫자 함수
-- ROUND(실수, 반올림할자리수(생략)) : 특정 자리수에서 반올림하는 내장 함수
SELECT 98.7654,
   ROUND(98.7654), -- 첫째 반올림
   ROUND(98.7654, 2), -- 둘째 반올림(매개변수에 2개 짜리 저장)
   ROUND (98.7654, -1) -- 정수 1자리 반올림
FROM DUAL;

--TRUNC : 특정 자리수에서 버림
SELECT 98.7654,
   TRUNC(98.7654), -- 첫째 자리 버림
   TRUNC(98.7654, 2), -- 둘째 자리 버림
   TRUNC(98.7654, -1) -- 정수 1자리 버림
FROM DUAL;

-- MOD : 첫 번째 값을 두 번째 값으로 나눈 나머지를 반환 (JAVA, JS의 %)
SELECT MOD(31,2),
    MOD(31, 5),
    MOD(31, 8)
FROM DUAL;

-- 문제 1) 모든 사원의 급여를 500으로 나눈 나머지를 계산해서 출력해 보세요
-- 사원 테이블 : EMPLOYEE, 급여 컬럼 : SALARY
SELECT ENAME, SALARY, MOD(SALARY, 500) FROM EMPLOYEE;

-- 날짜 함수
-- 시스템에 저장된 현재 날짜를 반환하는 변수
SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

-- 날짜 연산
SELECT 
   SYSDATE - 1 AS "어제", -- 오늘날짜에서 하루를 뺀 어제 날짜
   SYSDATE AS "오늘", -- 오늘날짜
   SYSDATE + 1 AS "내일" -- 오늘날짜에서 하루를 더한 내일 날짜
FROM DUAL;

-- 도전과제) 사원들의 현재까지의 근무일수 구하기
-- 단, 실수로 나오면 반올림하기
SELECT ENAME, ROUND(SYSDATE - HIREDATE) AS "근무일수" FROM EMPLOYEE;

-- 날짜와 날짜 사이의 개월 수를 구하는 내장 함수
-- MONTHS_BETWEEN(현재날짜, 과거날짜)
SELECT ENAME, SYSDATE, HIREDATE,
     ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS 개월수 -- 위아래 같음
     -- TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS 개월수
FROM EMPLOYEE;

-- 입사한 지 6개월 지난 날짜를 구하고 싶은 1인
-- ADD_MONTHS (날짜컬럼, 더할 개월수) : 날짜컬럼 + 6개월
SELECT ENAME, HIREDATE,
   ADD_MONTHS(HIREDATE, 6) AS "6개월후"
FROM EMPLOYEE;

-- 오늘을 기준으로 최초로 도래하는 토요일 구하기
-- NEXT_DAY (날짜, 요일)
SELECT SYSDATE,
    NEXT_DAY (SYSDATE, '토요일') AS "이번주 토요일",
    NEXT_DAY (SYSDATE, 7) AS "숫자로 이번 주 토요일"
FROM DUAL;

-- 입사한 날의 마지막 날 구하기
-- LAST_DAY (날짜컬럼) : 그 달의 마지막 날을 반환
SELECT ENAME, HIREDATE,
    LAST_DAY(HIREDATE)
FROM EMPLOYEE;

-- 자료형 변환 함수
-- TO_CHAR : 날짜형 또는 숫자형을 문자형으로 변환하는 내장함수
SELECT ENAME, HIREDATE,
    TO_CHAR(HIREDATE, 'YY-MM') AS "년도(2자리)월",
    TO_CHAR(HIREDATE, 'YY-MM-DD DAY') AS "년도(4자리)월일 요일",
    TO_CHAR(HIREDATE, 'YY-MM-DD HH24:MI:SS') AS "자주 쓰는 포맷"
FROM EMPLOYEE;

-- TO_CHAR : 숫자를 지정된 포맷을 가진 문자열로 반환
-- 9 : 자리수를 나타냄, 자리수가 맞지 않으면 공간을 채우지 않음
-- 0 : 자리수를 나타냄, 자리수가 맞지 않으면 0으로 채움
-- L : 각 나라별 통화 기호를 앞에 표시해 줌
-- , : 천 단위 자리 구분을 위해 표시
SELECT ENAME, SALARY,
    TO_CHAR(SALARY, 'L999,999') AS "돈 표시",
    TO_CHAR(SALARY, 'L000,000') AS "돈 표시2"
FROM EMPLOYEE;

-- TO_DATE : 문자를 날짜로 변환하는 내장 함수
-- 도전과제) 1981년 2월 20일에 입사한 사원 검색하기
-- 사원 테이블 : EMPLOYEE / 입사일컬럼 : HIREDATE
SELECT ENAME, HIREDATE FROM EMPLOYEE WHERE HIREDATE=TO_DATE('19810220', 'YYYYMMDD');

-- 문자를 숫자로 바꾸는 내장 함수
-- TO_NUMBER(문자열숫자, 지정포맷) : 문자열을 지정된 포맷의 숫자로 바꾸기
SELECT TO_NUMBER('100,000', '999,999')
           - TO_NUMBER('50,000','999,999') 
FROM DUAL;

-- 연습문제 1) SUBSTR 함수를 사용하여 사원들의 입사한 연도와 입사한 달을 출력하기
-- SUBSTR(대상문자열, 자를위치, 길이)
SELECT ENAME, 
    SUBSTR(HIREDATE, 1, 2) AS "연도",
    SUBSTR(HIREDATE, 4, 2) AS "월",
    SUBSTR(HIREDATE, 7, 2) AS "일"
FROM EMPLOYEE;

-- 연습문제 2) SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력하기
SELECT * FROM EMPLOYEE WHERE SUBSTR(HIREDATE, 4, 2) = 04;

-- 연습문제 3) 사번이 짝수인 사원 출력하기
-- MOD 내장 함수를 사용하세요.
SELECT * FROM EMPLOYEE WHERE MOD(ENO, 2) = 0;

-- 연습문제 4) 올해 며칠이 지났는지 출력하시오. 
--                  현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하기
--                  TO_DATE 함수를 사용해서 형을 일치시켜 계산하기
SELECT ROUND(SYSDATE)
           - ROUND(TO_DATE('20220101', 'YYMMDD')) AS "올해부터 현재까지"
FROM DUAL;

-- 일반함수
-- NULL이면 0 또는 다른 값으로 바꾸는 내장 함수
-- NVL (NULL이 포함된 컬럼, 바꿀값)
SELECT ENAME, SALARY, COMMISSION,
    NVL(COMMISSION, 0) AS "보너스",
    SALARY * 12 + NVL(COMMISSION, 0) AS "연봉"
FROM EMPLOYEE ORDER BY JOB;

-- NVL2
-- NVL2(컬럼값, 표현식1, 표현식2)
-- 컬럼값이 NULL이면 표현식1을 반환하고, NULL이 아니면 표현식2를 반환.
SELECT ENAME, SALARY, COMMISSION,
    NVL2(COMMISSION, SALARY*12 + COMMISSION, SALARY*12)
FROM EMPLOYEE ORDER BY JOB;

-- NULLIF(표현식1, 표현식2)
-- 표현식1 == 표현식2 NULL 출력, 아니면 표현식1을 출력
SELECT NULLIF('A', 'A'),
           NULLIF('A', 'B')
FROM DUAL;

-- 오라클에서 IF/ ELSE 방법
-- DECODE(표현식, 조건1, 결과1 .... , 기본결과)
SELECT ENAME, DNO,
     DECODE(DNO, 10, '회계부',
                          20, '연구소',
                          30, '영업부',
                          40, '운영팀',
                          'DEFAULT') AS "부서이름"
FROM EMPLOYEE ORDER BY DNO;

-- 또다른 방식 IF / ELSE IF / ELSE 방법
SELECT ENAME, DNO,
     CASE WHEN DNO =  10 THEN '회계부'
             WHEN DNO =  20 THEN '연구소'
             WHEN DNO =  30 THEN '영업부'
             WHEN DNO =  40 THEN '운영팀'
             ELSE 'DEFAULT' 
     END AS "부서이름"
FROM EMPLOYEE ORDER BY DNO;

-- 연습문제 5) 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 NULL값 대신 0을 출력
-- 사원테이블 : EMPLOYEE / 상관컬럼 : MANAGER
SELECT ENO, ENAME, 
           --NVL(MANAGER, 0),
           NVL2(MANAGER, MANAGER, 0) AS MANAGER 
FROM EMPLOYEE;

-- 연습문제 6) (DECODE, CASE WHEN) 함수로 직급에 따라 급여를 인상하도록 하세요.
-- ANALYST : 200 / SALESMAN : 180 / MANAGER : 150 / CLERK : 100
SELECT ENO, ENAME, JOB, SALARY,
    CASE WHEN JOB = 'ANALYST' THEN '200'
            WHEN JOB = 'SALESMAN' THEN '180'
            WHEN JOB = 'MANAGER' THEN '150'
            WHEN JOB = 'CLERK' THEN '100'
            ELSE 'DEFAULT'
    END AS "급여 인상"
FROM EMPLOYEE ORDER BY JOB;

-- 연습문제 6 DECADE 사용했을 경우
SELECT ENO, ENAME, JOB, SALARY,
           DECODE(JOB, 'ANALYST', SALARY+200,
                               'SALESMAN', SALARY+180,
                               'MANAGER', SALARY+150,
                               'CLERK', SALARY+100,
                               SALARY) AS "급여 인상"
FROM EMPLOYEE;
