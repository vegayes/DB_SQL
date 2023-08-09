-- 1)
-- ex) EMPLOYEE 테이블에서 모든 사원의 사번, 이름, 급여, 연봉 조회 
-- 급여 부분은 NUMBER 타입이기 때문에 연산 가능. 
-- 컬럼명은 연산된 내용으로 처리됨.

SELECT EMP_ID, EMP_NAME , SALARY , SALARY *12
FROM EMPLOYEE ;

-----------------------------  조건절  -----------------------------

-- 2) 
-- ex) EMPLOYEE 테이블에서 (FROM절) /  급여가 3백만원 초과인 사원의(WHERE절 )/
--    사번, 이름, 급여, 부서코드를 조회 (SELECT 절)
SELECT EMP_ID , EMP_NAME , SALARY , DEPT_CODE 
FROM EMPLOYEE 
WHERE SALARY > 3000000;

--> FROM -> WHERE -> SELECT 


-- 3)
-- ex) EMPLOYEE 테이블에서 부서코드가 'D9'인 사원의  
-- 사번, 이름, 부서코드, 직급코드를 조회
SELECT EMP_ID , EMP_NAME , DEPT_CODE , JOB_CODE 
FROM EMPLOYEE 
WHERE DEPT_CODE ='D9';

-- 4)
-- ex) EMPLOYEE 테이블에서 급여가 300만 미만 또는 500만 이상인 사원의 
-- 사번, 이름 , 급여, 전화번호 조회
SELECT EMP_ID , EMP_NAME , SALARY , PHONE 
FROM EMPLOYEE 
WHERE SALARY < 3000000 OR SALARY >= 5000000;

-- ex) 300만 이상, 600만 이하
SELECT EMP_ID , EMP_NAME , SALARY , PHONE 
FROM EMPLOYEE 
WHERE SALARY BETWEEN 3000000 AND 5000000;


----------------------------- LIKE -----------------------------

-- LIKE의 패턴을 나타내는 문자 (와일드 카드)
--> '%' : 포함
--> '_' : 글자수 ex) _____ 5글자

-- '_' 예시
-- 'A_' : A로 시작하는 두글자 문자열 
-- '____A' : A로 끝나는 다섯 글자 문자열
-- '__A__' : 세번째 문자가 A인 다섯글자 문자열 
-- '_____' : 다섯글자 문자열 

-- 5)
-- ex) EMPLOYEE 테이블에서 성이 '전'씨인 사원의 사번, 이름 조회
SELECT EMP_ID , EMP_NAME 
FROM EMPLOYEE 
WHERE EMP_NAME LIKE '전%';

-- 6)
-- EMPLOYEE 테이블에서 전화번호가 010으로 시작하지 않는 사원
-- 사번, 이름 , 전화번호 조회
SELECT EMP_ID , EMP_NAME , PHONE 
FROM EMPLOYEE 
WHERE PHONE NOT LIKE '010%';

-- 7) ★★★
-- EMPLOYEE 테이블에서 EMAIL의 _앞에 글자가 세글자인 사원만 조회
-- 이름 , 이메일 조회
SELECT EMP_NAME , EMAIL 
FROM EMPLOYEE 
WHERE EMAIL LIKE '___#_%' ESCAPE '#'; 

--> ESCAPE 문자 뒤에 작성해야 패턴(와일드 카드)을 인지할 수 있음. 
--> #, ^ 사용 
--> 사용 후에는 ESCAPE 문자가 사용되었음을 확인시켜야 함!


-- 연산자 우선순위
/*
 * 1. 산술 연산자 ( + - * / ) 
 * 2. 연결 연산자 ( || )
 * 3. 비교 연산자 ( > <  >=  <=  =  != <>)
 * 4. IS NULL / IS NOT NULL, LIKE, IN / NOT IN
 * 5. BETWEEN AND / NOT BETWEEN AND
 * 6. NOT ( 논리 연산자 ) 
 * 7. AND 
 * 8. OR
 */


