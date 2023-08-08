-- 08/08

-- 실제 삭제 시 , DELETE X , UPDATE

-- *** DML(Data Manipulation Language) : 데이터 조작 언어 

-- 테이블에 값을 삽입하거나 (INSERT), 수정하거나(UPDATE), 삭제(DELETE) 하는 구문

-- 주의 : 혼자서 COMMIT, ROLLBACK 하지 말 것! 

-- 테스트용 테이블 생성 
CREATE TABLE EMPLOYEE2 AS SELECT * FROM EMPLOYEE; -- copy 개념
CREATE TABLE DEPARTMENT2 AS SELECT * FROM DEPARTMENT;


SELECT * FROM EMPLOYEE2;
SELECT * FROM DEPARTMENT2;

-- 테이블 삭제 방법
DROP TABLE DEPARTMENT2;


---------------------------------------------------------------------------------------------

-- 1. INSERT 
--    테이블에 새로운 행을 추가하는 구문 

--  1) INSERT INTO 테이블명 VALUES(데이터, 데이터, 데이터,....)
--  테이블에 있는 모든 컬럼에 대한 값을 INSERT 할 때 사용
--  INSERT하고자 하는 컬럼이 모든 컬럼인 경우 컬럼명 생략 가능 
--  단, 컬럼의 순서를 지켜서 VALUES에 값을 기입해야 함. 

INSERT INTO EMPLOYEE2 
VALUES(900, '장채현','901230-2345678', 'jank_ch@kh.or.kr', '01012341234', 'D1', 'J7','S3', 4300000, 0.2 ,200, SYSDATE, NULL, 'N');
-- UPdated Rows : 1 ==> 성공!

SELECT  * FROM EMPLOYEE2 
WHERE EMP_ID = 900;

ROLLBACK; 
-- ROLLBACK : 뒤로 돌아감. 

-- 생성 -> 조회 -> ROLLBACK-> 조회 (: 생성된 값 없어야 함)
-- 생성 -> 조회 -> COMMIT -> ROLLBACK( : 생성된 값 유지.)
-- ==> 안정적인?~~

DELETE FROM EMPLOYEE2 
WHERE EMP_ID = 900;

COMMIT;

-- COMMIT : ROLLBACK 해도 뒤로 돌아가지 않음.(실제로 DB에 저장됨.)


-- >> 데이터를 바로 DB에 넣으면 안됨.  그래서 트랜잭션(대기실)에 넣어둠. 
-- >> 실제로 넣은 경우 commit 
-- >> 트랜잭션 비움 rollback

-- >> Auto ~~ 가 활성화 되면, DB에 바로 적용 됨. 
-- >> DB에 적용된 값은 DELETE 사용해야 함. 

-------------------------------------------------------------------------
-- 2) INSERT INTO 테이블명 (컬럼명1, 컬럼명2, 컬럼명3,.....) VALUES(데이터1, 데이터2, 데이터3,....)
-- 테이블에 내가 선택한 컬럼에 대한 값만 INSERT 할 때 사용
-- 선택 안된 컬럼은 값이 NULL이 들어감. (DEFALUT 존재 시 DEFAULT 값으로 삽입됨.)

-- 복사할 때, 디폴트 값은 같이 복사가 안됨.

INSERT INTO EMPLOYEE2(EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL, SALARY)
VALUES(900, '장채현', '901123-2345678', 'jank_ch@kh.or.kr','01012341234', 'D1','J7','S3', 4300000);

SELECT *
FROM EMPLOYEE2 
WHERE EMP_ID = 900;

ROLLBACK;

------------------------------------------------------------------------------------------------------------------

--(참고) INSERT시, VALUES 대신 서브쿼리 사용 가능
CREATE TABLE EMP_01(
	EMP_ID NUMBER,
	EMP_NAME VARCHAR2(30),
	EMP_TITLE VARCHAR2(20)
);


SELECT * FROM EMP_01;

SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE2 
LEFT JOIN DEPARTMENT2  ON ( DEPT_CODE= DEPT_ID);


INSERT INTO EMP_01 
(SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE2 
LEFT JOIN DEPARTMENT2  ON ( DEPT_CODE= DEPT_ID));
-- EMP_01에 안에 있는 쿼리 넣어둠. 

-- 서브쿼리(SELECT) 결과를 EMP_01 테이블에 INSERT함.
--> SELECT 조회 결과의 데이터 타입, 컬럼 개수가 맞아야 함! 
--> INSERT 하려는 테이블의 컬럼과 일치해야 함! 


