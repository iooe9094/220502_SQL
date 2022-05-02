-- �׷��Լ�
-- SUM : �����հ踦 ��ȯ
-- AVG : �׷��� ����� ��ȯ
-- COUNT : �׷��� ������ ��ȯ
-- MAX : �׷��� �ִ밪�� ��ȯ
-- MIN : �׷��� �ּҰ��� ��ȯ

SELECT SUM(SALARY) AS "�޿� �Ѿ�",
           TRUNC (AVG(SALARY)) AS "�޿� ���",
           MAX(SALARY) AS "�ִ� �޿�",
           MIN(SALARY) AS "���� �޿�"
FROM EMPLOYEE;

-- ���� 4) �ֱٿ� �Ի��� ����� ���� �������� �Ի��� ����� �Ի��� ����ϱ�
-- ��� : EMPLOYEE / �Ի����÷� : HIREDATE
SELECT MAX(HIREDATE) AS "�ֱ� �Ի�",
           MIN(HIREDATE) AS "������ �Ի�"
FROM EMPLOYEE;

-- �׷��Լ� VS NULL
-- �׷��Լ������� NULL�� ���������� �����ϰ� �����
SELECT SUM(COMMISSION) AS "Ŀ�̼�"
FROM EMPLOYEE;

-- COUNT : �� �� ����
SELECT COUNT(*)
FROM EMPLOYEE;
-- COMMISSION�� �޴� ����� ���� �˰� ���� ���
-- �׷��Լ��� NULL�� �����ϱ� ������ COMMISSION ���� ���� �� ����
SELECT COUNT(COMMISSION)
FROM EMPLOYEE
WHERE COMMISSION IS NOT NULL;
-- Ȱ�� ���� -> �ߺ� ���� ��
SELECT COUNT(JOB) AS "������ ����"
FROM EMPLOYEE;
-- Ȱ�� ���� -> �ߺ� ���� �� (DISTINCT)
SELECT COUNT(DISTINCT JOB) AS "�ߺ� ���� ������ ����"
FROM EMPLOYEE;

-- �׷� �Լ� ��� �� ������ ��
-- 1. �Ϲ� �÷��� �Բ� ��� �Ұ���, �׷��Լ����� ���
SELECT COUNT(ENO), MAX(SALARY)
FROM EMPLOYEE;

-- ** GROUP BY ��
-- �׷��Լ� : �ϳ��� ������� ������(COUNT, MAX, SUM)
-- ����) �μ����� ��� �޿��� �˰� ���� ���
-- GROUP BY �÷��� -> SELECT �÷��� �����ؾ���
-- �Ʒ�ó�� SELECT DNO�� ��� GROUP BY DNOó�� DNO �������
SELECT DNO AS "�μ���ȣ",
           AVG(SALARY) AS "��ձ޿�"
FROM EMPLOYEE
GROUP BY DNO; -- �μ� ��ȣ�� �׷�ȭ

-- �߸��� ���� : ENAME -> GROUP BY ���� ���� �÷��̹Ƿ� ���� X
SELECT DNO AS "�μ���ȣ",
           ENAME,
           TRUNC(AVG(SALARY)) AS "��ձ޿�"
FROM EMPLOYEE
GROUP BY DNO; -- �μ� ��ȣ�� �׷���

-- ��������) �μ���, ���޺� �� �޿��� ����Ͽ� ���
-- �μ�: DNO / ����: JOB / ������̺�: EMPLOYEE
-- ��, �μ���, ���޺��� ������������ ����
SELECT DNO AS "�μ���ȣ",
           JOB AS "����",
           SUM(SALARY) AS "�� �޿��� ��"
FROM EMPLOYEE
GROUP BY DNO, JOB
ORDER BY SUM(SALARY) DESC;

-- GROUP BY ���� ���ǰɱ� (HAVING)
-- HAVING + ����
-- �μ����� �ִ� �޿��� ���ϴµ� 3000 �̻� �Ǵ� �͸� ����ϱ�
SELECT DNO, 
           MAX(SALARY) 
FROM EMPLOYEE
GROUP BY DNO
HAVING MAX(SALARY) > 3000;

-- ��������) 1. MANAGER�� �����ϰ� 2. �޿� �Ѿ��� 5000 �̻��� ���޺� �޿� �Ѿ�(SUM) ���ϱ�
SELECT JOB AS ����,
           SUM(SALARY) AS �޿��Ѿ�
FROM EMPLOYEE
WHERE JOB NOT LIKE '%MANAGER%'
GROUP BY JOB
HAVING SUM(SALARY) >= 5000
ORDER BY SUM(SALARY) DESC;

