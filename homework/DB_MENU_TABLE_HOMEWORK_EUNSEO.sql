-- 자바는 EXPORT 
-- DB는 SCRIPT 

-- DB에서 배운 것
-- 1) 조회 [SELECT]
/*    1) 산술 및 숫자 : ABS , MOD, ROUND, CEIL, FLOOR, TRUNC
 * 	  2) 날짜     (SYSDATE, SYSTIMESTAMP, MONTHS_BETWEEN, ADD_MONTHS, LAST_DAY // EXTRACT)
 *    3) 중복확인 (DISTINCT)
 *    4) 포함확인 : LIKE (& , _ ) + ESCAPE
 *	  5) 형변환  : TO_CHAR (9, 0, L), TO_CHAR (YYYY, MM, DD, AM, Hh, MI, DAY) / TO_CHAR (SYSDATE) 
 *                 TO_NUMBER  , NVL , NVL2
 *    6) 조건절  : 비교 / 대입 / 논리(+BETWEEN, NOT) / (NOT) IN 연산자 / IS (NOT) NULL 
 *       선택    : DECODE , CASE WHEN THEN ELSE END 
 * 	  7) 그룹    : 단일 - LENGTH , INSTR(위치 반환) , SUBSTR(문자열 자르기), TRIM(문자/공백 제거)
 *                 그룹 - SUM , AVG, MIN, MAX, COUNT
 * 	  8) 집계    : ROLLUP , CUBE
 *    9) 집합    : UNION , INTERSECT , UNION ALL, MINUS
 * 	 10) 조인    : JOIN (ON / USING) , LEFT/ RIGHT/ FULL JOIN , CROSS JOIN
 * 				   NON EQUAL JOIN , SELF JOIN, NATURAL JOIN, 다중 JOIN		
 */

-- 2) DML
/*
 *   1) INSERT INTO 테이블명 (컬럼명) VALUSE(데이터 값, 데이터 값)  
 *   +) INSERT시,   VALUES 대신 서브쿼리 사용 가능!
 * 
 *   2) UPDATE 테이블명 SET 컬럼명 = 바꿀값
 * 				[WHERE 컬럼명 비교 연산자 비교값];
 * 	 +) 조건절을 설정하지 않은 경우, 모든 행의 컬럼값이 변경됨.
 *   +) 여러 컬럼을 한번에 수정 시, 콤마(,)로 컬럼을 구분하면 됨.
 *   +) UPDATE시,   서브쿼리 사용 가능!
 * 
 *   3) MERGE (병합)
 *  
 *   3) DELETE FROM 테이블명 WHERE 조건설정
 *   +) 조건절을 설정하지 않은 경우, 모든 행의 컬럼값이 변경됨.
 * 
 * +) TCL 
 * 	:: 변경 가능한 것. : INSERT, UPDATE, DELETE, MERGE
 * 	 - ROLLBACK
 *   - COMMIT
 * 	 - SAVEPOINT
 * 
 *     SAVEPOINT 포인트명1;
    		...
       SAVEPOINT 포인트명2;
    		...
       ROLLBACK TO 포인트명1; -- 포인트1 지점 까지 데이터 변경사항 삭제
 * 
 */