--------------------------------------------------------------------------------------

-- 2. UPDATE(내용을 바꾸거나 추가해서 최신화, 새롭게 만드는 것)
-- 테이블에 기록된 컬럼의 값을 수정하는 구문

-- [작성법]
-- UPDATE 테이블명 SET 컬럼명 = 바꿀값
-- [WHERE 컬럼명 비교 연산자 비교값];

--DEPARTMENT2 테이블에서 DEPT_ID가 'D9'인 부서 정보 조회
SELECT  *
FROM DEPARTMENT2 
WHERE DEPT_ID = 'D9';

--DEPARTMENT2 테이블에서 DEPT_ID가 'D9'인 행의 DEPT_TITLE을 전략기획팀으로 변경
UPDATE DEPARTMENT2 SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9';

COMMIT;


--ex)
--EMPLOYEE2 테이블에서 BONUS를 받지 않는 사원의 
--BONUS를 0.1로 변경

--변경 전 확인
SELECT * 
FROM EMPLOYEE2 e 
WHERE BONUS IS NOT NULL;

--변경
UPDATE EMPLOYEE2 SET BONUS = 0.1
WHERE BONUS IS NULL;

-- 변경 후 확인
SELECT * FROM EMPLOYEE2 ;


-------------------------------------------------------------------------------

-- 주의!! * 조건절을 설정하지 않고 UPDATE 구문 실행 시, 모든 행의 컬럼값이 변경됨. *

SELECT * FROM DEPARTMENT2 ;

UPDATE DEPARTMENT2 SET 
DEPT_TITLE = '기술연구팀'; 

ROLLBACK;


--------------------------------------------------------------------------------

-- * 여러 컬럼을 한번에 수정 시, 콤마(,)로 컬럼을 구분하면 됨.

-- D9  / 전략기획팀 -> D0 / 전략기획2팀 수정

UPDATE DEPARTMENT2 SET 
DEPT_ID = 'D0', DEPT_TITLE ='전략기획2팀'
WHERE DEPT_ID = 'D9'
AND DEPT_TITLE ='전략기획팀';



-- 궁금한 것! 밑의 코드는 가능 OK
UPDATE DEPARTMENT2 SET 
DEPT_ID = 'D0', DEPT_TITLE ='전략기획2팀'
WHERE DEPT_ID = 'D9';





----------------------------------------------------------------

-- * UPDATE 시에도 서브쿼리를 사용 가능

-- [작성법]
-- UPDATE 테이블명 SET 컬럼명 = (서브쿼리)


-- EMPLOYEE2 테이블에서 평소에 유재식 사원을 부러워하던 방명수 사원의 
-- 급여와 보너스율을 유지식 사원과 동일하게 변경해 주기로 했다. 
-- 이를 반영하는 UPDATE문을 작성하시오.

-- 유재식 급여 
SELECT SALARY FROM EMPLOYEE2 
WHERE EMP_NAME = '유재식';

-- 유재식 보너스
SELECT BONUS FROM EMPLOYEE2 
WHERE EMP_NAME = '유재식';


-- 방명수 급여, 보너스 수정 (서브 쿼리 사용! )
UPDATE EMPLOYEE2 SET 
SALARY = (SELECT SALARY FROM EMPLOYEE2 WHERE EMP_NAME = '유재식') ,
BONUS =(SELECT BONUS FROM EMPLOYEE2 WHERE EMP_NAME = '유재식') 
WHERE EMP_NAME = '방명수';


-- 같은지 확인
SELECT EMP_NAME , SALARY , BONUS 
FROM EMPLOYEE2 
WHERE EMP_NAME IN('유재식', '방명수');

--------------------------------------------------------------------------------------

-- 3. MERGE(병합) (참고만 하세요!)

-- 구조가 같은 두개의 테이블을 하나로 합치는 기능 
-- 테이블에서 지정하는 조건의 값이 존재하면 UPDATE
-- 조건의 값이 없으면 INSERT 됨. 

CREATE TABLE EMP_M01
AS SELECT * FROM EMPLOYEE;

CREATE TABLE EMP_M02
AS SELECT * FROM EMPLOYEE
WHERE JOB_CODE = 'J4';

SELECT * FROM EMP_M01; -- 출석부 1
SELECT * FROM EMP_M02; -- 출석부 2

