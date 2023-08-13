/*
 * - 데이터 딕셔너리
 * 자원을 효율적으로 관리하기 위한 다양한 정보를 저장하는 시스템 테이블
 * 
 * 데이터 딕셔너리는 사용자가 테이블을 생성하거나, 
 * 사용자를 변경하는 등의 작업을 할 때, 
 * 데이터베이스 서버에 의해 자동으로 갱신되는 테이블
 * (== 중앙 뇌) 
 * 
 * 
 * - 1) USER_TABLES : 자신의 계정이 소유한 객체 등에 관한 정보를 조회할 수 있는 딕셔너리 뷰
 * 
 */

SELECT * FROM USER_TABLES;

---------------------------------------------------------------------------------------------------------

-- DQL(Data Query Language) : 데이터 질의(조회) 언어 ==> SELECT 
-- DML(Data Manipulation Language) : 데이터 조작 언어 
-- 테이블에 데이터 삽입, 수정, 삭제 ==> INSER, UPDATE, DELETE

-- TCL(Transaction Control Language) : 트랜잭션 제어 언어 
-- DML 수행 내용을 Commit, Rollback 하는 언어 

-- DCL(Data Control Language) : 데이터 제어 언어
-- 권한 생성 및 회수 
-- GRANT , REVOKTE

-- DDL(Data Definition Language) : 데이터 정의 언어
-- 객체(OBJECT)를 만들고(CREATE), 수정(ALTER), 삭제(DROP) 등
-- 데이터의 전체 구조를 정의하는 언어로 주로 DB관리자, 설계자가 사용함 


-- 오라클에서의 객체 : 테이블(TABLE), 뷰(VIEW) , 시퀀스(SEQUENCE), 
--                     인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER)
--					   프로시져(PROCEDURE), 함수(FUNCTION)
--                     동의어(SYNONYM) , 사용자(USER)

--------------------------------------------------------------------------------
-- #1
-- CREATE(창조, 생성)
-- 테이블이나 인덱스, 뷰 등 다양한 데이터베이스 객체를 생성하는 구문
-- 테이블로 생성된 객체는 DROP 구문을 통해 제거할 수 있다. 


-- 1. 테이블 생성하기

-- 테이블이란?
-- 행(row)과 열(column)으로 구성되는 가장 기본적인 데이터베이스 객체 
-- 데이터베이스 내에서 모든 데이터는 테이블을 통해서 저장된다. 

-- [표현식]
/*
 * CREATE TABLE 테이블명 (
 * 			컬럼명 자료형(크기),
 * 			컬럼명 자료형(크기),
 * 			컬럼명 자료형(크기)
 * 			...
 * );
 * 
 */

/*
 * 자료형
 * 
 * NUMBER 		: 숫자형(정수, 실수)
 * 
 * CHAR(크기) 	: 고정길이 문자형 (최대 2000BYTE)
 * 			--> ex)CHAR(10) 컬럼에 'ABC' 3BYTE 문자열만 저장해도 10BYTE 저장공간을 모두 사용함. 
 *			--> 지정된 값인 경우에 사용 권장 ex) 주민번호, 휴대폰 번호 등.
 * VARCHAR2(크기) : 가변길이 문자형 (최대 4000BYTE)
 * 			--> ex)VARCHAR2(10) 컬럼에 'ABC' 3BYTE 문자열만 저장하면 나머지 7bYTE는 반환.
 * 
 * DATE 		: 날짜 타입
 * BLOB  		: 대용량 이진 데이터(4GB) ex) 파일
 * CLOB  		: 대용량 문자 데이터(4GB) ex) 게시판
 * 
 */


-- MEMBER 테이블 생성
CREATE TABLE "MEMBER" (
	MEMBER_ID VARCHAR2(20),
	MEMBER_PW VARCHAR2(20),
	MEMBER_NAME VARCHAR2(30),
	MEMBER_SSN CHAR(14),
   	ENROLL_DATE DATE DEFAULT SYSDATE
);

