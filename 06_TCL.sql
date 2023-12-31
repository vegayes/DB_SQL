-- TCL(TRANSACTION CONTROL LANGUAGE) : 트랜잭션 제어 언어
-- COMMIT(트랜잭션 종료 후 저장), ROLLBACK(트랜잭션 취소), SAVEPOINT(임시저장)

-- DML : 데이터 조작 언어로 데이터의 삽입, 수정, 삭제
--> 트랜잭션은 DML과 관련되어 있음.


/* TRANSACTION이란?
 - 데이터베이스의 논리적 연산 단위
 
 - 데이터 변경 사항을 묶어 하나의 트랜잭션에 담아 처리함.

 - 트랜잭션의 대상이 되는 데이터 변경 사항 : INSERT, UPDATE, DELETE (DML), MERGE
 
 EX) INSERT 수행 --------------------------------> DB 반영(X)
   
     INSERT 수행 --> 트랜잭션에 추가 --> COMMIT --> DB 반영(O)- T
     
     INSERT 10번 수행 --> 1개 트랜잭션에 10개 추가 --> ROLLBACK --> DB 반영 안됨


    1) COMMIT : 메모리 버퍼(트랜잭션)에 임시 저장된 데이터 변경 사항을 DB에 반영
    
    2) ROLLBACK : 메모리 버퍼(트랜잭션)에 임시 저장된 데이터 변경 사항을 삭제하고
                 '마지막 COMMIT 상태'로 돌아감.(DB에 변경 내용 반영 X)
                
    3) SAVEPOINT : 메모리 버퍼(트랜잭션)에 저장 지점을 정의하여
                   ROLLBACK 수행 시 전체 작업을 삭제하는 것이 아닌
                   저장 지점까지만 일부 ROLLBACK 
    
    [SAVEPOINT 사용법]
    
    SAVEPOINT 포인트명1;
    ...
    SAVEPOINT 포인트명2;
    ...
    ROLLBACK TO 포인트명1; -- 포인트1 지점 까지 데이터 변경사항 삭제

*/


SELECT * FROM DEPARTMENT2 ;

-- 새로운 데이터 INSERT 
INSERT INTO DEPARTMENT2 VALUES('T1','개발1팀', 'L2');
INSERT INTO DEPARTMENT2 VALUES('T2','개발2팀', 'L2');
INSERT INTO DEPARTMENT2 VALUES('T3','개발3팀', 'L2');



-- INSERT 확인
SELECT * FROM DEPARTMENT2 ;
--> DB에 반영된 것 처럼 보이지만,
--  SQL 수행 시, 트랜잭션 내용도 포함해서 수행됨.
-- (실제로 아직 DB에 반영 X)

-- ROLLBACK 후 확인
ROLLBACK;
SELECT * FROM DEPARTMENT2 ;



-- 새로운 데이터 INSERT 
INSERT INTO DEPARTMENT2 VALUES('T1','개발1팀', 'L2');
INSERT INTO DEPARTMENT2 VALUES('T2','개발2팀', 'L2');
INSERT INTO DEPARTMENT2 VALUES('T3','개발3팀', 'L2');

COMMIT;

SELECT * FROM DEPARTMENT2 ;

ROLLBACK;

SELECT * FROM DEPARTMENT2 ; --> 롤백 안됨. 




-----------------------------------------------------------------------

-- SAVEPOINT 확인 
INSERT INTO DEPARTMENT2 VALUES('T4','개발4팀', 'L2');
SAVEPOINT SP1;

SELECT * FROM DEPARTMENT2;

INSERT INTO DEPARTMENT2 VALUES('T5','개발5팀', 'L2');
SAVEPOINT SP2;

INSERT INTO DEPARTMENT2 VALUES('T6','개발6팀', 'L2');
SAVEPOINT SP3;

ROLLBACK TO SP2;
SELECT * FROM DEPARTMENT2;

ROLLBACK TO SP3;
SELECT * FROM DEPARTMENT2 ;

--다 지워버림
DELETE FROM DEPARTMENT2 
WHERE DEPT_ID LIKE 'T%';

SELECT * FROM DEPARTMENT2;

-- SP2 지점까지 롤백
ROLLBACK TO SP2;
SELECT * FROM DEPARTMENT2;

-- SP1 지점까지 롤백
ROLLBACK TO SP1;
SELECT * FROM DEPARTMENT2;


ROLLBACK;
SELECT * FROM DEPARTMENT2;

-------------------
-- Q)test1 (트랜잭션 말고 DB에 저장된 값을 삭제 한 후에 ROLLBACK 돌리기 가능? (O)) :: INSERT 1개
INSERT INTO DEPARTMENT2 VALUES('T4','개발4팀', 'L2');
COMMIT;
SELECT * FROM DEPARTMENT2;

DELETE FROM DEPARTMENT2 
WHERE DEPT_ID = 'T4';
SELECT * FROM DEPARTMENT2;

