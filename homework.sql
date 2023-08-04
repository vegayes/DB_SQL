-- Basic SELECT --

-- #1)
SELECT DEPARTMENT_NAME 학과명 , CATEGORY 계열
FROM TB_DEPARTMENT ; 


-- #2)
SELECT  DEPARTMENT_NAME || '의 정원은 ' || CAPACITY || ' 명 입니다.' AS "학원별 정원"
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = DEPARTMENT_NAME ;

--#3) X 학과 테이블 = '국어 국문학과' 학과번호를 받아와 
--      학생 테이블 = 학과번호와 일치한 값, 여학생, 휴학생을 만족한 값을 조회함.
SELECT STUDENT_NAME 
FROM  TB_STUDENT 
WHERE (SUBSTR(STUDENT_SSN,8,1)= 2 OR SUBSTR(STUDENT_SSN,8,1)=4) 
AND ABSENCE_YN = 'Y'
AND (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT 
	 WHERE DEPARTMENT_NAME = '국어국문학과') = DEPARTMENT_NO ;

--#4) 
SELECT STUDENT_NAME 
FROM TB_STUDENT 
WHERE STUDENT_NO  IN('A513079','A513090','A513091','A513110','A513119')
ORDER BY STUDENT_NAME DESC;


--#5)
SELECT DEPARTMENT_NAME , CATEGORY 
FROM TB_DEPARTMENT 
WHERE CAPACITY BETWEEN 20 AND 30;


--#6)
SELECT PROFESSOR_NAME 
FROM TB_PROFESSOR 
WHERE DEPARTMENT_NO IS NULL;

--#7) ?
SELECT STUDENT_NAME 
FROM TB_STUDENT 
WHERE DEPARTMENT_NO IS NULL;

--#8)
SELECT CLASS_NO 
FROM TB_CLASS 
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9)
SELECT DISTINCT CATEGORY 
FROM TB_DEPARTMENT 
ORDER BY CATEGORY ; 

--10) 
SELECT STUDENT_NO ,STUDENT_NAME , STUDENT_SSN 
FROM TB_STUDENT 
WHERE STUDENT_ADDRESS LIKE '전주시%' 
AND EXTRACT (YEAR FROM ENTRANCE_DATE ) = 2002
AND ABSENCE_YN ='N';


-------------------------------------------------------------------------------------
-- Additional SELECT 함수 --

-- #1) 
SELECT STUDENT_NO 학번 , STUDENT_NAME 이름, TO_CHAR(ENTRANCE_DATE,'RRRR-MM-DD') "입학년도"
FROM TB_STUDENT 
WHERE (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT 
		WHERE DEPARTMENT_NAME = '영어영문학과') = DEPARTMENT_NO
ORDER BY ENTRANCE_DATE ; 


-- #2) ?? 다르게 나오는거?? 뭐가?
SELECT PROFESSOR_NAME, PROFESSOR_SSN 
FROM TB_PROFESSOR 
WHERE PROFESSOR_NAME NOT LIKE '___'; 


-- #3) 
SELECT  PROFESSOR_NAME 교수이름 , EXTRACT(YEAR FROM SYSDATE)-TO_NUMBER(19 || SUBSTR(PROFESSOR_SSN,1, 2)) AS "나이(만)"
FROM TB_PROFESSOR 
WHERE SUBSTR(PROFESSOR_SSN, 8,1) = 1
ORDER BY SUBSTR(PROFESSOR_SSN,1, 2) DESC;

/*
SELECT  TO_CHAR(SYSDATE, 'yyyy')  
FROM TB_PROFESSOR;

SELECT  EXTRACT(YEAR FROM SYSDATE) 
FROM TB_PROFESSOR;

SELECT 19 || SUBSTR(PROFESSOR_SSN,1,2) 
FROM TB_PROFESSOR;

SELECT  TO_CHAR( SUBSTR(STUDENT_SSN,1, 2),'YYYY')
FROM TB_STUDENT ;
*/

-- #4) 
SELECT SUBSTR( PROFESSOR_NAME, 2, 2) 이름 
FROM TB_PROFESSOR ;

-- #5) 
SELECT STUDENT_NO , STUDENT_NAME 
FROM TB_STUDENT 
WHERE (EXTRACT(YEAR FROM ENTRANCE_DATE) - TO_NUMBER(19 || SUBSTR(STUDENT_SSN,1, 2)))>19 ;

-- #6) 
SELECT TO_CHAR(TO_DATE(20201225),'DAY') FROM DUAL;