-- SQL 작성법 : 대문자 작성권장, 연결된 단어 사이는 "_"(언더바) 사용
-- 문자인코딩 UTF-8 : 영어, 숫자 1BYTE, 한글 3BYTE 취급 (특수문자도 대부분 3BYTE)

-- 만든 테이블 확인
SELECT * FROM MEMBER;

-- 2. 컬럼에 주석 달기
-- [표현식]
-- COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';

COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원 아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PW  IS '회원 비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME  IS '회원 이름';
COMMENT ON COLUMN MEMBER.MEMBER_SSN IS '회원 주민번호';
COMMENT ON COLUMN MEMBER.ENROLL_DATE  IS '회원 가입일';


-- MEMBER 테이블에 샘플 데이터 삽입
-- INSERT INTO 테이블명 VALUES(값1, 값2, ...);

INSERT INTO MEMBER VALUES('MEM01','123ABC','홍길동','991213-1234567',DEFAULT);

SELECT * FROM MEMBER;

-- *INSERT/UPDATE 시 컬럼값으로 DEFAULT를 작성하면,
-- 테이블 생성 시 해당 컬럼에 지정된 DEFAULT 값으로 삽입이 된다. 

INSERT INTO MEMBER VALUES('MEM02','321ASF','김영희','981113-2233445',DEFAULT);
INSERT INTO MEMBER VALUES('MEM03','WER346','박철수','872541-6677889',SYSDATE);


INSERT INTO MEMBER(MEMBER_ID , MEMBER_PW , MEMBER_NAME )
VALUES('MEM04','wlk342','김훈');


-- ** JDBC에서 날짜를 입력받았을 때 삽입하는 방법 **
-- JAVA-> DB 날짜정보 보냄.
--> 이때는 문자형으로 넘어옴 '2022-09-13 17:33:27'
----> 그러므로 TO_DATE를 이용해 형변환 함!
INSERT INTO "MEMBER" VALUES('MEM05', 'GDX123', '이유리','543241-4567891',
						TO_DATE('2022-09-13 17:33:27', 'YYYY-MM-DD HH24:MI:SS'));

SELECT * FROM MEMBER;

COMMIT;


-- ** NUMBER 타입의 문제점 **
CREATE TABLE MEMBER2(
	MEMBER_ID VARCHAR2(20),
	MEMBER_PW VARCHAR2(20),
	MEMBER_NAME VARCHAR2(30),
	MEMBER_TEL NUMBER
);

INSERT INTO MEMBER2 VALUES('MEM01','Pass01','고길동',7712341234);
INSERT INTO MEMBER2 VALUES('MEM02','Pass02','이길동',01012341234);

SELECT * FROM MEMBER2;

-- NUMBER 타입의 컬럼의 데이터 삽입 시,
--> 제일 앞에 0이 있으면 이를 자동으로 제거함.
--> 전화번호, 주민등록번호 처럼 숫자로만 되어있는 데이터라도 
--> 0으로 시작할 가능성이 있으면 CHAR, VARCHR2 같은 문자형 사용


------------------------------------------------------------------------------

-- 제약조건(CONSTRAINTS)

/*
 * 사용자가 원하는 조건의 데이터만 유지하기 위해서 
 * 특정 컬럼에 설정하는 제약. 
 * 데이터 무결성 보장을 목적으로 함. 
 * --> 중복 데이터 X 
 * 
 * 
 * + 입력 데이터에 문제가 없는지 자동으로 검사하는 목적 
 * + 데이터의 수정/삭제 가능 여부 검사등을 목적으로 함.
 * --> 제약조건을 위배하는 DML 구문은 수행할 수 없음!! 
 * 
 * 
 * 제약조건 종류
 * PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY
 */

-- 1. NOT NULL
-- 해당 컬럼에 반드시 값이 기록되어야 하는 경우 사용
-- 삽입 / 수정 시 NULL값을 허용하지 않도록 컬럼레벨에서 제한