ROLLBACK;  --> ?? 왜 T4가 다시 돌아오는거죠? 
			-- 우선, ROLLBACK은 트랜잭션 안의 값을 되돌리는 기능만 있는게 아닌것이라고만 생각.?
            --  ==  'COMMIT만 못 돌릴뿐 다른 기능들은 되돌릴 수 있다.' 라고 생각해도 되는지..

			--> 아니면, 이거 또한, COMMIT의 마지막 인식된 값까지만을 되돌리기? ( test1-2&3에 의해서 이거 인거 같음.  )
SELECT * FROM DEPARTMENT2;



-- Q)test1-2 (트랜잭션 말고 DB에 저장된 값을 삭제 한 후에 ROLLBACK 돌리기 가능?) :: INSERT 2개
INSERT INTO DEPARTMENT2 VALUES('T4','개발4팀', 'L2');

INSERT INTO DEPARTMENT2 VALUES('T5','개발5팀', 'L2');

INSERT INTO DEPARTMENT2 VALUES('T6','개발6팀', 'L2');

SELECT * FROM DEPARTMENT2;

COMMIT;

DELETE FROM DEPARTMENT2 
WHERE DEPT_ID IN('T4','T5','T6');
SELECT * FROM DEPARTMENT2;

ROLLBACK;  --> 아니면, 이거 또한, COMMIT의 마지막 인식된 값까지만을 되돌리기?
SELECT * FROM DEPARTMENT2; 

--> 123 만 나옴 // COMMIT 안하면 123456이 나옴.


-- Q)test1-3 (트랜잭션 말고 DB에 저장된 값을 삭제 한 후에 ROLLBACK 돌리기 가능?) :: INSERT 2개
INSERT INTO DEPARTMENT2 VALUES('T4','개발4팀', 'L2');

INSERT INTO DEPARTMENT2 VALUES('T5','개발5팀', 'L2');

INSERT INTO DEPARTMENT2 VALUES('T6','개발6팀', 'L2');

SELECT * FROM DEPARTMENT2;

COMMIT;

DELETE FROM DEPARTMENT2 
WHERE DEPT_ID IN('T4','T5');
SELECT * FROM DEPARTMENT2;

COMMIT;

ROLLBACK;  
SELECT * FROM DEPARTMENT2; 


-- Q)test2 (트랜잭션에서 SAVEPOINT로 돌아갈 때, 1,2,3순인 경우에 2먼저 하면, 3의 값은 제거된 값?)
INSERT INTO DEPARTMENT2 VALUES('T4','개발4팀', 'L2');
SAVEPOINT SP1;

INSERT INTO DEPARTMENT2 VALUES('T5','개발5팀', 'L2');
SAVEPOINT SP2;

INSERT INTO DEPARTMENT2 VALUES('T6','개발6팀', 'L2');
SAVEPOINT SP3;

SELECT * FROM DEPARTMENT2;

/*
DELETE FROM DEPARTMENT2 
WHERE DEPT_ID IN('T4','T5','T6');
SELECT * FROM DEPARTMENT2;
COMMIT;

*/
ROLLBACK;
SELECT * FROM DEPARTMENT2; -- > 123 위에서 COMMIT을 안했기 때문에

ROLLBACK SP1; --SQL Error [2181] [42000]: ORA-02181: ROLLBACK WORK 옵션이 부적합합니다  
SELECT * FROM DEPARTMENT2;

DELETE FROM DEPARTMENT2  -- 또 지운건 어떻게 알고 있는거지?
WHERE DEPT_ID IN('T4','T5','T6');

DELETE FROM DEPARTMENT2  
WHERE DEPT_ID IN('T4','T5');
SELECT * FROM DEPARTMENT2;

ROLLBACK TO SP1;
SELECT * FROM DEPARTMENT2;

ROLLBACK ;
SELECT * FROM DEPARTMENT2;


--> ROLLVBACK의 순서.. ROLLBACK -> 1 -> 2 -> 3 .. 만약에 2보다 1을 먼저하고 2를 하면 트랜잭션에 있던 값이 없어졌기 때문에 되돌릴 수 없음.
--> DELETE로 하면,? 왜 돌아와? 


ROLLBACK;

ROLLBACK TO SP2;
SELECT * FROM DEPARTMENT2;

-- SP1 지점까지 롤백
ROLLBACK TO SP1;
SELECT * FROM DEPARTMENT2;

--------------------------------------
-- 연습 문제 1)
-- USER_TEST 테이블을 만들어 데이터 삽입
CREATE TABLE USER_TEST(
	ID NUMBER,
	NAME VARCHAR2(30),
	RESERVE_DATE DATE,
	ROOM_NUM NUMBER
);

SELECT * FROM USER_TEST;