INSERT INTO EMP_M02 VALUES(999, '곽두원', '561016-1234567', 'kk@kh.or.kr', 
'01011112222', 'D9', 'J4' ,'S1', 9000000, 0.5, NULL, SYSDATE, NULL, DEFAULT);

SELECT * FROM EMP_M01; -- 23명
SELECT * FROM EMP_M02; -- 5명( 4명 + 신규 1명)

UPDATE EMP_M02 SET SALARY = 0;

SELECT * FROM EMP_M02;

MERGE INTO EMP_M01 USING EMP_M02 ON(EMP_M01.EMP_ID = EMP_M02.EMP_ID)
WHEN MATCHED THEN
UPDATE SET
	EMP_M01.EMP_NAME = EMP_M02.EMP_NAME,
	EMP_M01.EMP_NO = EMP_M02.EMP_NO,
	EMP_M01.EMAIL = EMP_M02.EMAIL,
	EMP_M01.PHONE = EMP_M02.PHONE,
	EMP_M01.DEPT_CODE = EMP_M02.DEPT_CODE,
	EMP_M01.JOB_CODE = EMP_M02.JOB_CODE,
	EMP_M01.SAL_LEVEL = EMP_M02.SAL_LEVEL,
	EMP_M01.SALARY = EMP_M02.SALARY,
	EMP_M01.BONUS = EMP_M02.BONUS,
	EMP_M01.MANAGER_ID = EMP_M02.MANAGER_ID,
	EMP_M01.HIRE_DATE = EMP_M02.HIRE_DATE,
	EMP_M01.ENT_DATE = EMP_M02.ENT_DATE,
	EMP_M01.ENT_YN = EMP_M02.ENT_YN
WHEN NOT MATCHED THEN
INSERT VALUES(EMP_M02.EMP_ID, EMP_M02.EMP_NAME, EMP_M02.EMP_NO, EMP_M02.EMAIL, 
	         EMP_M02.PHONE, EMP_M02.DEPT_CODE, EMP_M02.JOB_CODE, EMP_M02.SAL_LEVEL, 	  	         EMP_M02.SALARY, EMP_M02.BONUS, EMP_M02.MANAGER_ID, EMP_M02.HIRE_DATE, 
	         EMP_M02.ENT_DATE, EMP_M02.ENT_YN);

SELECT * FROM EMP_M01; -- 기존에 있었던 건 UPDATE 없었던건 INSERT 된 것을 확인할 수 있음.
--------------------------------------------------------------------------------------------------------

-- 4. DELETE
-- 테이블의 행을 삭제하는 구문

-- [작성법]
-- DELETE FROM 테이블명 WHERE 조건설정
--> 만약 WHERE 조건을 설정하지 않으면, 모든 행이 삭제됨.

SELECT * FROM EMPLOYEE2 ;

COMMIT;

-- EMPLOYEE2 테이블에서 '장채현' 사원 정보 조회 
SELECT * FROM EMPLOYEE2 
WHERE EMP_NAME = '장채현';

-- EMPLOYEE2 테이블에서 이름이 '장채현'인 사원 정보 삭제
DELETE FROM EMPLOYEE2 
WHERE EMP_NAME = '장채현';


-- 삭제 확인
SELECT * FROM EMPLOYEE2 
WHERE EMp_NAME = '장채현'; --> 조회 결과 없음


ROLLBACK; 

--- EMPLOYEE2 테이블 전체 삭제

DELETE FROM EMPLOYEE2 ; --> 24행 삭제 

SELECT * FROM EMPLOYEE2 ;

ROLLBACK;


------------------------------------------------------------------------

-- 5. TRUNCATE (DML은 아님. DDL임.)
-- 테이블의 전체 행을 삭제하는 DDL 
-- DELETE 보다 수행 속도가 더 빠르다. 
-- ROLLBACK을 통해서 복구할 수 없다. 

-- TRUNCATE 테스트용 테이블 생성
CREATE TABLE EMPLOYEE3 AS SELECT *  FROM EMPLOYEE2 ;

-- 생성 확인
SELECT * FROM EMPLOYEE3;

-- TRUNCATE로 삭제 
TRUNCATE TABLE EMPLOYEE3 ;

-- 삭제 확인
SELECT * FROM EMPLOYEE3;

ROLLBACK;

-- 롤백 후 복구 확인 -> 복구 안됨을 확인! 
SELECT * FROM EMPLOYEE3;


-- DELETE : 휴지통 버리기
-- TRUNCATE : 완전 삭제 



















