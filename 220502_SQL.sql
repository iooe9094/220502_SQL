-- 2022-05-02 �ǽ�
-- ���� �ڸ��� Ư�� ��ȣ�� ä��� �����Լ�
SELECT LPAD(SALARY, 10, '*') FROM EMPLOYEE;

DESC EMPLOYEE;

-- RPAD(�÷���, �ڸ���, ä�﹮��)
-- ������(RIGHT) �ڸ��� Ư�� ��ȣ�� ä���(PAD) �����Լ�
SELECT RPAD(SALARY, 10, '*') FROM EMPLOYEE;

-- LTRIM(���ڿ�) : ���� ���� ����
-- RTRIM(���ڿ�) : ������ ���� ����
-- TRIM(���ڿ�) : ���� ���� ����
SELECT '  Oracle mania  ',
   LTRIM( '  Oracle mania  ' ),
   RTRIM( '  Oracle mania   '),
   TRIM( '  Oracle mania   ')
FROM DUAL;

-- ���� �Լ�
-- ROUND(�Ǽ�, �ݿø����ڸ���(����)) : Ư�� �ڸ������� �ݿø��ϴ� ���� �Լ�
SELECT 98.7654,
   ROUND(98.7654), -- ù° �ݿø�
   ROUND(98.7654, 2), -- ��° �ݿø�(�Ű������� 2�� ¥�� ����)
   ROUND (98.7654, -1) -- ���� 1�ڸ� �ݿø�
FROM DUAL;

--TRUNC : Ư�� �ڸ������� ����
SELECT 98.7654,
   TRUNC(98.7654), -- ù° �ڸ� ����
   TRUNC(98.7654, 2), -- ��° �ڸ� ����
   TRUNC(98.7654, -1) -- ���� 1�ڸ� ����
FROM DUAL;

-- MOD : ù ��° ���� �� ��° ������ ���� �������� ��ȯ (JAVA, JS�� %)
SELECT MOD(31,2),
    MOD(31, 5),
    MOD(31, 8)
FROM DUAL;

-- ���� 1) ��� ����� �޿��� 500���� ���� �������� ����ؼ� ����� ������
-- ��� ���̺� : EMPLOYEE, �޿� �÷� : SALARY
SELECT ENAME, SALARY, MOD(SALARY, 500) FROM EMPLOYEE;

-- ��¥ �Լ�
-- �ý��ۿ� ����� ���� ��¥�� ��ȯ�ϴ� ����
SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

-- ��¥ ����
SELECT 
   SYSDATE - 1 AS "����", -- ���ó�¥���� �Ϸ縦 �� ���� ��¥
   SYSDATE AS "����", -- ���ó�¥
   SYSDATE + 1 AS "����" -- ���ó�¥���� �Ϸ縦 ���� ���� ��¥
FROM DUAL;

-- ��������) ������� ��������� �ٹ��ϼ� ���ϱ�
-- ��, �Ǽ��� ������ �ݿø��ϱ�
SELECT ENAME, ROUND(SYSDATE - HIREDATE) AS "�ٹ��ϼ�" FROM EMPLOYEE;

-- ��¥�� ��¥ ������ ���� ���� ���ϴ� ���� �Լ�
-- MONTHS_BETWEEN(���糯¥, ���ų�¥)
SELECT ENAME, SYSDATE, HIREDATE,
     ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS ������ -- ���Ʒ� ����
     -- TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS ������
FROM EMPLOYEE;

-- �Ի��� �� 6���� ���� ��¥�� ���ϰ� ���� 1��
-- ADD_MONTHS (��¥�÷�, ���� ������) : ��¥�÷� + 6����
SELECT ENAME, HIREDATE,
   ADD_MONTHS(HIREDATE, 6) AS "6������"
FROM EMPLOYEE;

-- ������ �������� ���ʷ� �����ϴ� ����� ���ϱ�
-- NEXT_DAY (��¥, ����)
SELECT SYSDATE,
    NEXT_DAY (SYSDATE, '�����') AS "�̹��� �����",
    NEXT_DAY (SYSDATE, 7) AS "���ڷ� �̹� �� �����"
FROM DUAL;

-- �Ի��� ���� ������ �� ���ϱ�
-- LAST_DAY (��¥�÷�) : �� ���� ������ ���� ��ȯ
SELECT ENAME, HIREDATE,
    LAST_DAY(HIREDATE)
FROM EMPLOYEE;

-- �ڷ��� ��ȯ �Լ�
-- TO_CHAR : ��¥�� �Ǵ� �������� ���������� ��ȯ�ϴ� �����Լ�
SELECT ENAME, HIREDATE,
    TO_CHAR(HIREDATE, 'YY-MM') AS "�⵵(2�ڸ�)��",
    TO_CHAR(HIREDATE, 'YY-MM-DD DAY') AS "�⵵(4�ڸ�)���� ����",
    TO_CHAR(HIREDATE, 'YY-MM-DD HH24:MI:SS') AS "���� ���� ����"
FROM EMPLOYEE;

-- TO_CHAR : ���ڸ� ������ ������ ���� ���ڿ��� ��ȯ
-- 9 : �ڸ����� ��Ÿ��, �ڸ����� ���� ������ ������ ä���� ����
-- 0 : �ڸ����� ��Ÿ��, �ڸ����� ���� ������ 0���� ä��
-- L : �� ���� ��ȭ ��ȣ�� �տ� ǥ���� ��
-- , : õ ���� �ڸ� ������ ���� ǥ��
SELECT ENAME, SALARY,
    TO_CHAR(SALARY, 'L999,999') AS "�� ǥ��",
    TO_CHAR(SALARY, 'L000,000') AS "�� ǥ��2"