CREATE TABLE USER_USED_NN(
	USER_NO NUMBER NOT NULL, -- 사용자 번호(모든 사용자는 사용자 번호가 있어야 함)
							   --> 컬럼레벨 제약조건 설정
	USER_ID VARCHAR2(20), 
	USER_PW VARCHAR2(30),
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50)
);

-- if) DEFAULT 값 있으면? 

INSERT INTO USER_USED_NN
VALUES(1,'USER01','PASS01','홍길동','남','010-1234-5678','hong12@kh.or.kr');

INSERT INTO USER_USED_NN
VALUES(NULL,NULL,NULL,NULL,NULL,'010-1234-5678','hong12@kh.or.kr');
--> NOT NULL 제약조건에 위배되어 오류 발생
--> SQL Error [1400] [23000]: ORA-01400: NULL을 ("KH"."USER_USED_NN"."USER_NO") 안에 삽입할 수 없습니다

------------------------------------------------------------------------------------

-- 2. UNIQUE 제약 조건
-- 컬럼에 입력값에 대해서 중복을 제한하는 제약조건 
-- 컬럼레벨에서 설정 가능, 테이블 레벨에서 설정 가능
-- 단, UNIQUE 제약조건이 설정된 컬럼에 NULL 값은 중복 삽입 가능.

-- * 테이블 레벨 : 테이블 생성 시 컬럼 정의가 끝난 후 마지막에 작성 

-- * 제약조건 지정 방법
-- 1) 컬럼 레벨 : [CONSTRAINT 제약조건명] 제약조건 
-- 2) 테이블 레벨 : [CONSTRAINT 제약조건명] 제약조건 (컬럼명)


CREATE TABLE USER_USED_UK(
	USER_NO NUMBER ,
	USER_ID VARCHAR2(20) UNIQUE , -- 컬럼 레벨 (제약조건명 미지정) 
--	USER_ID VARCHAR2(20) CONSTRANINT USER_ID_U UNIQUE , -- 컬럼 레벨 (제약조건명 지정) 	 
	--USER_ID VARCHAR2(20),
	USER_PW VARCHAR2(30),
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50)
	/* 테이블 레벨 */
--	UNIQUE(USER_ID) -- 테이블 레벨 (제약조건명 미지정)
--	CONSTRAINT USER_ID_U UNIQUE(USER_ID) -- 테이블 레벨 (제약조건명 지정)
);


INSERT INTO USER_USED_UK
VALUES(1,'USER01','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr');

INSERT INTO USER_USED_UK
VALUES(1,'USER01','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr');
--SQL Error [1] [23000]: ORA-00001: 무결성 제약 조건(KH.SYS_C008416)에 위배됩니다
--같은 아이디인 데이터가 이미 테이블에 있으므로 UNIQUE 제약조건에 위배되어 오류발생



INSERT INTO USER_USED_UK
VALUES(1,NULL,'PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr');
--> 아이디에 NULL값 삽입 가능.

INSERT INTO USER_USED_UK
VALUES(1,NULL,'PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr');
--> 아이디에 NULL 값 중복 삽입 가능

SELECT *  FROM USER_USED_UK;


----------------------------------------------------------------------------

--UNIQUE 복합키
-- 두개 이상의 컬럼을 묶어서 하나의 UNIQUE 제약조건을 설정함.

-- * 복합키 지정은 테이블 레벨만 가능함!
-- * 복합키 지정되는 모든 컬럼의 값이 같을 때 위배됨. (== > 둘다 똑같으면 위배됨.)


CREATE TABLE USER_USED_UK2(
	USER_NO NUMBER ,
	USER_ID VARCHAR2(20),
	USER_PW VARCHAR2(30),
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	CONSTRAINT USER_ID_NAME_U UNIQUE(USER_ID, USER_NAME)
);

INSERT INTO USER_USED_UK2
VALUES(1,'USER01','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr');