-- 8)
-- EMPLOYEE 테이블에서 
-- 부서코드가 D1, D6, D9인 사원의 사번, 이름, 부서코드 조회
SELECT EMP_ID , EMP_NAME , DEPT_CODE 
FROM EMPLOYEE
WHERE DEPT_CODE IN('D1', 'D6','D9');

----------------------------- NULL -----------------------------
--JAVA에서 NULL : 참조하는 객체가 없음을 의미하는 값.
-- DB에서 NULL : 컬럼에 값이 없음을 의미하는 값. 

-- 9) 
-- EMPLOYEE 테이블에서 보너스가 있는 사원의 이름, 보너스 조회 
SELECT EMP_NAME , BONUS 
FROM EMPLOYEE 
WHERE BONUS IS NOT NULL;

-- EMPLOYEE 테이블에서 보너스가 없는 사원의 이름, 보너스 조회 
SELECT EMP_NAME , BONUS 
FROM EMPLOYEE 
WHERE BONUS IS NULL;



----------------------------- ORDER BY 절 -----------------------------
-- FROM -> WHERE -> ODER BY -> SELECT
-- ORDER BY  컬럼명 | 별칭 | 컬럼순서 

-- 10)
-- EMPLOYEE 테이블 급여 오름차순으로 
-- 사번, 이름, 급여 조회 
SELECT EMP_ID , EMP_NAME , SALARY 
FROM EMPLOYEE 
ORDER BY SALARY ;


-- 11)
-- 급여 200만 이상인 사원의 사번, 이름, 급여 조회
-- 단, 급여 내림 차순으로 조회
SELECT EMP_ID , EMP_NAME , SALARY 
FROM EMPLOYEE 
WHERE SALARY >= 2000000
ORDER BY SALARY DESC;

-- 12)
-- 입사일 순서대로 이름, 입사일 조회 ( 별칭 사용 )
SELECT EMP_NAME 이름 , HIRE_DATE 입사일
FROM EMPLOYEE 
ORDER BY 입사일;

-- 13)
-- 부서코드 오름차순 정렬 후 급여 내림차순 정렬  
SELECT EMP_NAME , DEPT_CODE , SALARY 
FROM EMPLOYEE 
ORDER BY DEPT_CODE , SALARY DESC;
--> 정렬 중첩 :: 대분류 정렬 후 소분류 정렬 !( 순서가 중요! )

-------------------------------------------------------------------------------------------------
----------------------------- INSTR -----------------------------
-- INSTR(컬럼명 | 문자열, '찾을 문자열'[, 찾기 시작할 위치 [,순번] ])
-- 지정한 위치부터 지정한 순번째로 검색되는 문자의 '위치'를 반환

-- 1)
-- ex) 문자열(AABAACAABBAA)을 앞에서부터 검색하여 첫번째 B위치 조회
SELECT INSTR('AABAACAABBAA','B') FROM DUAL;

-- ex) 문자열을 5번째 문자 부터 검색하여 첫번째 B위치 조회 
SELECT INSTR('AABAACAABBAA','B', 5) FROM DUAL;

-- ex) 문자열을 5번째 문자 부터 검색하여 두번째 B위치 조회 
SELECT INSTR('AABAACAABBAA','B', 5, 2) FROM DUAL;

-- ex) EMPLOYEE 테이블에서 사원명, 이메일, 이메일 중 '@' 위치 조회
SELECT  EMP_NO , EMAIL , INSTR(EMAIL, '@') 
FROM EMPLOYEE ;



----------------------------- SUBSTR -----------------------------
-- SUBSTR('문자열' | 컬럼명, 잘라내기 시작할 위치 [, 잘라낼 길이] ) 
-- 컬럼이나 문자열에서 지정한 위치부터 지정된 길이만큼 문자열을 잘라내서 반환
--> 잘라낼 길이 생략 시, 끝까지 잘라냄. 