FROM EMPLOYEE;

-- TO_DATE : ���ڸ� ��¥�� ��ȯ�ϴ� ���� �Լ�
-- ��������) 1981�� 2�� 20�Ͽ� �Ի��� ��� �˻��ϱ�
-- ��� ���̺� : EMPLOYEE / �Ի����÷� : HIREDATE
SELECT ENAME, HIREDATE FROM EMPLOYEE WHERE HIREDATE=TO_DATE('19810220', 'YYYYMMDD');

-- ���ڸ� ���ڷ� �ٲٴ� ���� �Լ�
-- TO_NUMBER(���ڿ�����, ��������) : ���ڿ��� ������ ������ ���ڷ� �ٲٱ�
SELECT TO_NUMBER('100,000', '999,999')
           - TO_NUMBER('50,000','999,999') 
FROM DUAL;

-- �������� 1) SUBSTR �Լ��� ����Ͽ� ������� �Ի��� ������ �Ի��� ���� ����ϱ�
-- SUBSTR(����ڿ�, �ڸ���ġ, ����)
SELECT ENAME, 
    SUBSTR(HIREDATE, 1, 2) AS "����",
    SUBSTR(HIREDATE, 4, 2) AS "��",
    SUBSTR(HIREDATE, 7, 2) AS "��"
FROM EMPLOYEE;

-- �������� 2) SUBSTR �Լ��� ����Ͽ� 4���� �Ի��� ����� ����ϱ�
SELECT * FROM EMPLOYEE WHERE SUBSTR(HIREDATE, 4, 2) = 04;

-- �������� 3) ����� ¦���� ��� ����ϱ�
-- MOD ���� �Լ��� ����ϼ���.
SELECT * FROM EMPLOYEE WHERE MOD(ENO, 2) = 0;

-- �������� 4) ���� ��ĥ�� �������� ����Ͻÿ�. 
--                  ���� ��¥���� ���� 1�� 1���� �� ����� ����ϱ�
--                  TO_DATE �Լ��� ����ؼ� ���� ��ġ���� ����ϱ�
SELECT ROUND(SYSDATE)
           - ROUND(TO_DATE('20220101', 'YYMMDD')) AS "���غ��� �������"
FROM DUAL;

-- �Ϲ��Լ�
-- NULL�̸� 0 �Ǵ� �ٸ� ������ �ٲٴ� ���� �Լ�
-- NVL (NULL�� ���Ե� �÷�, �ٲܰ�)
SELECT ENAME, SALARY, COMMISSION,
    NVL(COMMISSION, 0) AS "���ʽ�",
    SALARY * 12 + NVL(COMMISSION, 0) AS "����"
FROM EMPLOYEE ORDER BY JOB;

-- NVL2
-- NVL2(�÷���, ǥ����1, ǥ����2)
-- �÷����� NULL�̸� ǥ����1�� ��ȯ�ϰ�, NULL�� �ƴϸ� ǥ����2�� ��ȯ.
SELECT ENAME, SALARY, COMMISSION,
    NVL2(COMMISSION, SALARY*12 + COMMISSION, SALARY*12)
FROM EMPLOYEE ORDER BY JOB;

-- NULLIF(ǥ����1, ǥ����2)
-- ǥ����1 == ǥ����2 NULL ���, �ƴϸ� ǥ����1�� ���
SELECT NULLIF('A', 'A'),
           NULLIF('A', 'B')
FROM DUAL;

-- ����Ŭ���� IF/ ELSE ���
-- DECODE(ǥ����, ����1, ���1 .... , �⺻���)
SELECT ENAME, DNO,
     DECODE(DNO, 10, 'ȸ���',
                          20, '������',
                          30, '������',
                          40, '���',
                          'DEFAULT') AS "�μ��̸�"
FROM EMPLOYEE ORDER BY DNO;

-- �Ǵٸ� ��� IF / ELSE IF / ELSE ���
SELECT ENAME, DNO,
     CASE WHEN DNO =  10 THEN 'ȸ���'
             WHEN DNO =  20 THEN '������'
             WHEN DNO =  30 THEN '������'
             WHEN DNO =  40 THEN '���'
             ELSE 'DEFAULT' 
     END AS "�μ��̸�"
FROM EMPLOYEE ORDER BY DNO;

-- �������� 5) ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� NULL�� ��� 0�� ���
-- ������̺� : EMPLOYEE / ����÷� : MANAGER
SELECT ENO, ENAME, 
           --NVL(MANAGER, 0),
           NVL2(MANAGER, MANAGER, 0) AS MANAGER 
FROM EMPLOYEE;

-- �������� 6) (DECODE, CASE WHEN) �Լ��� ���޿� ���� �޿��� �λ��ϵ��� �ϼ���.
-- ANALYST : 200 / SALESMAN : 180 / MANAGER : 150 / CLERK : 100
SELECT ENO, ENAME, JOB, SALARY,
    CASE WHEN JOB = 'ANALYST' THEN '200'
            WHEN JOB = 'SALESMAN' THEN '180'
            WHEN JOB = 'MANAGER' THEN '150'
            WHEN JOB = 'CLERK' THEN '100'
            ELSE 'DEFAULT'
    END AS "�޿� �λ�"
FROM EMPLOYEE ORDER BY JOB;

-- �������� 6 DECADE ������� ���
SELECT ENO, ENAME, JOB, SALARY,
           DECODE(JOB, 'ANALYST', SALARY+200,
                               'SALESMAN', SALARY+180,
                               'MANAGER', SALARY+150,
                               'CLERK', SALARY+100,
                               SALARY) AS "�޿� �λ�"
FROM EMPLOYEE;