-- 3) DDL
/* 
 *   1)CREATE TABLE 테이블명 (
 * 			컬럼명 자료형(크기),
 * 			컬럼명 자료형(크기),
 * 			컬럼명 자료형(크기)
 * 			...
 *  	);
 * 
 * 	 2)COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
 * 
 * 
 *  +) TRUNCATE TABLE 테이블명; 
 * 		:: 테이블 전체 행 삭제할 수 있음.
 *      :: DELETE 보다 수행속도 fast , rollback 불가
 * 
 *  <제약조건>
 *  1) 컬럼 레벨 : [CONSTRAINT 제약조건명] 제약조건 
 *  2) 테이블 레벨 : [CONSTRAINT 제약조건명] 제약조건 (컬럼명)
 *  * 복합키 지정은 테이블 레벨만 가능함!
 *  * 복합키 지정되는 모든 컬럼의 값이 같을 때 위배됨. (== > 둘다 똑같으면 위배됨.)
 * 
 *  1. PRIMARY KEY
 *  2. NOT NULL
 *  3. UNIQUE
 *  4. CHECK
 *  5. FOREIGN KEY
 * -> 컬럼 레벨일 경우
 *    컬럼명 자료형(크기) [CONSTRAINT 이름] REFRENCES 참조할테이블명 [(참조할 컬럼)] [삭제룰]
 * -> 테이블 레벨일 경우
 *    [CONSTRAINT 이름] FOREIGN KEY(적용할 컬럼명) REFERENCES 참조할테이블명 [(참조할 컬럼)] [삭제룰]
 *
 *
 * * 참조될 수 있는 컬럼은 PRIMARY KEY 컬럼과, UNIQUE 지정된 컬럼만 외래키로 사용할 수 있음.
 *   참조할 테이블의 참조할 컬럼명이 생략되면, PRIMARY KEY로 설정된 컬럼이 자동 참조할 컬럼이 됨.
 *  
 * *  FOREIGN KEY 삭제 옵션
 * 1) ON DELETE RESTRICTED -->>>  자식이 사용하고 있는 값은 부모가 지울 수 없음
 * 2) ON DELETE SET NULL : 부모키 삭제시 자식키를 NULL로 변경하는 옵션
 * 3) ON DELETE CASCADE : 부모키 삭제 시 자식키도 함께 삭제됨
 * 
 *   4) CHECK(컬럼명 비교연산자 비교값)
 * 
 * 
 *   5) ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] 제약조건 (컬럼명)
 *                            [REFERENCES 테이블명 
 * 
 *      ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
 * 
 *   <컬럼 추가>
 *      ALTER TABLE 테이블명 ADD(컬럼명 데이터 타입 [DEFAULT '값']); 
 * 
 *   <컬럼 수정>
 *      ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입; --> 데이터 타입 변경
 *      ALTER TABLE 테이블명 MODIFY 컬럼명 DEFAULT '값'; --> DEFAULT 값 변경
 *      ALTER TABLE 테이블명 MODIFY 컬럼명 NULL/ NOT NULL; --> NULL 여부 변경 
 * 
 *   <컬럼 삭제>
 *      ALTER TABLE 테이블명 DROP(삭제할 컬럼명);
 *      ALTER TABLE 테이블명 DROP COLUMN 삭제할컬럼명;
 * 
 * 
 *   3. 이름변경 (컬럼, 제약조건, 테이블) 
 *    1) 컬럼명 변경 (DEPT_TITLE -> DEPT_NAME)
 *      ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
 * 
 *    2) 제약조건명 변경 (D_COPY_PK -> DEPT_COPY_PK)
 *      ALTER TABLE DEPT_COPY RENAME CONSTRAINT D_COPY_PK TO DEPT_COPY_PK;\
 *
 *    3) 테이블명 변경(DEPT_COPY -> DCOPY)
 *      ALTER TABLE DEPT_COPY RENAME TO DCOPY;
 * 
 * 
 *  6) DROP TABLE 테이블명 [CASCADE CONSTRAINTS];
 */


-- * 쇼핑몰 재고 (및 회원)관리 *
-- < 1. 테이블 설계 >

-- 1) 상품 테이블 (==> 조회 )
-- 상품 코드(PR_ID), 카테고리(CATEGORY), 상품명(PR_NAME), 상품 가격(PR_PRICE), 판매 상태(PR_STATUS)
-->    PK                    
-->                   ------------------------  2번에서 JOIN 해야 할 값 ---------------------                   


-- 2) 카테고리 테이블 
-- 카테고리ID(CATEGORY_ID) , 카테고리명(CATEGORY)
-->    PK                           UNIQUE

  
-- 3) 재고 테이블
-- 상품 코드(PR_ID), 카테고리(CATEGORY),  상품명(PR_NAME) , 재고 수량(INVENTORY),
-->    PK                 FK                   UNIQUE           
-->                                                               DEFAULT           
-- 판매 상태(PR_STATUS), 거래처(ACCOUNT), 단가(PRICE), 금액(TOTAL) 
-->                          UNIQUE         NOT NULL     NOT NULL
-->                                           DEFAULT    DEFAULT         


-- 4) 재고 총 금액 파악
-- 


--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- 4) 회원 테이블
-- 유저 ID , 유저PW ,  이름, 생년월일, 주소 , 등급,  마지막 구매 날짜?
-->  PK        NN               NN                       

-- 4-1) 등급
-- 등급명, 최소 구매, 최대 구매 
-->  PK      NN           NN

--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


-- < 1-2. 제약조건 >
--> UNIQUE => 상품명
--> NOT NULL => 거래처, 단가



-- < 1-3. JOIN 혹은 외래키 >
--> 상품테이블 : JOIN ==> 
				
--> 카테고리 
                


-- < 2. 추가 기능 >
-- 상품 테이블은 재고 테이블의 값을 상속?처럼 받아옴. (JOIN)

-- 구분(종류)에 따라 , 총 상품의 개수 , (판매가격) 합계 가격 파악 (GROUP , COUNT)

-- 현 재고가 0인 값 추출 (CASE)
--> 위 값에 의해서 상품으로 보여질 값들을 제한하기?


-- + 회원 구매 내역이 많으면 등급 나누기
-- + 회원되고 마지막 구매날짜가 12개월(MONTHS_BETWEEN) 이상이면 휴먼계정 설정 ()
-- + 이벤트 


--> 나중에 옵션 만들기