-- 2)
-- ex) EMPLOYEE 테이블에서 사원명, 이메일 중 아이디만 조회
SELECT EMP_NAME , SUBSTR(EMAIL, 1,  INSTR(EMAIL,'@')-1) 
FROM EMPLOYEE; 



----------------------------- TRIM -----------------------------
-- TRIM( [[옵션] '문자열' | 컬럼명 FROM ] '문자열' | 컬럼명)
-- 주어진 컬럼이나 문자열의 앞, 뒤, 양쪽에 있는 지정된 문자를 제거
--> 양쪽 '공백 제거'에 많이 사용됨. 
-- 옵션 : LEADING (앞쪽) , TRAILING(뒤쪽), BOTH(양쪽, 기본값)

SELECT TRIM('      H E L L O            ')
FROM DUAL; -- 양쪽 공백은 제거할 수 있지만, 글자 사이의 공백은 제거할 수 없음.

SELECT TRIM(LEADING  '#' FROM '####안녕####') 
FROM DUAL; --안녕####

SELECT TRIM(TRAILING  '#' FROM '####안녕####') 
FROM DUAL; --####안녕

------------------------------------------------------------------------------
----------------------------- 숫자 관련 함수  -----------------------------

-- 1) ABS(숫자 | 컬럼명) : 절대값
-- 2) MOD(숫자 | 컬럼명, 숫자 | 컬럼명) : 나머지 값 반환
-- 3) ROUND(숫자 | 컬럼명 [, 소수점 위치]) : 반올림
-- 4) CEIL(숫자 | 컬럼명) : 올림
-- 5) FLOOR(숫자 | 컬럼명) : 내림
-- 6) TRUNC(숫자 | 컬럼명[, 위치]) : 특정 위치 아래를 버림(첨삭)



-- ex) EMPLOYEE 테이블에서 사원의 월급을 100만으로 나눴을 때 나머지 조회
SELECT EMP_NAME , SALARY , MOD(SALARY, 1000000)
FROM EMPLOYEE ;

-- ex) EMPLOYEE 테이블에서 사번이 짝수인 사원의 사번, 이름 조회
SELECT EMP_ID , EMP_NAME 
FROM EMPLOYEE 
WHERE MOD(EMP_ID , 2) = 0 ;


-- ex) EMPLOYEE 테이블에서 사번이 홀수인 사원의 사번, 이름 조회
SELECT EMP_ID , EMP_NAME 
FROM EMPLOYEE 
WHERE MOD(EMP_ID , 2) = 1 ;

SELECT EMP_ID , EMP_NAME 
FROM EMPLOYEE 
WHERE MOD(EMP_ID , 2) <> 0 ;
					-- !=


----------------------------- 날짜 관련 함수  -----------------------------

-- 1) SYSDATE : 시스템에 현재 시간 (년, 월, 일, 시, 분, 초)을 반환 
-- 2) SYSTIMESTAMP : SYSDATE + MS 단위 추가
-- 3) TIMESTAMP : 특정 시간을 나타내거나 기록하기 위한 문자열
-- 4) MONTHS_BETWEEN(날짜, 날짜) : 두 날짜의 개월 수 차이 반환
-- 5) ADD_MONTHS(날짜, 숫자) : 날짜에 숫자만큼의 개월 수를 더함. ( 음수도 가능 )
-- 6) LAST_DAY(날짜) : 해당 달의 마지막 날짜를 구함
-- 7) EXTRACT : 년, 월, 일 정보를 추출하여 리턴
-- 	  EXTRACT (YEAR FROM 날짜) : 년도만 추출
-- 	  EXTRACT (MONTH FROM 날짜) : 월만 추출
-- 	  EXTRACT (DAY FROM 날짜) : 일만 추출


-- ex) EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무한 개월수, 근무 년차 조회
SELECT EMP_NAME , HIRE_DATE , ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "근무한 개월수" , 
ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12)||'년차' "근무 년차"
FROM EMPLOYEE ;