INSERT INTO USER_USED_UK2
VALUES(1,'USER02','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr');

INSERT INTO USER_USED_UK2
VALUES(1,'USER02','PASS01','고길동', '남','010-1234-5678','hong1234@kh.or.kr');

INSERT INTO USER_USED_UK
VALUES(1,NULL,'PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr');

INSERT INTO USER_USED_UK
VALUES(1,'USER01','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr');
-- SQL Error [1] [23000]: ORA-00001: 무결성 제약 조건(KH.SYS_C008416)에 위배됩니다
-- 맨 위에서 삽입한 값이랑 똑같으므로 위배됨! 

--------------------------------------------------------------------------------------------

-- 3. PRIMARY KEY(기본키) 제약조건

-- 테이블에서 한 행의 정보를 찾기위해 사용할 컬럼을 의미함.
-- 테이블에 대한 식별자(학번, 사번, 회원번호) 역할을 함.

-- NOT NULL + UNIQUE 제약조건의 의미 --> 중복되지 않는 값이 필수로 존재해야 함!

-- 한 테이블당 한개만 설정할 수 있음.
-- 컬럼레벨, 테이블레벨 둘다 설정 가능!
-- 한개 컬럼에 설정할 수 도 있고 , 여러개의 컬럼을 묶어서 설정할 수 있음.

CREATE TABLE USER_USED_PK(
	USER_NO NUMBER CONSTRAINT USER_NO_PK PRIMARY KEY, -- 컬럼레벨
	USER_ID VARCHAR2(20),
	USER_PW VARCHAR2(30),
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50)
	-- 테이블 레벨
--	CONSTRAINT USER_NO_PK PRIMARY KEY(USER_ID)
);

INSERT INTO USER_USED_PK
VALUES(1,'USER02','PASS02','이순신', '남','010-5678-9012','LEE1234@kh.or.kr');

INSERT INTO USER_USED_PK
VALUES(1,'USER01','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr');
-- ORA-00001: 무결성 제약 조건(KH.USER_NO_PK)에 위배됩니다
--> 기본키 중복으로 오류

INSERT INTO USER_USED_PK
VALUES(NULL,'USER01','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr');
-- ORA-01400: NULL을 ("KH"."USER_USED_PK"."USER_NO") 안에 삽입할 수 없습니다
-- 기본키가 NULL 이므로 오류


------------------------------------------------------------------------------------------

-- PRIMARY KEY 복합키 (테이블 레벨만 가능)

CREATE TABLE USER_USED_PK2(
	USER_NO NUMBER,  -- 컬럼레벨
	USER_ID VARCHAR2(20),
	USER_PW VARCHAR2(30),
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	-- 테이블 레벨
	CONSTRAINT USER_NO_ID_PK PRIMARY KEY(USER_ID, USER_NO) -- 복합키
);