INSERT INTO USER_TEST VALUES(1,'홍길동', '2016-01-05', 2014);
INSERT INTO USER_TEST VALUES(2,'임꺽정', '2016-02-12', 918);
INSERT INTO USER_TEST VALUES(3,'장길산', '2016-01-16', 1208);
INSERT INTO USER_TEST VALUES(4,'홍길동', '2016-03-17', 504);
INSERT INTO USER_TEST VALUES(6,'김유신', NULL, NULL);
SELECT * FROM USER_TEST;


-- 연습 문제 2)
-- USER_TEST 테이블 만들어 UPDATE/DELETE 구문을 사용.

UPDATE USER_TEST  SET ROOM_NUM = 2002
WHERE NAME = '홍길동';
SELECT * FROM USER_TEST;

DELETE FROM USER_TEST 
WHERE RESERVE_DATE IS NULL;
SELECT * FROM USER_TEST;

-- 연습 문제 3)
-- USER_TEST 테이블을 UPDATE 하시오.
UPDATE USER_TEST  SET ROOM_NUM = 2002;
SELECT * FROM USER_TEST;


-- 연습 문제 4)
-- EMPLOYEE4 테이블을 EMPLOYEE 테이블과 같이 생성하기

CREATE TABLE EMPLOYEE4 AS SELECT * FROM EMPLOYEE;  

SELECT * FROM EMPLOYEE4; 


ROLLBACK;


-- 연습 문제 5)
-- EMPLOYEE4 테이블에서 고용일이 2000년대 이전인 사람의 월급을 100만원씩 인상하기

UPDATE EMPLOYEE4 SET SALARY = SALARY +1000000
WHERE EXTRACT  (YEAR FROM HIRE_DATE) < 2000;
SELECT * FROM EMPLOYEE4; 



ROLLBACK;

-- 연습 문제 6) 
-- EMPLOYEE4 테이블에서 한국에 근무하는 직원의 BONUS를 0.5로 변경

-- 1) JOIN 이용
UPDATE EMPLOYEE4 SET BONUS =0.5
WHERE DEPT_CODE IN (SELECT DEPT_ID 
					FROM EMPLOYEE4 
					JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID )
					WHERE LOCATION_ID = (SELECT LOCAL_CODE
							FROM LOCATION
							WHERE NATIONAL_CODE ='KO'));

SELECT * FROM EMPLOYEE4 ;

ROLLBACK;


UPDATE EMPLOYEE4 SET BONUS =0.5
WHERE DEPT_CODE IN (SELECT DEPT_ID 
					FROM EMPLOYEE4 
					JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID )
					WHERE LOCATION_ID IN (SELECT LOCAL_CODE
							FROM LOCATION
							JOIN NATIONAL USING(NATIONAL_CODE)
							WHERE NATIONAL_NAME ='한국'));



-- 2) 서브쿼리만,,
-- 오.. IN을 써야 함.  ( 다중 행이라서 등가가 안됨. IN 사용해야 함! )
UPDATE EMPLOYEE4 SET BONUS = 0.5
WHERE DEPT_CODE IN ( SELECT DEPT_ID 
					FROM DEPARTMENT 
					WHERE LOCATION_ID = (SELECT LOCAL_CODE
											FROM LOCATION 
											WHERE NATIONAL_CODE = 'KO'));
SELECT * FROM EMPLOYEE4 ;

UPDATE EMPLOYEE4 SET BONUS = 0.5
WHERE DEPT_CODE IN ( SELECT DEPT_ID 
					FROM DEPARTMENT 
					WHERE LOCATION_ID IN (SELECT LOCAL_CODE
											FROM LOCATION 
											WHERE NATIONAL_CODE IN (SELECT NATIONAL_CODE
																  FROM NATIONAL 
																  WHERE NATIONAL_NAME= '한국')));



-- 3) 선생님 풀이
UPDATE EMPLOYEE4 
SET BONUS = 0.5
WHERE EMP_NAME IN(
		SELECT EMP_NAME 
		FROM EMPLOYEE4 
		LEFT JOIN DEPARTMENT ON(DEPT_CODE= DEPT_ID)
		LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
		LEFT JOIN "NATIONAL" USING(NATIONAL_CODE)
		WHERE NATIONAL_NAME = '한국');
SELECT * FROM EMPLOYEE4 ;






SELECT LOCAL_CODE
FROM LOCATION
WHERE NATIONAL_CODE ='KO';
						
					
SELECT LOCATION_ID
FROM EMPLOYEE4 
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID )
WHERE LOCATION_ID = (SELECT LOCAL_CODE
		FROM LOCATION
		WHERE NATIONAL_CODE ='KO');

UPDATE EMPLOYEE4 SET BONUS =0.5
WHERE DEPT_CODE= (SELECT LOCAL_CODE
		FROM LOCATION
		WHERE NATIONAL_CODE ='KO');
	
ROLLBACK;
	
SELECT * FROM EMPLOYEE4 ;


(SELECT LOCAL_CODE
FROM LOCATION 
WHERE NATIONAL_CODE = 'KO');




