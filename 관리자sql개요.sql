-- 한줄 주석
/*
 * 범위 주석
 */
-- 쓸때는 sql 파일을 dbeaver에 끌어놓으면 됨.

-- 새로운 사용자 계정 생성 (sys 계정으로 진행)
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER kh IDENTIFIED BY kh1234;

-- 사용자 계정 권한 부여 설정
GRANT RESOURCE, CONNECT TO kh;

-- 객체가 생성될 수 있는 공간 할당량 지정
ALTER USER kh DEFAULT TABLESPACE SYSTEM QUOTA UNLIMITED ON SYSTEM;