-- �������� 1) ��� ����� �ִ� �޿��� ���� �޿�, �Ѿ�, ��� �޿��� ����ϱ�
-- �÷��� ��Ī : �ִ�޿�, �����޿�, �޿��Ѿ�, �޿���� / �Ǽ��� ��� �ݿø� ó��
SELECT MAX(SALARY) AS �ִ�޿�,
           MIN(SALARY) AS �����޿�,
           SUM(SALARY) AS �޿��Ѿ�,
           ROUND(AVG(SALARY)) AS �޿����
FROM EMPLOYEE;

-- �������� 2) �� ��� ���� �������� �ִ�޿�, �����޿�, �Ѿ� �� ����� ����ϱ�
SELECT JOB,
           MAX(SALARY) AS �ִ�޿�,
           MIN(SALARY) AS �����޿�,
           SUM(SALARY) AS �޿��Ѿ�,
           ROUND(AVG(SALARY)) AS �޿����
FROM EMPLOYEE
GROUP BY JOB;

-- �������� 3) COUNT(*) �Լ��� �̿��Ͽ� ��� ������ ������ ��� ���� ����ϱ�
SELECT JOB,
           COUNT(JOB)
FROM EMPLOYEE
GROUP BY JOB;

-- �������� 4) ������ ���� �����ϱ�
SELECT MANAGER, 
           COUNT(MANAGER) -- COUNT�� NULL�� �����ϰ� ��� ó��
FROM EMPLOYEE
GROUP BY MANAGER;

-- �������� 5) �ִ�޿�, �����޿��� ������ ����ϱ�
SELECT MAX(SALARY)
           - MIN(SALARY) AS �޿�����
FROM EMPLOYEE;

-- �������� 6) ���޺� ����� ���� �޿��� ����ϰ�, 
-- �����ڸ� �� �� ���� ��� �� ���� �޿��� 2000 �̸��� �׷��� �����ϰ� �޿��� ���� �������� �����ϱ�
SELECT JOB,
           MIN(SALARY)
FROM EMPLOYEE
WHERE MANAGER IS NOT NULL -- �����ڸ� �� �� ���� ��� 
GROUP BY JOB -- �׷��Լ��� NULL�� ���ܰ� �ȴ�
HAVING  NOT MIN(SALARY) < 2000 -- HAVING MIN(SALARY) > 2000
ORDER BY MIN(SALARY) DESC;

-- �������� 7) �� �μ��� ���� �μ���ȣ, �����, �μ� �� ��� ����� ��� �޿��� ���
--                  ��ձ޿��� �Ҽ��� �� ��° �ݿø� ó��
SELECT DNO AS �μ���ȣ,
           COUNT(*) �����,
           ROUND(AVG(SALARY), 2) AS ��ձ޿�
FROM EMPLOYEE
GROUP BY DNO, JOB;

-- �������� 8) �� �μ��� ���� �μ��̸�, ������, �����, �μ��� ��� ��� �޿� ��� (DECODE, CASE WHEN)
-- 1�� DECODE(CASE WHEN) ���� ���ϱ�
--SELECT DNO,
--           COUNT(*) AS "�����",
--           TRUNC(AVG(SALARY)) AS "��ձ޿�"
--FROM EMPLOYEE
--GROUP BY DNO;
-- 2�� DECODE(CASE WHEN) ���ؼ� ���ϱ�
SELECT DECODE(DNO,10, 'ACCOUNTING',
                                20, 'RESEARCH',
                                30, 'SALES',
                                40, 'OPERATION') AS �μ��̸�,
           DECODE(DNO,10, 'ACCOUNTING',
                                20, 'DALLAS',
                                30, 'CHICAGO',
                                40, 'BOSTON') AS ������,
           COUNT(*) AS "�����",
           TRUNC(AVG(SALARY)) AS "��ձ޿�"
FROM EMPLOYEE
GROUP BY DNO;

-- ����
-- ��� ��ȣ�� 7788�� ������ �μ����� ?
SELECT DNO FROM EMPLOYEE WHERE ENO = 7788;

SELECT DNAME FROM DEPARTMENT WHERE DNO = 20;

SELECT COUNT(*) FROM EMPLOYEE;
SELECT COUNT(*) FROM DEPARTMENT;

-- ������ ���� �ϱ� ���ؼ��� ����� ���� ���� FROM �տ��� ���
-- �Ϲ� JOIN(EQUAL(=) JOIN, INNER JOIN) : ������
SELECT A.DNO, A.DNAME, A.LOC
           FROM DEPARTMENT A,
           EMPLOYEE B
WHERE B.DNO = A.DNO;
-- AS ���� ����
           
           
           