--#7) 2099-10-11 , 1949-19-11 / 1999-10-11 , 2049-10-11
SELECT TO_DATE('99/10/11', 'YY/MM/DD') FROM DUAL;
SELECT TO_DATE('49/10/11', 'YY/MM/DD') FROM DUAL;
SELECT TO_DATE('99/10/11', 'RR/MM/DD') FROM DUAL;
SELECT TO_DATE('49/10/11', 'RR/MM/DD') FROM DUAL;

-- #8)
SELECT STUDENT_NO , STUDENT_NAME 
FROM TB_STUDENT 
WHERE STUDENT_NO NOT LIKE 'A%';

-- #9)
SELECT ROUND(AVG(POINT),1) 평점
FROM TB_GRADE
WHERE STUDENT_NO ='A517178'; 

-- #10)
SELECT DEPARTMENT_NO "학과번호" ,  count(*) "학생수(명)"
FROM TB_STUDENT  GROUP BY DEPARTMENT_NO 
ORDER BY DEPARTMENT_NO ;


-- #11)
SELECT COUNT(*)
FROM TB_STUDENT 
WHERE COACH_PROFESSOR_NO IS NULL;

-- #12)
SELECT SUBSTR(TERM_NO,1,4) 년도 ,ROUND(AVG(POINT),1) "년도 별 평점"
FROM TB_GRADE 
WHERE  STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4); 


-- #13) COUNT 값이 0이 되려면, 조건을 넣어 줘야함! 
SELECT DEPARTMENT_NO "학과코드명" ,COUNT(CASE WHEN ABSENCE_YN='Y' THEN 1 END) "휴학생 수"
FROM TB_STUDENT 
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ;


-- #14)
SELECT STUDENT_NAME "동일이름", COUNT(*) "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1
ORDER BY STUDENT_NAME ; 

-- #15) NULL은 그냥 안 바꿔도 되나?
SELECT SUBSTR(TERM_NO, 1, 4) 년도,  SUBSTR(TERM_NO, 5, 2) "학기" , ROUND(AVG(POINT),1) "평점" 
FROM TB_GRADE 
WHERE  STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4) ,SUBSTR(TERM_NO, 5, 2))
ORDER BY SUBSTR(TERM_NO, 1, 4);

-----------------------------------------------------------------------------
-- Additional SELECT Option--

-- #1)
SELECT STUDENT_NAME "학생 이름", STUDENT_ADDRESS 주소지
FROM TB_STUDENT
ORDER BY STUDENT_NAME ;

-- #2)
SELECT STUDENT_NAME , STUDENT_SSN 
FROM TB_STUDENT 
WHERE ABSENCE_YN ='Y'
ORDER BY STUDENT_SSN  DESC;


-- #3)
SELECT STUDENT_NAME 학생이름 , STUDENT_NO 학번, STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT 
WHERE (STUDENT_ADDRESS LIKE '경기도%' OR STUDENT_ADDRESS LIKE '강원도%') 
AND STUDENT_NO NOT LIKE 'A%'
ORDER BY STUDENT_NAME  ;


-- #4)
SELECT PROFESSOR_NAME , PROFESSOR_SSN 
FROM TB_PROFESSOR 
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT 
WHERE DEPARTMENT_NAME = '법학과') 
ORDER BY PROFESSOR_SSN ;


-- #5) 소수점 안나타냄.
SELECT STUDENT_NO , POINT
FROM TB_GRADE 
WHERE TERM_NO ='200402' AND CLASS_NO ='C3118100'
ORDER BY POINT DESC , STUDENT_NO ;


-- #6)join 사용 
SELECT STUDENT_NO , STUDENT_NAME , DEPARTMENT_NAME
FROM TB_STUDENT ts , TB_DEPARTMENT td
WHERE ts.DEPARTMENT_NO  = td.DEPARTMENT_NO ;


-- #7) 
SELECT CLASS_NAME , DEPARTMENT_NAME
FROM TB_CLASS tc , TB_DEPARTMENT td
WHERE tc.DEPARTMENT_NO = td.DEPARTMENT_NO ;

-- #8)
SELECT CLASS_NAME , DEPARTMENT_NAME
FROM TB_CLASS tc , TB_PROFESSOR tp, TB_CLASS_PROFESSOR tcp  
WHERE tcp.CLASS_NO =tc.CLASS_NO  AND tcp.PROFESSOR_NO = tp.PROFESSOR_NO ;