-- ex) EMPLOYEE 테이블에서 각 사원의 이름, (입사 년도, 월, 일 ) 입사일 조회
SELECT EMP_NAME , 
'(' ||EXTRACT(YEAR FROM HIRE_DATE)  || '년'||
EXTRACT(MONTH FROM HIRE_DATE) ||'월'|| 
EXTRACT(DAY FROM HIRE_DATE) ||'일)' "입사일 조회"
FROM EMPLOYEE ;


----------------------------- 형변환 함수  -----------------------------
-- 문자열, 숫자, 날짜끼리 형변환 가능

-- 1) TO_CHAR(날짜, [포맷]) : 날짜형 데이터를 문자형 데이터로 변경
--    TO_CHAR(숫자, [포맷]) : 숫자형 데이터를 문자형 데이터로 변경 

-- 1-1)<숫자 변환 시 포맷 패턴>
-- 9 : 숫자 한 칸을 의미, 여러개 작성 시 오른쪽 정렬
-- 0 : 숫자 한 칸을 의미, 여러개 작성 시 오른쪽 정렬 + 빈칸에 0추가! 
-- L : 현재 DB에 설정된 나라의 화폐 기호 
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- ' 1234' 
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- '01234'
SELECT TO_CHAR(1234) FROM DUAL; -- '1234' 
SELECT TO_CHAR(1000000, 'L9,999,999') FROM DUAL; -- ￦1,000,000

-- 1-2)<날짜 변환 시 포맷 패턴>
-- YYYY : 2023 / YY :23
-- MM : 08
-- DD : 31
-- AM 또는 PM : 오전 / 오후
-- HH : 시간 /HH24 : "15"시 24시간 표기법
-- MI : 분 / SS : 초
-- DAY : 요일(전체) / DY : 요일 (요일명만 표시)

--2023/08/08 20:20:41 화요일
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS DAY')
FROM DUAL;

--2023년 08월 04일 (금)
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" (DY)' ) 
FROM DUAL;
-- 문자 넣으려면 "" 넣기



-- 2) 날짜로 변환 TO_DATE
-- 	  TO_DATE(문자형 데이터, [포맷]) : 문자형 데이터를 날짜로 변경
-- 	  TO_DATE(숫자형 데이터, [포맷]) : 숫자형 데이터를 날짜로 변경

-- 리터럴 형식 문자형을 맞춰야 함!
-- Y 패턴 : 현재 세기(21세기 == 20XX년 == 2000년대)
-- R 패턴 : 지난 세기(20세기 == 19XX년 == 1900년대)
--         >> 1세기 기준으로 절반(50년) 이상인 경우는 이전세기(1900년대)
--         >> 절반(50년) 미만인 경우 현재 세기(2000년대)


SELECT TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, INSTR(EMP_NO,'-')-1),'RRMMDD'), 'YYYY"년"MM"월"DD"일"DAY')
FROM EMPLOYEE;




-- 3) 숫자 형변환
--  TO_NUMBER(문자데이터, [포맷]) :: 문자데이터 숫자 데이터로 변경
SELECT TO_NUMBER('1,000,000','9,999,999') +500000 FROM DUAl; --1,500,000 연산가능!!!!!!!!!!!!!!!!!!




-- 4)  NULL  처리 함수 
-- NVL(컬럼명, 컬럼값이 NULL인 경우 바꿀 값) : NULL인 컬럼값을 다른값으로 변경 O
-- NULL과 산술 연산을 진행 시, 결과는 무조건 NULL임.

SELECT EMP_NAME, SALARY, NVL(BONUS, 0), SALARY * NVL(BONUS,0)
FROM EMPLOYEE ;

-- 4-2) NVL2(컬럼명, 바꿀값1, 바꿀값2) : 해당 컬럼의 값이 있으면 바꿀값1로 변경, NULL이면 바꿀값 2로 변경

-- EMPLOYEE 테이블에서 보너스를 받으면 'O', 안받으면 'X'조회
SELECT EMP_NO , NVL2(BONUS,'O','X') "보너스 수령"
FROM EMPLOYEE;



