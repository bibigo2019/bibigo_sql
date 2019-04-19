/*��α� ID ������ ���� ������*/
CREATE SEQUENCE BLOG_SEQ;
/*��α� ���̺�*/
CREATE TABLE BLOG(
  BLOG_ID NUMBER PRIMARY KEY,             /*��α� ID*/
  TITLE VARCHAR2(256 CHAR) NOT NULL,      /*����*/
  REG_DATE DATE DEFAULT SYSDATE,          /*�����*/
  UPDATE_DATE DATE DEFAULT SYSDATE,       /*������*/
  IMG BLOB,                               /*��α� Ÿ��Ʋ �̹���*/
  SUMMARY VARCHAR2(1000)                  /*��α� ����*/
);

/*����� ���̺�*/
CREATE TABLE MEMBER(
  MEMBER_ID VARCHAR2(20 CHAR) PRIMARY KEY,  /*����� ID*/
  PASSWORD VARCHAR2(256 CHAR) NOT NULL,     /*��й�ȣ */
  NAME VARCHAR2(20 CHAR) NOT NULL,          /*�̸� */
  ADMIN CHAR(1) NOT NULL,                   /*������ ���� Y/N*/
  ADDRESS VARCHAR2(256 CHAR),               /*�ּ�*/
  PHONE VARCHAR2(20 CHAR),                  /*����ó*/
  EMAIL VARCHAR2(40 CHAR),                  /*�̸���*/
  SALT VARCHAR2(16) NOT NULL,               /*��й�ȣ ������ ���� Ű*/
  BLOG_ID NUMBER REFERENCES BLOG(BLOG_ID),  /*blog ID*/
  AVATA BLOB,                               /*�ƹ�Ÿ*/
  REG_DATE DATE DEFAULT SYSDATE,            /*�����*/
  UPDATE_DATE DATE DEFAULT SYSDATE          /*������*/
);

/*�Խù� ID ������*/
CREATE TABLE BOARD_SEQ;
/*�Խù� ���̺�*/
CREATE TABLE POST(
  POAST_ID NUMBER PRIMARY KEY,            /*�Խù� ID*/
  BLOG_ID NUMBER REFERENCES BLOG(BLOG_ID),/*��α� ID*/
  TITLE VARCHAR2(256 CHAR) NOT NULL,      /*����*/
  CONTENT CLOB,                           /*����*/
  READ_CNT NUMBER DEFAULT 0,              /*��ȸ��*/
  REG_DATE DATE DEFAULT SYSDATE,          /*�����*/
  UPDATE_DATE DATE DEFAULT SYSDATE        /*������*/
);

/*��� ID ������*/
CREATE SEQUENCE COMMENTS_SEQ;
/*��� ���̺�*/
CREATE TABLE COMMENTS(                  
  CMT_ID NUMBER PRIMARY KEY,                                /*��� ID*/
  PA_CMT_ID NUMBER,                                         /*�θ� ��� ID*/
  BLOG_ID NUMBER REFERENCES BLOG(BLOG_ID),                  /*��α� ID*/         
  POST_ID NUMBER REFERENCES POST(POST_ID),                  /*�Խù� ID*/
  DEPTH NUMBER DEFAULT 0,                                   /*��� ����*/
  MEMBER_ID VARCHAR2(10 CHAR) REFERENCES MEMBER(MEMBER_ID), /*����� ID*/
  CONTENT VARCHAR(2000),                                   /*��� ����*/
  REG_DATE DATE DEFAULT SYSDATE,                            /*�����*/
  UPDATE_DATE DATE DEFAULT SYSDATE                          /*������*/
);

/*���� ID ������*/
CREATE SEQUENCE FILE_SEQ;
/*���� ���̺�*/
CREATE TABLE FILES(
  FILE_ID NUMBER PRIMARY KEY,                               /*���� ID*/
  POST_ID NUMBER REFERENCES POST(POST_ID),                  /*�Խù� ID*/
  TYPE VARCHAR2(1 CHAR),                                    /*÷�� �������� �̹������� F/I*/
  NAME VARCHAR2(2000 CHAR) NOT NULL,                        /*�����̸�*/
  CONTENT BLOB,                                             /*���ϵ�����*/
  REG_DATE DATE DEFAULT SYSDATE,                            /*�����*/
  UPDATE_DATE DATE DEFAULT SYSDATE                          /*������*/
);

SELECT * FROM BLOG;
SELECT * FROM MEMBER;
SELECT * FROM POST;
SELECT * FROM COMMENTS;
SELECT * FROM FILES;
COMMIT;

/*������ ����� �׽�Ʈ��*/
INSERT INTO MEMBER VALUES ('admin', '1234', 'admin', 'Y', '��Ƽķ�۽�', '010-1111-1111', 'admin@naver.com', 'salt1',
  1, NULL, SYSDATE, SYSDATE);

UPDATE MEMBER SET 
ADMIN = 'Y';

/*�ʿ��� ����Ʈ �̹��� ����*/
DELETE FROM FILES
WHERE POST_ID != -1;