/*블로그 ID 생성을 위한 시퀀스*/
CREATE SEQUENCE BLOG_SEQ;
/*블로그 테이블*/
CREATE TABLE BLOG(
  BLOG_ID NUMBER PRIMARY KEY,             /*블로그 ID*/
  TITLE VARCHAR2(256 CHAR) NOT NULL,      /*제목*/
  REG_DATE DATE DEFAULT SYSDATE,          /*등록일*/
  UPDATE_DATE DATE DEFAULT SYSDATE,       /*수정일*/
  IMG BLOB,                               /*블로그 타이틀 이미지*/
  SUMMARY VARCHAR2(1000)                  /*블로그 주제*/
);

/*사용자 테이블*/
CREATE TABLE MEMBER(
  MEMBER_ID VARCHAR2(20 CHAR) PRIMARY KEY,  /*사용자 ID*/
  PASSWORD VARCHAR2(256 CHAR) NOT NULL,     /*비밀번호 */
  NAME VARCHAR2(20 CHAR) NOT NULL,          /*이름 */
  ADMIN CHAR(1) NOT NULL,                   /*관리자 여부 Y/N*/
  ADDRESS VARCHAR2(256 CHAR),               /*주소*/
  PHONE VARCHAR2(20 CHAR),                  /*연락처*/
  EMAIL VARCHAR2(40 CHAR),                  /*이메일*/
  SALT VARCHAR2(16) NOT NULL,               /*비밀번호 생성을 위한 키*/
  BLOG_ID NUMBER REFERENCES BLOG(BLOG_ID),  /*blog ID*/
  AVATA BLOB,                               /*아바타*/
  REG_DATE DATE DEFAULT SYSDATE,            /*등록일*/
  UPDATE_DATE DATE DEFAULT SYSDATE          /*수정일*/
);

/*게시물 ID 시퀀스*/
CREATE TABLE BOARD_SEQ;
/*게시물 테이블*/
CREATE TABLE POST(
  POAST_ID NUMBER PRIMARY KEY,            /*게시물 ID*/
  BLOG_ID NUMBER REFERENCES BLOG(BLOG_ID),/*블로그 ID*/
  TITLE VARCHAR2(256 CHAR) NOT NULL,      /*제목*/
  CONTENT CLOB,                           /*내용*/
  READ_CNT NUMBER DEFAULT 0,              /*조회수*/
  REG_DATE DATE DEFAULT SYSDATE,          /*등록일*/
  UPDATE_DATE DATE DEFAULT SYSDATE        /*수정일*/
);

/*댓글 ID 시퀀스*/
CREATE SEQUENCE COMMENTS_SEQ;
/*댓글 테이블*/
CREATE TABLE COMMENTS(                  
  CMT_ID NUMBER PRIMARY KEY,                                /*댓글 ID*/
  PA_CMT_ID NUMBER,                                         /*부모 댓글 ID*/
  BLOG_ID NUMBER REFERENCES BLOG(BLOG_ID),                  /*블로그 ID*/         
  POST_ID NUMBER REFERENCES POST(POST_ID),                  /*게시물 ID*/
  DEPTH NUMBER DEFAULT 0,                                   /*댓글 깊이*/
  MEMBER_ID VARCHAR2(10 CHAR) REFERENCES MEMBER(MEMBER_ID), /*사용자 ID*/
  CONTENT VARCHAR(2000),                                   /*댓글 내용*/
  REG_DATE DATE DEFAULT SYSDATE,                            /*등록일*/
  UPDATE_DATE DATE DEFAULT SYSDATE                          /*수정일*/
);

/*파일 ID 시퀀스*/
CREATE SEQUENCE FILE_SEQ;
/*파일 테이블*/
CREATE TABLE FILES(
  FILE_ID NUMBER PRIMARY KEY,                               /*파일 ID*/
  POST_ID NUMBER REFERENCES POST(POST_ID),                  /*게시물 ID*/
  TYPE VARCHAR2(1 CHAR),                                    /*첨부 파일인지 이미지인지 F/I*/
  NAME VARCHAR2(2000 CHAR) NOT NULL,                        /*파일이름*/
  CONTENT BLOB,                                             /*파일데이터*/
  REG_DATE DATE DEFAULT SYSDATE,                            /*등록일*/
  UPDATE_DATE DATE DEFAULT SYSDATE                          /*수정일*/
);

SELECT * FROM BLOG;
SELECT * FROM MEMBER;
SELECT * FROM POST;
SELECT * FROM COMMENTS;
SELECT * FROM FILES;
COMMIT;

/*관리자 만들기 테스트용*/
INSERT INTO MEMBER VALUES ('admin', '1234', 'admin', 'Y', '멀티캠퍼스', '010-1111-1111', 'admin@naver.com', 'salt1',
  1, NULL, SYSDATE, SYSDATE);

UPDATE MEMBER SET 
ADMIN = 'Y';

/*필요한 디폴트 이미지 파일*/
DELETE FROM FILES
WHERE POST_ID != -1;