INSERT INTO USER_USED_PK2
VALUES(1,'USER01','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(1,'USER02','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr'); -- 가능! NO 은 같지만, ID가 틀림

INSERT INTO USER_USED_PK2
VALUES(2,'USER01','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr'); -- 가능! NO은 틀리지만, ID가 같음.

INSERT INTO USER_USED_PK2
VALUES(1,'USER01','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr');
-- ORA-00001: 무결성 제약 조건(KH.USER_NO_ID_PK)에 위배됩니다
-- 회원 번호화 아이디 둘다 중복되었을 떄만 제약조건 위배 에러 발생


INSERT INTO USER_USED_PK2
VALUES(3,NULL,'PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr');
-- ORA-01400: NULL을 ("KH"."USER_USED_PK2"."USER_NO") 안에 삽입할 수 없습니다
INSERT INTO USER_USED_PK2
VALUES(NULL,NULL,'PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr');
-- ORA-01400: NULL을 ("KH"."USER_USED_PK2"."USER_NO") 안에 삽입할 수 없습니다
-- PRIMARY KEY는 NULL이 들어갈 수 없음.


---------------------------------------------------------------------------------------------------------------------

-- 4. FOREIGN KEY (외부키/ 외래키) 제약조건

-- 참조된 다른 테이블의 컬럼이 제공하는 값만 사용할 수 있음. 
-- FOREIGN KEY 제약조건에 의해서 테이블간 관계가 형성됨. 
-- 제공하는 값 외에는 NULL(참조하는 값 없음)을 사용할 수 있음.

-- 컬럼 레벨일 경우
-- 컬럼명 자료형(크기) [CONSTRAINT 이름] REFRENCES 참조할테이블명 [(참조할 컬럼)] [삭제룰]


-- 테이블 레벨일 경우
--  [CONSTRAINT 이름] FOREIGN KEY(적용할 컬럼명) REFERENCES 참조할테이블명 [(참조할 컬럼)] [삭제룰]

-- * 참조될 수 있는 컬럼은 PRIMARY KEY 컬럼과, UNIQUE 지정된 컬럼만 외래키로 사용할 수 있음.
-- 참조할 테이블의 참조할 컬럼명이 생략되면, PRIMARY KEY로 설정된 컬럼이 자동 참조할 컬럼이 됨.


-- 1번째 테이블
CREATE TABLE USER_GRADE(
	GRADE_CODE NUMBER PRIMARY KEY,
	GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE VALUES(10,'일반회원');
INSERT INTO USER_GRADE VALUES(20,'우수회원');
INSERT INTO USER_GRADE VALUES(30,'특별회원');

SELECT * FROM USER_GRADE;


-- 2번째 테이블
CREATE TABLE USER_USED_FK(
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PW VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	GRADE_CODE NUMBER CONSTRAINT GRADE_CODE_FK REFERENCES USER_GRADE /*(GRADE_CODE)*/-- 컬럼 레벨에서 외래키
																-- 컬럼명 미작성 USER_GRADE 테이블의 PK(기본키) 자동참조 
	-- 테이블 레벨
--	CONSTRAINT GRADE_CODE_FK FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE
								--> FOREIGN KEY라는 단어는 테이블 레벨에서만 사용! 

	--USER_USED_PK 의 PK를 USER_USED_FK의 FK로 사용함.
	);

COMMIT;

-- 
INSERT INTO USER_USED_FK
VALUES(1, 'USER01','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr',10);

INSERT INTO USER_USED_FK
VALUES(2, 'USER02','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr',10);

INSERT INTO USER_USED_FK
VALUES(3, 'USER03','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr',30);

INSERT INTO USER_USED_FK
VALUES(4, 'USER04','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr',NULL);

INSERT INTO USER_USED_FK
VALUES(5, 'USER04','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr',50);
-- ORA-00001: 무결성 제약 조건(KH.SYS_C008424)에 위배됩니다
--> 50이라는 값은 USER_GRADE 테이블 GRADE_CODE 컬럼에서 제공하는 값이 아니므로
--  외래키 제약조건에 위배되어 오류 발생.

COMMIT;

SELECT * FROM USER_USED_FK;

---------------------------------------------------------------------------------

-- * FOREIGN KEY 삭제 옵션

-- 부모테이블(USER_GRADE)의 데이터 삭제 시 자식 테이블(USER_USED_FK)의 데이터를 
-- 어떤식으로 처리할 지에 대한 내용을 설정할 수 있다.

-- 1) ON DELETE RESTRICTED(삭제 제한)로 기본 지정되어 있음.
--   외래키로 지정된 컬럼에서 사용되고 있는 값일 경우
--   제공하는 컬럼의 값을 삭제하지 못함.
-->>>  자식이 사용하고 있는 값은 부모가 지울 수 없음

DELETE FROM USER_GRADE WHERE GRADE_CODE = 30;
-- ORA-02292: 무결성 제약조건(KH.GRADE_CODE_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
--> 부모가 삭제할 수 없음! 

SELECT * FROM USER_USED_FK;

DELETE FROM USER_GRADE WHERE GRADE_CODE = 20;
SELECT * FROM USER_GRADE;
--> 20 삭제됨! 
-->>> 왜냐하면, 자식이 사용하고있지 않기 때문! (GRADE_CODE 중 20은 외래키로 참조되고 있지 않았으므로 삭제가 가능함!)

ROLLBACK;


-- 2) ON DELETE SET NULL : 부모키 삭제시 자식키를 NULL로 변경하는 옵션

-- 1번 테이블
CREATE TABLE USER_GRADE2(
	GRADE_CODE NUMBER PRIMARY KEY,
	GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE2 VALUES(10,'일반회원');
INSERT INTO USER_GRADE2 VALUES(20,'우수회원');
INSERT INTO USER_GRADE2 VALUES(30,'특별회원');

SELECT * FROM USER_GRADE2;


-- 2번째 테이블
-- ON DELETE SET NULL 삭제 옵션이 적용된 테이블 생성
CREATE TABLE USER_USED_FK2(
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PW VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	GRADE_CODE NUMBER CONSTRAINT GRADE_CODE_FK2 REFERENCES USER_GRADE2 ON DELETE SET NULL
																			/* 삭제옵션*/
	);

INSERT INTO USER_USED_FK2
VALUES(1, 'USER01','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr',10);

INSERT INTO USER_USED_FK2
VALUES(2, 'USER02','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr',10);

INSERT INTO USER_USED_FK2
VALUES(3, 'USER03','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr',30);

INSERT INTO USER_USED_FK2
VALUES(4, 'USER04','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr',NULL);


COMMIT;

SELECT * FROM USER_GRADE2;
SELECT * FROM USER_USED_FK2;

DELETE FROM USER_GRADE2 
WHERE GRADE_CODE = 10;

SELECT * FROM USER_GRADE2; --> 10 삭제됨
SELECT * FROM USER_USED_FK2; --> 10을 가지고 있는 값이 NULL로 변경



-- 3) ON DELETE CASCADE : 부모키 삭제 시 자식키도 함께 삭제됨
-- 부모키 삭제 시, 값을 사용하는 자식 테이블의 컬럼에 해당하는 행이 삭제가 됨!

-- 1번 테이블
CREATE TABLE USER_GRADE3(
	GRADE_CODE NUMBER PRIMARY KEY,
	GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE3 VALUES(10,'일반회원');
INSERT INTO USER_GRADE3 VALUES(20,'우수회원');
INSERT INTO USER_GRADE3 VALUES(30,'특별회원');


SELECT * FROM USER_GRADE3;


-- 2번째 테이블
-- ON DELETE CASCADE 삭제 옵션이 적용된 테이블 생성
CREATE TABLE USER_USED_FK3(
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PW VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	GRADE_CODE NUMBER CONSTRAINT GRADE_CODE_FK3 REFERENCES USER_GRADE3 ON DELETE CASCADE
																			/* 삭제옵션*/
	);

INSERT INTO USER_USED_FK3
VALUES(1, 'USER01','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr',10);

INSERT INTO USER_USED_FK3
VALUES(2, 'USER02','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr',10);

INSERT INTO USER_USED_FK3
VALUES(3, 'USER03','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr',30);

INSERT INTO USER_USED_FK3
VALUES(4, 'USER04','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr',NULL);

COMMIT;

SELECT * FROM USER_GRADE3;
SELECT * FROM USER_USED_FK3;


-- 부모테이블인 USER_GRADE3에서 GRADE_CODE = 10삭제
--> ON DELETE CASCADE 옵션이 설정되어 있어서 오류없이 삭제됨
DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10;

------------------------------------------------------------------------------------

-- 5. CHECK 제약 조건 : 컬럼에 기록되는 값에 조건 설정을 할 수 있음.
-- CHECK(컬럼명 비교연산자 비교값)
-- 주의 : 비교값은 리터럴만 사용할 수 있음. 변하는 값이나 함수는 사용 못함. 

CREATE TABLE USER_USED_CHECK(
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PW VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10) CONSTRAINT GENDER_CHECK CHECK(GENDER IN('남','여')),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50)
);