-- 5) 선택 함수
--   여러가지 경우에 따라 알맞은 결과를 선택할 수 있음.

-- 5-1) DECODE(계산식 | 컬럼명, 조건값 1, 선택값 1, 조건값 2, 선택값 2,..., 일치값 X)
-- 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과값 반환
-- 일치하는 값을 확인 (자봐의 SWITCH와 비슷함) 

SELECT EMP_NAME , DECODE(SUBSTR( EMP_NO, 8,1), '1',' 남성','2','여성') 성별
FROM EMPLOYEE ;


/* 5-2) CASE WHEN 조건식 THEN 결과값
		     WHEN 조건식 THEN 결과값
		     ELSE 결과값
		END
*/
-- 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환
-- 조건은 범위 값 가능 

--ex) EMPLOYEE 테이블에서
--    급여가 500만원 이상이면 "대"
--     급여가 300만원 이상 500만 미만이면 "중"
--     급여가 300만 미만 "소"으로 조회
SELECT EMP_NAME , SALARY , 
	CASE 
		WHEN SALARY >= 5000000 THEN '대' -- if
		WHEN SALARY >= 3000000 THEN '중' -- else
		ELSE '소'
	END "급여 받는 정도"
FROM EMPLOYEE ;



------------------------------------------------------------------------------
----------------------------- 그룹 함수  -----------------------------
-- 하나 이사으이 행을 그룹으로 묶어 연산하고 총합, 평균 등의 하나의 결과 행으로 반환하는 함수

-- 1) SUM(숫자가 기록된 컬럼명) : 합계 

-- 2) AVG(숫자가 기록된 컬럼명) : 평균

-- 3) MIN(컬럼명) : 최솟값

-- 4) MAX(컬럼명) : 최대값
--> 타입 제한 없음(숫자: 대/소, 날짜: 과거/미래, 문자열: 문자 순서 ) 

-- 5) COUNT(* | 컬럼명) : 행 개수를 헤아려서 리턴

-- 5-2) COUNT([DISTINCT] 컬럼명) : 중복을 제거한 행 개수를 헤아려서 리턴

-- 5-3) COUNT(*) : NULL을 포함한 전체 행 개수를 리턴

-- 5-4)  COUNT(컬럼명) : NULL을 제외한 실제 값이 기록된 행의 개수를 리턴

-- ex) 부서코드가 'D9'인 사원들의 급여 합, 평균 조회
SELECT SUM(SALARY), AVG(SALARY)
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D9';

-- ex) 급여 최소값, 가장 빠른 입사일, 알파벳 순서가 가장빠른 이메일
SELECT MIN(SALARY), MIN(HIRE_DATE), MIN(EMAIL)
FROM EMPLOYEE 

-- ex) EMPLOYEE 테이블에서 급여를 가장 많이 받는 사원의
-- 이름, 급여, 직급 코드 조회
SELECT EMP_NAME , SALARY , DEPT_CODE 
FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE); -- 서브쿼리 사용

--ex) EMPLOYEE 테이블의 행의 개수
SELECT COUNT(*) FROM EMPLOYEE ;

--ex) BONUS를 받는 사원의 수 (2가지 방법) 
--1) 
SELECT COUNT(BONUS) FROM EMPLOYEE 
WHERE BONUS IS NOT NULL;

--2) 
SELECT COUNt(BONUS) FROM EMPLOYEE;


-- ex) DISTINCT 이용
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE ;  -- NULL값 가져옴 

SELECT COUNT(DISTINCT DEPT_CODE) FROM EMPLOYEE  ; -- NULL값 제거함.
--> COUNT(컬럼명)에 의해서 NULL을 제외한 실제 값이 있는 행의 개수만 조회 

-- EMPLOYEE 테이블에서 성별이 남성인 사원의 수 조회
SELECT COUNT(*)  -- ******* 순서 중요!
FROM EMPLOYEE 
WHERE SUBSTR(EMP_NO,8,1) = 1;






