--------------------------------------------------------------------------------------------------------------------------
--                                        테이블 삭제 , 조회
--------------------------------------------------------------------------------------------------------------------------

DROP TABLE PRODUCT;
DROP TABLE CATEGORY;
DROP TABLE INVENTORY;

SELECT * FROM PRODUCT;
SELECT * FROM CATEGORY;
SELECT * FROM INVENTORY;


--------------------------------------------------------------------------------------------------------------------------
--                                           테이블 설계
--------------------------------------------------------------------------------------------------------------------------

-- 1) 상품(PRODUCT) 테이블 
-- 상품 코드(PR_ID), 카테고리(CATEGORY), 상품명(PR_NAME), 상품 가격(PR_PRICE), 판매 상태(PR_STATUS)

CREATE TABLE PRODUCT( 
		PR_ID VARCHAR2(20) CONSTRAINT PR_ID_PK PRIMARY KEY,
		CATEGORY VARCHAR2(30),
		PR_NAME VARCHAR2(30),
		PR_PRICE NUMBER,
		PR_STATUS VARCHAR2(30) CONSTRAINT PR_STATUS_NN NOT NULL
);


-- 2) 카테고리 (CATEGORY) 테이블 
-- 카테고리ID(CATEGORY_ID) , 카테고리명(CATEGORY)
CREATE TABLE CATEGORY( 
	CATEGORY_ID VARCHAR2(10) CONSTRAINT CG_ID_PK  PRIMARY KEY,
	CATEGORY VARCHAR2(50) CONSTRAINT CG_NN NOT NULL
);

-- 3) 재고(INVENTORY) 테이블 -- 외래키 존재
-- 상품 코드(PR_ID), 카테고리(CATEGORY),  상품명(PR_NAME) , 재고 수량(INVENTORY), 
-- 판매 상태(PR_STATUS), 거래처(ACCOUNT), 단가(PRICE), 재고 단가 금액(TOTAL) 
CREATE TABLE INVENTORY( 
	PR_ID VARCHAR2(20) CONSTRAINT IT_ID_PK PRIMARY KEY,
	CATEGORY VARCHAR2(50),
	PR_NAME VARCHAR2(10) CONSTRAINT PR_NAME_UQ UNIQUE,
	INVENTORY NUMBER DEFAULT 0,
	PR_STATUS VARCHAR2(20) DEFAULT '판매 보류',
	ACCOUNT VARCHAR2(20),
	PRICE NUMBER CONSTRAINT IT_PR_NN NOT NULL,
	TOTAL NUMBER CONSTRAINT IT_TT_NN NOT NULL
);

-- 4) 재고 상황 테이블 -- JOIN 
-- 상품 코드(PR_ID) 



--------------------------------------------------------------------------------------------------------
--                                        테이블에 값 추가
--------------------------------------------------------------------------------------------------------

-- 1) 상품(PRODUCT) 테이블 조회 => 테이블이라서 값 추가 X 

-- 2) 카테고리 값 추가
INSERT INTO CATEGORY VALUES('A0001', '상의');
INSERT INTO CATEGORY VALUES('A0002', '하의');
INSERT INTO CATEGORY VALUES('A0003', '원피스');
INSERT INTO CATEGORY VALUES('A0004', 'ACC');

SELECT * FROM CATEGORY; -------------------------------------------------------------------------> 나중에 지울거


-- 3) 재고 상품 값 추가 
-- 상품 코드(PR_ID), 카테고리(CATEGORY),  상품명(PR_NAME) , 재고 수량(INVENTORY), 
-- 판매 상태(PR_STATUS), 거래처(ACCOUNT), 단가(PRICE), 재고 총 금액(TOTAL) 
INSERT INTO INVENTORY VALUES('1','상의','반팔', 1, '판매 가능', 'KH', 25000);
INSERT INTO INVENTORY VALUES('12','상의','긴팔', 3, '판매 가능', 'KH', 10000, 30000);

INSERT INTO INVENTORY VALUES('11','상의','반팔', 2, '판매 가능', 'KH', 25000,
									(SELECT INVENTORY * PRICE FROM INVENTORY )); -- > 이렇게 하려면, 테이블 또 만들어서 가져와야 할 듯.


INSERT INTO INVENTORY VALUES('2','하의','청바지', 2, '판매 가능', 'KH', 25000 );
INSERT INTO INVENTORY VALUES('3','상의','긴팔', 3, '판매 가능', 'KH', 55000 );
INSERT INTO INVENTORY VALUES('4','하의','카고 바지', 1, '판매 가능', 'KH', 45000 );
INSERT INTO INVENTORY VALUES('5','원피스','체크', 2, NULL , 'KH', 35000 );
INSERT INTO INVENTORY VALUES('6','원피스','땡땡이',NULL ,NULL , 'KH', 35000 );


SELECT * FROM INVENTORY; -------------------------------------------------------------------------> 나중에 지울거




