INSERT INTO USER_USED_CHECK
VALUES(1, 'USER01','PASS01','홍길동', '남','010-1234-5678','hong1234@kh.or.kr');

INSERT INTO USER_USED_CHECK
VALUES(1, 'USER01','PASS01','홍길동', '남자','010-1234-5678','hong1234@kh.or.kr');
-- ORA-02290: 체크 제약조건(KH.GENDER_CHECK)이 위배되었습니다
-- GENDER 컬럼에 CHECK 제약조건으로 '남' 또는 '여' 만 기록 가능한데, '남자'라는 조건 외 값이 들어와 에러발생


-- ** CHECK 제약조건은 범위로도 설정 가능 ??
-- CHECK(COL > 0  AND COL <90)

CREATE TABLE USER_USED_CHECK1(
	USER_NO NUMBER CONSTRAINT CHECK_NO CHECK(USER_NO > 0  AND USER_NO < 90),
);

-- [연습 문제]
-- 회원가입용 테이블 생성(USER_TEST)
-- 컬럼명 : USER_NO(회원번호) - 기본키(PK_USER_TEST), 0
--         USER_ID(회원아이디) - 중복금지(UK_USER_ID), 0
--         USER_PWD(회원비밀번호) - NULL값 허용안함(NN_USER_PWD),0
--         PNO(주민등록번호) - 중복금지(UK_PNO), NULL 허용안함(NN_PNO), ^
--         GENDER(성별) - '남' 혹은 '여'로 입력(CK_GENDER),
--         PHONE(연락처),
--         ADDRESS(주소),
--         STATUS(탈퇴여부) - NOT NULL(NN_STATUS), 'Y' 혹은 'N'으로 입력(CK_STATUS) ^
-- 각 컬럼의 제약조건에 이름 부여할 것
-- 5명 이상 INSERT할 것


CREATE TABLE USER_TEST1 (
	USER_NO NUMBER CONSTRAINT PK_USER_TEST PRIMARY KEY ,
	USER_ID VARCHAR2(20) CONSTRAINT UK_USER_ID UNIQUE,
	USER_PWD VARCHAR2(30) CONSTRAINT NN_USER_PWD NOT NULL ,
	PNO CHAR(14) CONSTRAINT UK_PNO NOT NULL,
	GENDER VARCHAR2(20) CONSTRAINT CK_GENDER CHECK(GENDER IN('남','여')),
	PHONE VARCHAR2(30),
	ADDRESS VARCHAR2(100),
	STATUS VARCHAR2(3) DEFAULT 'N' CONSTRAINT NN_STATUS NOT NULL , 
	CONSTRAINT NN_PNO UNIQUE (PNO),
	CONSTRAINT CK_STATUS CHECK(STATUS IN('Y','N'))
	);

SELECT * FROM USER_TEST1;

COMMENT ON COLUMN USER_TEST1.USER_NO IS '회원번호';
COMMENT ON COLUMN USER_TEST1.USER_ID IS '회원아이디';
COMMENT ON COLUMN USER_TEST1.USER_PWD IS '회원비밀번호';
COMMENT ON COLUMN USER_TEST1.PNO IS '주민등록번호';
COMMENT ON COLUMN USER_TEST1.GENDER IS '성별';
COMMENT ON COLUMN USER_TEST1.PHONE IS '연락처';
COMMENT ON COLUMN USER_TEST1.ADDRESS IS '주소';
COMMENT ON COLUMN USER_TEST1.STATUS IS '탈퇴여부';


INSERT INTO USER_TEST1
VALUES(1, 'USER01','PASS01','012345-67890', '남','01020013290','서울시 구로구','N');

INSERT INTO USER_TEST1
VALUES(2, 'USER02','PASS02','124124-67890', '여','01023420457','서울시 서초구','Y');

INSERT INTO USER_TEST1
VALUES(3, 'USER03','PASS03','01235-63490', '남','01032165442','서울시 영등포구','N');

INSERT INTO USER_TEST1
VALUES(4, 'USER04','PASS04','12325-23590', '여','01022231234','서울시 강남구','Y');

INSERT INTO USER_TEST1
VALUES(5, 'USER05','PASS05','12343-67457', '남','01036542157','경기도 수원','Y');


SELECT * FROM USER_TEST1;


------------------------------------------------------------------------------------------------

-- 8. SUBQUERY 를 이용한 테이블 생성
-- 컬럼명, 데이터 타입, 값이 복사되고 , 제약조건은 NOT NULL만 복사됨.

-- 1) 테이블 전체 복사
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE ;
--> 서브쿼리의 조회 결과(RESULT SET)의 모양대로 테이블이 생성됨.

SELECT * FROM EMPLOYEE_COPY;

-- 2) JOIN 후 원하는 컬럼만 테이블 복사 
CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

SELECT * FROM EMPLOYEE_COPY2;
--> 서브쿼리로 테이블 생성시 
-- 테이블의 형태(컬럼명, 데이터타입) + NOT NULL 제약조건만 복사!
-- 제약조건, 코멘트는 복사되지 않음. 그러므로 별도 추가 작업이 필요! 



-- 9. 제약조건 추가
-- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] PRIMARY KEY(컬럼명)

-- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명)
--								    REFERENCES 참조테이블명(참조컬럼명)

-- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] UNIQUE(컬럼명)

-- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] CHECK(컬럼명 비교연산자 비교값)

-- EMPLOYEE_COPY 테이블은 NOT NULL 제약조건만 복사됨 
-- EMP_ID 컬럼에 PRIMARY KEY 제약조건 추가

ALTER TABLE EMPLOYEE_COPY ADD CONSTRAINT PK_EMP_COPY PRIMARY KEY(EMP_ID);

-- EMPLOYEE 테이블의 DEPT_CODE에 외래키 제약조건 추가 
-- 참조테이블은 DEPARTMENT, 참조 컬럼은 DEPARTMENT의 기본키 

ALTER TABLE EMPLOYEE ADD CONSTRAINT EMP_DEPT_CODE
FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT ON DELETE SET NULL;

-- EMPLOYEE 테이블의 SAL_LEVEL 외래키 제약조건 추가
-- 참조 테이블은 SAL_GRADE, 참조컬럼은 SAL_GRADE의 기본키
ALTER TABLE EMPLOYEE ADD CONSTRAINT EMP_SAL_LEVEL
FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE ON DELETE SET NULL;

-- DEPARTMENT 테이블의 LOCATION_ID에 외래키 제약조건 추가
-- 참조테이블은 LOCATION ,참조 컬럼은 LOCATION의 기본키
ALTER TABLE DEPARTMENT ADD CONSTRAINT DEPT_LOCATION_ID
FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION ON DELETE SET NULL;

-- LOCATION 테이블의 NATIONAL_CODE에 외래키 제약조건 추가
-- 참조 테이블은 NATIONAL, 참조 컬럼은 NATIONAL의 기본키
ALTER TABLE LOCATION ADD CONSTRAINT LCT_NATIONAL_CODE
FOREIGN KEY(NATIONAL_CODE) REFERENCES NATIONAL ON DELETE SET NULL;









-- test :: NOT NULL 테이블 레벨 
CREATE TABLE USER_TEST2 (
	USER_NO NUMBER PRIMARY KEY ,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30)  NOT NULL ,
	PNO CHAR(14) NOT NULL,
	GENDER VARCHAR2(20) CHECK(GENDER IN('남','여')),
	PHONE VARCHAR2(30),
	STATUS VARCHAR2(3) DEFAULT 'N'  NOT NULL , 
	UNIQUE (PNO),
	CHECK(STATUS IN('Y','N')),
    NOT NULL(PHONE)
);











































