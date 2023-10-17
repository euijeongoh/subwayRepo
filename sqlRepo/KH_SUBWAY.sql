
-- ----------------------------------------------------
-- 테이블 삭제
-- ----------------------------------------------------
DROP TABLE BOARD CASCADE CONSTRAINTS; -- BOARD 테이블 
DROP TABLE ADMIN CASCADE CONSTRAINTS; -- ADMIN 테이블
DROP TABLE NOTICE CASCADE CONSTRAINTS; -- NOTICE 테이블
DROP TABLE FAQ CASCADE CONSTRAINTS; -- FAQ 테이블
DROP TABLE QNA CASCADE CONSTRAINTS; -- QNA 테이블
DROP TABLE SUBWAY_USER CASCADE CONSTRAINTS; -- USER 테이블
DROP TABLE STATION CASCADE CONSTRAINTS; -- SATION 테이블
DROP TABLE SUBWAY CASCADE CONSTRAINTS; -- SUBWAY STORE 테이블

-- ----------------------------------------------------
-- CREATE 테이블
-- ----------------------------------------------------
-- STATION 테이블 (김지섭)
CREATE TABLE "STATION" (
	"STATION_NO"	    NUMBER		    PRIMARY KEY
	,"STATION_NAME"	    VARCHAR2(100)	NOT NULL
	,"LINE_NO"	        NUMBER		    NOT NULL
	,"TRANSFER_YN"	    CHAR(1)		    NOT NULL
	,"EXIT_COUNT"	    NUMBER		    NOT NULL
	,"WEEK_START_TIME"	CHAR(4)		    NULL
	,"WEEK_END_TIME"	CHAR(4)	        NULL
	,"HOL_START_TIME"	CHAR(4)		    NULL
	,"HOL_END_TIME"	    CHAR(4)		    NULL
	,"TOILET_IO"	    CHAR(1)		    NULL
);

COMMENT ON COLUMN "STATION"."STATION_NO" IS '지하철역번호';
COMMENT ON COLUMN "STATION"."STATION_NAME" IS '역이름';
COMMENT ON COLUMN "STATION"."LINE_NO" IS '노선번호';
COMMENT ON COLUMN "STATION"."TRANSFER_YN" IS '환승여부';
COMMENT ON COLUMN "STATION"."EXIT_COUNT" IS '출구개수';
COMMENT ON COLUMN "STATION"."WEEK_START_TIME" IS '평일첫차시간';
COMMENT ON COLUMN "STATION"."WEEK_END_TIME" IS '평일막차시간';
COMMENT ON COLUMN "STATION"."HOL_START_TIME" IS '주말첫차시간';
COMMENT ON COLUMN "STATION"."HOL_END_TIME" IS '주말막차시간';
COMMENT ON COLUMN "STATION"."TOILET_IO" IS '화장실내외위치';

-- 유저 테이블 (현지연)
CREATE TABLE SUBWAY_USER (
   USER_NO             NUMBER          PRIMARY KEY
    , ID               VARCHAR2(100)   NOT NULL UNIQUE
    , PWD              VARCHAR2(100)   NOT NULL
    , NICK             VARCHAR2(100)   NOT NULL
    , ENROLL_DATE      TIMESTAMP       DEFAULT SYSDATE
    , DEL_YN           CHAR(1)         DEFAULT 'N' CHECK(DEL_YN IN ('Y' , 'N'))
    , PWDEDIT_DATE     TIMESTAMP
);
COMMENT ON COLUMN SUBWAY_USER.USER_NO IS '유저번호';
COMMENT ON COLUMN SUBWAY_USER.ID IS '유저 아이디';
COMMENT ON COLUMN SUBWAY_USER.PWD IS '유저 패스워드';
COMMENT ON COLUMN SUBWAY_USER.NICK IS '유저 닉네임';
COMMENT ON COLUMN SUBWAY_USER.ENROLL_DATE IS '가입일시';
COMMENT ON COLUMN SUBWAY_USER.DEL_YN IS '탈퇴여부';
COMMENT ON COLUMN SUBWAY_USER.PWDEDIT_DATE IS '마지막 수정일시';

DROP SEQUENCE SEQ_USER_NO;
CREATE SEQUENCE SEQ_USER_NO NOCYCLE NOCACHE;

-- BOARD, ADMIN 테이블 (조승범님)
CREATE TABLE ADMIN (
   ADMIN_NO            NUMBER          PRIMARY KEY
    ,ID                VARCHAR2(100)   NOT NULL UNIQUE
    ,PWD               VARCHAR2(100)   NOT NULL
    ,NICK              VARCHAR2(100)   NOT NULL
    ,DELETE_YN         CHAR(1)          DEFAULT 'N' CHECK(DELETE_YN IN('Y' , 'N'))
    ,PART_NAME         VARCHAR2(100)   NOT NULL
);
COMMENT ON COLUMN ADMIN.ADMIN_NO IS '관리자번호';
COMMENT ON COLUMN ADMIN.ID IS '관리자아이디';
COMMENT ON COLUMN ADMIN.PWD IS '관리자비밀번호';
COMMENT ON COLUMN ADMIN.NICK IS '관리자닉네임';
COMMENT ON COLUMN ADMIN.DELETE_YN IS '탈퇴여부';
COMMENT ON COLUMN ADMIN.PART_NAME IS '업무명';

CREATE TABLE BOARD (
   BOARD_NO               NUMBER              PRIMARY KEY
   ,STATION_NO            NUMBER              
   ,USER_NO               NUMBER              
   ,TITLE                 VARCHAR2(1000)      NOT NULL
   ,CONTENT               VARCHAR2(4000)      NOT NULL
   ,ENROLL_DATE           TIMESTAMP           DEFAULT SYSDATE
   ,MODIFY_DATE           TIMESTAMP
   ,INQUIRY               NUMBER              DEFAULT 0
   ,WRITER_NICK           VARCHAR2(100)      
   ,DELETE_YN             CHAR(1)             DEFAULT 'N' CHECK(DELETE_YN IN('Y' , 'N'))
);
COMMENT ON COLUMN BOARD.BOARD_NO IS '게시판번호';
COMMENT ON COLUMN BOARD.STATION_NO IS '지하철역번호';
COMMENT ON COLUMN BOARD.USER_NO IS '유저번호';
COMMENT ON COLUMN BOARD.TITLE IS '게시판제목';
COMMENT ON COLUMN BOARD.CONTENT IS '게시판내용';
COMMENT ON COLUMN BOARD.ENROLL_DATE IS '작성일시';
COMMENT ON COLUMN BOARD.MODIFY_DATE IS '수정일시';
COMMENT ON COLUMN BOARD.INQUIRY IS '조회수';
COMMENT ON COLUMN BOARD.WRITER_NICK IS '작성자닉네임';
COMMENT ON COLUMN BOARD.DELETE_YN IS '삭제여부';

DROP SEQUENCE SEQ_ADMIN_NO;
DROP SEQUENCE SEQ_BOARD_NO;

CREATE SEQUENCE SEQ_ADMIN_NO NOCYCLE NOCACHE;
CREATE SEQUENCE SEQ_BOARD_NO NOCYCLE NOCACHE;

-- NOTICE, FAQ 테이블 (오의정님)
CREATE TABLE NOTICE(
    NOTICE_NO            NUMBER             PRIMARY KEY
    , STATION_NO         NUMBER             
    , ADMIN_NO           NUMBER             
    , POST_TIME          TIMESTAMP          DEFAULT SYSDATE
    , TITLE              VARCHAR2(4000)     NOT NULL
    , CONTENT            VARCHAR2(4000)     NOT NULL
    , INQUIRY            NUMBER             DEFAULT 0
    , DELETE_YN          CHAR(1)            DEFAULT 'N' CHECK(DELETE_YN IN ('Y' , 'N'))
    , MODIFY_DATE        TIMESTAMP         
);

CREATE TABLE FAQ(
    FAQ_NO               NUMBER             PRIMARY KEY
    , STATION_NO         NUMBER             
    , ADMIN_NO           NUMBER             
    , FAQ_TITLE          VARCHAR2(4000)     NOT NULL
    , CONTENT            VARCHAR2(4000)     NOT NULL
    , POST_TIME          TIMESTAMP          DEFAULT SYSDATE
    , DELETE_YN          CHAR(1)            DEFAULT 'N' CHECK(DELETE_YN IN ('Y' , 'N'))
    , MODIFY_DATE        TIMESTAMP
);

DROP SEQUENCE SEQ_NOTICE_NO;
DROP SEQUENCE SEQ_FAQ_NO;

CREATE SEQUENCE SEQ_NOTICE_NO NOCYCLE NOCACHE;
CREATE SEQUENCE SEQ_FAQ_NO NOCYCLE NOCACHE;

-- QNA (이우철님)
CREATE TABLE QNA(
    QNA_NO               NUMBER             PRIMARY KEY
    , STATION_NO         NUMBER             
    , ADMIN_NO           NUMBER             
    , USER_NO            NUMBER             
    , POST_TIME          TIMESTAMP          DEFAULT SYSDATE
    , TITLE              VARCHAR2(100)      NOT NULL
    , CONTENT            VARCHAR2(1000)     NOT NULL
    , RE_TITLE           VARCHAR2(100)      NOT NULL
    , RE_CONTENT         VARCHAR2(1000)     NOT NULL
    , INQUIRY            NUMBER             DEFAULT 0
    , DELETE_YN          CHAR(1)            DEFAULT 'N' CHECK(DELETE_YN IN ('Y' , 'N'))
);

COMMENT ON COLUMN "QNA"."QNA_NO" IS '질의응답번호';
COMMENT ON COLUMN "QNA"."STATION_NO" IS '지하철역번호';
COMMENT ON COLUMN "QNA"."ADMIN_NO" IS '답변관리자번호';
COMMENT ON COLUMN "QNA"."USER_NO" IS '유저번호';
COMMENT ON COLUMN "QNA"."POST_TIME" IS '작성일시';
COMMENT ON COLUMN "QNA"."TITLE" IS '질의제목';
COMMENT ON COLUMN "QNA"."CONTENT" IS '질의내용';
COMMENT ON COLUMN "QNA"."RE_TITLE" IS '응답제목';
COMMENT ON COLUMN "QNA"."RE_CONTENT" IS '응답내용';
COMMENT ON COLUMN "QNA"."INQUIRY" IS '조회수';
COMMENT ON COLUMN "QNA"."DELETE_YN" IS '삭제여부';

DROP SEQUENCE SEQ_QNA_NO;
CREATE SEQUENCE SEQ_QNA_NO NOCYCLE NOCACHE;

-- SUBWAY STORE 테이블 (성병주님)
CREATE TABLE SUBWAY (	
    STORE_NO          NUMBER            PRIMARY KEY
    , STATION_NO      NUMBER            
    , ADMIN_NO        NUMBER            
    , TEL             CHAR(30)          NOT NULL 
    , STORE_NAME      VARCHAR2(50)      NOT NULL
    , ADDRESS         VARCHAR2(200)     NOT NULL
    , DEL_YN          CHAR(1)           DEFAULT 'N' CHECK(DEL_YN IN ('Y' , 'N'))
    , CLOSE_DATE        TIMESTAMP         
    , OPEN_DATE        TIMESTAMP         DEFAULT SYSDATE 
    , MODIFY_DATE     TIMESTAMP  
    , NEW_YN          CHAR(1)           DEFAULT 'N' CHECK(NEW_YN IN ('Y' , 'N'))
);

COMMENT ON COLUMN "SUBWAY"."STORE_NO" IS '매장일련번호';
COMMENT ON COLUMN "SUBWAY"."STATION_NO" IS '지하철역번호';
COMMENT ON COLUMN "SUBWAY"."ADMIN_NO" IS '관리자번호';
COMMENT ON COLUMN "SUBWAY"."TEL" IS '전화번호';
COMMENT ON COLUMN "SUBWAY"."STORE_NAME" IS '지점명';
COMMENT ON COLUMN "SUBWAY"."ADDRESS" IS '주소';
COMMENT ON COLUMN "SUBWAY"."DEL_YN" IS '매장폐업여부';
COMMENT ON COLUMN "SUBWAY"."CLOSE_DATE" IS '폐업일시';
COMMENT ON COLUMN "SUBWAY"."OPEN_DATE" IS '개업일시';
COMMENT ON COLUMN "SUBWAY"."MODIFY_DATE" IS '수정일시';
COMMENT ON COLUMN "SUBWAY"."NEW_YN" IS '신규매장여부';

-- ----------------------------------------------------
-- 외래키
-- ----------------------------------------------------



-- ----------------------------------------------------
-- 더미데이터
-- ----------------------------------------------------
-- SUBWAY_USER
INSERT INTO SUBWAY_USER(USER_NO, ID, PWD, NICK, ENROLL_DATE) VALUES(SEQ_USER_NO.NEXTVAL , 'USER01' , '1234' , '첫유저', SYSDATE);
INSERT INTO SUBWAY_USER(USER_NO, ID, PWD, NICK, ENROLL_DATE) VALUES(SEQ_USER_NO.NEXTVAL , 'USER02' , '1234' , '두번째유저', SYSDATE);

-- ADMIN
INSERT INTO ADMIN(ADMIN_NO, ID, PWD, NICK, PART_NAME) VALUES (1 ,'ADMIN01', '1234', 'STA', 'STATION');
INSERT INTO ADMIN(ADMIN_NO, ID, PWD, NICK, PART_NAME) VALUES (2, 'ADMIN02', '1234', 'SUB', 'SUBWAY');
INSERT INTO ADMIN(ADMIN_NO, ID, PWD, NICK, PART_NAME) VALUES (3, 'ADMIN03', '1234', 'FAQ', 'FAQ');
INSERT INTO ADMIN(ADMIN_NO, ID, PWD, NICK, PART_NAME) VALUES (4, 'ADMIN04', '1234', 'NOTI', 'NOTICE');
INSERT INTO ADMIN(ADMIN_NO, ID, PWD, NICK, PART_NAME) VALUES (5, 'ADMIN05', '1234', 'QNA', 'QNA');

-- SUBWAY STORE
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (1,220,2,'0507-1444-1097','써브웨이 테헤란로점','서울 강남구 테헤란로 314');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (2,219,2,'0507-1444-1097','써브웨이 테헤란로점','서울 강남구 테헤란로 314');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (3,621,2,'02-790-2286','써브웨이 한남점','서울 용산구 대사관로 63 한남치과');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (4,225,2,'02-6941-0386','써브웨이 사당역점','서울 서초구 동작대로 24 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (5,1014,2,'031-240-0889','써브웨이 수원역사점','경기 수원시 팔달구 덕영대로 924 3층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (6,221,2,'02-557-4727','써브웨이 강남역점','서울 강남구 강남대로 96길 12');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (7,226,2,'02-877-6687','써브웨이 낙성대점','서울 관악구 남부순환로 1904 1층 101호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (8,110,2,'031-878-7811','써브웨이 의정부역점','경기 의정부시 신흥로257번길 6');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (9,437,2,'031-392-3327','써브웨이 산본사거리점','경기 군포시 고산로 694');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (10,545,2,'031-792-1146','써브웨이 하남미사역점','경기 하남시 미사강변동로 74');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (11,213,2,'02-446-0423','써브웨이 강변역점','서울 광진구 강변역로 4길 10');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (12,302,2,'031-906-6754','써브웨이 일산동구청점','경기 고양시 일산동구 정발산로 38');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (13,221,2,'02-553-5232','써브웨이 강남우성점','서울 강남구 강남대로 66길 6 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (14,516,2,'0507-1345-1118','써브웨이 여의도화재보험점','서울 영등포구 국제금융로6길 38 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (15,914,2,'0507-1345-1118','써브웨이 여의도화재보험점','서울 영등포구 국제금융로6길 38 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (16,547,2,'031-794-2022','써브웨이 하남시청역점','경기 하남시 신평로 65');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (17,505,2,'02-3663-6837','써브웨이 발산역점','서울 강서구 마곡중앙6로 93 열린프라자 1층 101호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (18,519,2,'02-713-7775','써브웨이 공덕역롯데캐슬점','서울 마포구 마포대로 109 롯데캐슬프레지던트 상가 지하1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (19,616,2,'02-713-7775','써브웨이 공덕역롯데캐슬점','서울 마포구 마포대로 109 롯데캐슬프레지던트 상가 지하1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (21,215,2,'02-2202-1300','써브웨이 잠실역점','서울 송파구 올림픽로 293-19 현대타워 101호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (22,804,2,'02-2202-1300','써브웨이 잠실역점','서울 송파구 올림픽로 293-19 현대타워 101호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (23,737,2,'1544-1852','써브웨이 가산디지털단지점','서울 금천구 가산디지털1로 165 가산비지니스센터 102호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (24,227,2,'02-887-6887','써브웨이 서울대점','서울 관악구 관악로 156');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (25,201,2,'02-730-8777','써브웨이 을지로입구점','서울 중구 남대문로 112');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (26,727,2,'02-599-1014','써브웨이 이수역점','서울 동작구 동작대로 119-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (27,401,2,'0507-1405-7444','써브웨이 남양주진접점','경기 남양주시 진접읍 해밀에당1로 13 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (28,729,2,'0507-1424-3552','써브웨이 숭실대점','서울 동작구 사당로 10 지층 101호 ');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (29,239,2,'02-322-9431','써브웨이 신촌로데오점','서울 서대문구 연세로 23');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (30,236,2,'02-2636-1014','써브웨이 당산역점','서울 영등포구 양평로 58 그랜드컨벤션센타 1층 101호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (31,912,2,'02-2636-1014','써브웨이 당산역점','서울 영등포구 양평로 58 그랜드컨벤션센타 1층 101호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (32,405,2,'0507-1430-0501','써브웨이 노원역점','서울 노원구 노해로 502 KT노원지사 본관 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (33,704,2,'0507-1430-0501','써브웨이 노원역점','서울 노원구 노해로 502 KT노원지사 본관 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (34,240,2,'02-364-8870','써브웨이 이대점','서울 서대문구 이화여대길 34 1층 써브웨이 이대점');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (35,131,2,'02-737-0034','써브웨이 종로점','서울 종로구 종로 77 통일빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (36,341,2,'0507-1398-6110','써브웨이 가락시장점','서울 송파구 중대로 109 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (37,807,2,'0507-1398-6110','써브웨이 가락시장점','서울 송파구 중대로 109 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (38,1014,2,'031-244-0889','써브웨이 수원로데오점','경기 수원시 팔달구 매산로 7 ');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (39,928,2,'02-545-5729','써브웨이 봉은사역점','서울 강남구 봉은사로 627');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (40,933,2,'02-424-0020','써브웨이 석촌호수점','서울 송파구 석촌호수로 298 101호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (41,219,2,'02-557-5004','써브웨이 선릉점','서울 강남구 테헤란로 337 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (42,303,2,'031-906-3226','써브웨이 일산마두역점','경기 고양시 일산동구 중앙로 1191');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (43,412,2,'02-923-4010','써브웨이 성신여대점','서울 성북구 보문로34길 78');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (44,631,2,'0507-1406-2212','써브웨이 동덕여대점','서울 성북구 화랑로 13길 10 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (45,211,2,'0507-1417-9313','써브웨이 건대입구점','서울 광진구 아차산로 241 연한빌딩 102호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (46,718,2,'0507-1417-9313','써브웨이 건대입구점','서울 광진구 아차산로 241 연한빌딩 102호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (47,539,2,'0507-1372-6032','써브웨이 길동역점','서울 강동구 양재대로 1471');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (48,209,2,'0507-1344-2900','써브웨이 서울숲점','서울 성동구 왕십리로 108-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (49,507,2,'02-2603-5353','써브웨이 화곡역점','서울 강서구 강서로 159-1 우진빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (50,238,2,'02-324-6688','써브웨이 홍대점','서울 마포구 홍익로 10 서교푸르지오');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (51,229,2,'0507-1333-4455','써브웨이 신림역점','서울 관악구 신림로 34 SK허브그린');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (52,148,2,'032-611-1301','써브웨이 부천역점','경기 부천시 부일로 448 프리존빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (53,154,2,'032-421-6690','써브웨이 인천동암점','인천 부평구 열우물로 45 1층 104, 105호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (54,231,2,'02-2088-7279','써브웨이 구로디지털점','서울 구로구 디지털로34길 55 코오롱싸이언스밸리2차 1층109호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (55,212,2,'02-446-6444','써브웨이 구의점','서울 광진구 자양로 113 103, 104호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (56,132,2,'02-777-9200','써브웨이 시청점','서울 중구 세종대로 68 천일빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (57,200,2,'02-777-9200','써브웨이 시청점','서울 중구 세종대로 68 천일빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (58,751,2,'032-361-7848','써브웨이 인천산곡역점','인천 부평구 길주로364번길9');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (59,222,2,'02-581-0696','써브웨이 교대점','서울 서초구 서초중앙로22길 47 문화빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (60,331,2,'02-581-0696','써브웨이 교대점','서울 서초구 서초중앙로22길 47 문화빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (61,436,2,'031-440-8490','써브웨이 안양범계점','경기 안양시 동안구 시민대로 167 안양벤처텔 106호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (62,124,2,'0507-1354-1367','써브웨이 청량리역사점','서울 동대문구 왕산로 214 3층 313호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (63,140,2,'02-2068-0269','써브웨이 신도림점','서울 구로구 신도리동 경인로 661');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (64,233,2,'02-2068-0269','써브웨이 신도림점','서울 구로구 신도리동 경인로 661');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (65,312,2,'0507-1401-1502','써브웨이 연신내점','서울 은평구 연서로 215-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (66,604,2,'0507-1401-1502','써브웨이 연신내점','서울 은평구 연서로 215-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (67,535,2,'02-455-5440','써브웨이 아차산역점','서울 광진구 천호대로 666 그랜드 파크 오피스텔 상가 B-104');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (68,156,2,'032-876-4909','써브웨이 인천주안역점','인천 미추홀구 주안로 89');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (69,438,2,'031-391-0776','써브웨이 산본로데오점','경기 군포시 광정로 60 우주타운빌딩 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (70,745,2,'032-321-9757','써브웨이 부천중동점','경기 부천시 길주로 288');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (71,613,2,'0507-1310-6934','써브웨이 상수역점','서울 마포구 와우산로44 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (72,328,2,'02-546-2007','써브웨이 신사역점','서울 강남구 도산대로 124 대영빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (73,809,2,'02-403-7344','써브웨이 문정법조점','서울 송파구 충민로 5 송파한화오벨르스크 1층 111호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (74,139,2,'0507-1436-5255','써브웨이 영등포점','서울 영등포구 영중로 25');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (75,747,2,'032-323-1706','써브웨이 부천상동점','경기 부천시 상동로 87 가나베스트타운 103호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (76,333,2,'0507-1337-5227','써브웨이 양재역점','서울 서초구 남부순환로 2606 1층 103호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (77,723,2,'02-512-1014','써브웨이 논현역점','서울 서초구 강남대로 535 프린스빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (78,523,2,'02-723-7222','써브웨이 광화문점','서울 종로구 새문안로3길 19');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (79,927,2,'02-2051-2008','써브웨이 삼성점','서울 강남구 삼성로 520');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (80,408,2,'02-998-1641','써브웨이 수유역점','서울 강북구 오패산로 417');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (81,330,2,'02-595-8900','써브웨이 서울고속터미널점','서울 서초구 신반포로 194 지하1층 점포101호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (82,725,2,'02-595-8900','써브웨이 서울고속터미널점','서울 서초구 신반포로 194 지하1층 점포101호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (83,922,2,'02-595-8900','써브웨이 서울고속터미널점','서울 서초구 신반포로 194 지하1층 점포101호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (84,911,2,'0507-1387-1232','써브웨이 선유도역점','서울 영등포구 양평로 121');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (85,702,2,'02-2135-2535','써브웨이 수락산역점','서울 노원구 동일로 1669');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (86,908,2,'02-6053-2543','써브웨이 등촌역점','서울 양천구 공항대로 552 대우마이빌 101호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (87,208,2,'02-2299-3555','써브웨이 한양대점','서울 성동구 마조로 11');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (88,336,2,'0507-1484-8937','써브웨이 대치점','서울 강남구 도곡로 447');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (89,635,2,'02-978-3434','써브웨이 묵동점','서울 중랑구 동일로 952');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (90,708,2,'02-978-3434','써브웨이 묵동점','서울 중랑구 동일로 952');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (91,542,2,'02-427-0217','써브웨이 고덕역점','서울 강동구 동남로75길 13-10 1층 102호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (92,229,2,'02-888-8884','써브웨이 신림점','서울 관악구 신림로 318 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (93,717,2,'02-465-3285','써브웨이 세종대점','서울 광진구 광나루로 390');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (94,534,2,'02-456-6444','써브웨이 군자역점','서울 광진구 능동로 290 삼일빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (95,716,2,'02-456-6444','써브웨이 군자역점','서울 광진구 능동로 290 삼일빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (96,924,2,'02-544-1014','써브웨이 신논현점','서울 서초구 강남대로 499');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (97,322,2,'02-2277-0883','써브웨이 충무로점','서울 중구 퇴계로 197 1층 101호 (필동2가)');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (98,417,2,'02-2277-0883','써브웨이 충무로점','서울 중구 퇴계로 197 1층 101호 (필동2가)');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (99,805,2,'0507-1370-4320','써브웨이 석촌역점','서울 송파구 송파대로 438');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (100,931,2,'0507-1370-4320','써브웨이 석촌역점','서울 송파구 송파대로 438');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (101,142,2,'0507-1308-6890','써브웨이 동양미래대점','서울 구로구 경인로 445 8호관 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (102,808,2,'02-3012-1259','써브웨이 문정역점','서울 송파구 법원로 114 현대엠스테이트 C동 119호 ');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (103,413,2,'02-744-4949','써브웨이 한성대점','서울 성북구 동소문로 10 카프리빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (104,340,2,'0507-1315-1636','써브웨이 수서역점','서울 강남구 밤고개로1길 10 수서현대벤처빌 b126호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (105,421,2,'02-702-2454','써브웨이 숙명여대점','서울 용산구 청파로47길 42');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (106,443,2,'031-418-1900','써브웨이 안산한대역점','경기 안산시 상록구 광덕1로 385 엔타운');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (107,608,2,'02-533-9464','써브웨이 상암점','서울 마포구 월드컵북로 361 DMC 이안상암2단지');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (108,315,2,'02-736-6535','써브웨이 홍제점','서울 서대문구 통일로 432-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (109,207,2,'0507-1372-1801','써브웨이 왕십리점','서울 성동구 왕십리로 328 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (110,530,2,'0507-1372-1801','써브웨이 왕십리점','서울 성동구 왕십리로 328 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (111,133,2,'02-777-8552','써브웨이 서울역동자점','서울 용산구 후암로 107 게이트웨이타워');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (112,420,2,'02-777-8552','써브웨이 서울역동자점','서울 용산구 후암로 107 게이트웨이타워');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (113,238,2,'02-336-0522','써브웨이 홍대아트점','서울 마포구 와우산로 117 1층 102호 ');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (114,319,2,'0507-1373-9000','써브웨이 안국점','서울 종로구 우정국로 69 동일빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (115,300,2,'0507-1419-1995','써브웨이 고양대화역점','경기 고양시 일산서구 중앙로 1581 1층 105호, 106호 ');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (116,511,2,'02-2644-5368','써브웨이 오목교점','서울 양천구 오목로 315 대영상가');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (117,210,2,'02-497-2800','써브웨이 성수역점','서울 성동구 아차산로 113');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (118,537,2,'02-483-1079','써브웨이 천호역점','서울 강동구 천호대로 1012');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (119,801,2,'02-483-1079','써브웨이 천호역점','서울 강동구 천호대로 1012');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (120,1003,2,'02-899-6690','써브웨이 광명일직점','경기 광명시 양지로 19 어바브릭스 B동 1층 106호, 107호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (121,745,2,'032-611-0420','써브웨이 부천위브더스테이트점','경기 부천시 신흥로 170');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (122,746,2,'032-321-3277','써브웨이 부천시청점','경기 부천시 석천로169번길 22 101호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (123,1002,2,'0507-1479-2347','써브웨이 시흥점','서울 금천구 시흥대로 224 1층 103호, 104호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (124,224,2,'02-896-6000','써브웨이 방배역점','서울 서초구 효령로 111 1층 써브웨이방배점');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (125,1025,2,'0507-1416-1386','써브웨이 평택로데오점','경기 평택시 중앙2로 16 셀럽프라자 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (126,306,2,'0507-1400-9668','써브웨이 일산화정점','경기 고양시 덕양그 화정로 69 한화꿈에그린아파트');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (127,537,2,'02-485-1077','써브웨이 천호점','서울 강동구 올림픽로 664');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (128,801,2,'02-485-1077','써브웨이 천호점','서울 강동구 올림픽로 664');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (129,732,2,'0507-1348-0366','써브웨이 신대방삼거리점','서울 동작구 상도로 105 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (130,816,2,'031-755-6785','써브웨이 성남태평점','경기 성남시 수정구 수정로 179');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (131,518,2,'02-715-0080','써브웨이 마포점','서울 마포구 마포대로 53 마포트라팰리스');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (132,136,2,'02-815-1014','써브웨이 노량진역점','서울 동작구 노량진로 152-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (133,916,2,'02-815-1014','써브웨이 노량진역점','서울 동작구 노량진로 152-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (134,510,2,'02-2603-5368','써브웨이 목동역점','서울 양천구 오목로 238 론드사옥');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (135,216,2,'02-425-5582','써브웨이 잠실새내역점','서울 송파구 올림픽로 130 은성빌딩 층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (136,906,2,'0507-1476-6777','써브웨이 가양역점','서울 강서구 양천로 470 그레이스힐 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (137,129,2,'02-766-7537','써브웨이 종로5가점','서울 종로구 종로 213-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (138,918,2,'02-815-6429','써브웨이 중앙대점','서울 동작구 흑석로 79');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (139,1008,2,'0507-1330-5476','써브웨이 AK플라자금정점','경기 군포시 엘에스로 143 201동 2010호 써브웨이');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (140,437,2,'0507-1330-5476','써브웨이 AK플라자금정점','경기 군포시 엘에스로 143 201동 2010호 써브웨이');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (141,202,2,'02-318-6202','써브웨이 명동성당점','서울 중구 명동길 74 1898 명동성당 118호 써브웨이');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (142,321,2,'02-318-6202','써브웨이 명동성당점','서울 중구 명동길 74 1898 명동성당 118호 써브웨이');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (143,1006,2,'031-464-5210','써브웨이 안양1번가점','경기 안양시 만안구 만안로223번길 7');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (144,814,2,'031-732-1137','써브웨이 단대오거리역점','경기 성남시 중원구 산성대로372번길 10');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (145,327,2,'02-548-1014','써브웨이 압구정역점','서울 강남구 압구정로28길 13 1층 써브웨이 ');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (146,115,2,'0507-1345-1237','써브웨이 방학역점','서울 도봉구 도봉로 684 1층 103호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (147,308,2,'031-965-9965','써브웨이 고양원흥역점','경기 고양시 덕양구 원흥5로 25 106호 107호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (148,1001,2,'02-803-2346','써브웨이 독산점','서울 금천구 시흥대로 399');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (149,711,2,'0507-1364-2938','써브웨이 상봉역점','서울 중랑구 망우로 316');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (150,707,2,'02-977-0045','써브웨이 공릉점','서울 노원구 공릉로 207');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (151,520,2,'02-702-7672','써브웨이 애오개역점','서울 마포구 마포대로 180');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (152,128,2,'02-747-9809','써브웨이 동대문역점','서울 종로구 종로 263-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (153,415,2,'02-747-9809','써브웨이 동대문역점','서울 종로구 종로 263-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (154,123,2,'0507-1415-1592','써브웨이 경희대점','서울 동대문구 경희대로 5-1 1츠');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (155,104,2,'031-863-2270','써브웨이 동두천점','경기 동두천시 지행로 81 지행프라자 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (156,152,2,'032-521-6789','써브웨이 부평중앙점','인천 부평구 부평문화로 63');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (157,404,2,'02-952-2266','써브웨이 중계은행사거리점','서울 노원구 한글비석로 269');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (158,230,2,'02-847-8255','써브웨이 대림삼거리점','서울 영등포구 시흥대로 681');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (159,749,2,'032-507-7883','써브웨이 인천삼산점','인천 부평구 체육관로 24 청호빌딩 107호 ');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (160,913,2,'02-782-1518','써브웨이 여의도KBS본관점','서울 영등포구국회대로62길 25 교육시설재난공제회관 ');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (161,237,2,'0507-1316-9890','써브웨이 합정역메세나폴리스점','서울 마포구 양화로 45 213, 214호 메세나폴리스');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (162,612,2,'0507-1316-9890','써브웨이 합정역메세나폴리스점','서울 마포구 양화로 45 213, 214호 메세나폴리스');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (163,220,2,'02-501-1554','써브웨이 역삼점','서울 강남구 테헤란로25길 20 역삼현대벤쳐텔 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (164,722,2,'0507-1395-1019','써브웨이 학동역점','서울 강남구 학동로 171 삼익악기빌딩 1층 103호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (165,629,2,'02-916-1269','써브웨이 고려대점','서울 성북구 고려대로24길 20');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (166,2006,2,'02-2607-9979','써브웨이 신정네거리역점','서울 양천구 중앙로 265');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (167,930,2,'0507-1329-5141','써브웨이 삼전역점','서울 송파구 백제고분로 197');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (168,239,2,'0507-1472-7026','써브웨이 서강대점','서울 마포구 백범로 21 1층 1호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (169,1019,2,'0507-1342-8004','써브웨이 오산대역점','경기 오산시 내삼미로 89');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (170,522,2,'02-737-0808','써브웨이 정동점','서울 중구 새문안로 30 ');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (171,301,2,'031-915-7649','써브웨이 일산주엽역점','경기 고양시 일산서구 중앙로 1415 102호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (172,600,2,'0507-1432-1479','써브웨이 응암점','서울 은평구 은평로 108 101호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (173,435,2,'0507-1316-8511','써브웨이 평촌스마트스퀘어점','경기 안양시 동안구 시민대로327번길 6 112호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (174,239,2,'02-3147-1248','써브웨이 신촌점','서울 서대문구 신촌로 121 아남오피스텔');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (175,1012,2,'031-290-5448','써브웨이 성균관대점','경기 수원시 장안구 서부로 2066 성균관대학교 학생회관 2층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (176,150,2,'032-323-0265','써브웨이 부천송내역점','경기 부천시 부일로 203');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (177,304,2,'031-936-7497','써브웨이 일산고양터미널점','경기 고양시 일산동구 중앙로 1036 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (178,135,2,'02-706-6227','써브웨이 용산전자랜드점','서울 용산구 청파로 74 전자랜드 본관 A동 104호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (179,407,2,'02-999-5906','써브웨이 쌍문역점','서울 도봉구 도봉로 468');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (180,122,2,'02-134-2343','써브웨이 외대점','서울 동대문구 이문로 116');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (181,414,2,'0507-1343-5656','써브웨이 대학로점','서울 종로구 동숭길 101 현대엘리베이터(주)');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (182,146,2,'0507-1415-4908','써브웨이 부천역곡역점','경기 부천시 부일로 725');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (183,433,2,'02-504-3140','써브웨이 과천중앙점','경기 과천시 별양상가3로 14');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (184,204,2,'0507-1336-2100','써브웨이 동대문역사문화공원역점','서울 중구 장충단로 227-2 1,2층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (185,416,2,'0507-1336-2100','써브웨이 동대문역사문화공원역점','서울 중구 장충단로 227-2 1,2층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (186,526,2,'0507-1336-2100','써브웨이 동대문역사문화공원역점','서울 중구 장충단로 227-2 1,2층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (187,738,2,'02-2611-8006','써브웨이 광명철산역점','경기 광명시 철산로 15 웅진빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (188,410,2,'02-988-1641','써브웨이 미아사거리역점','서울 강북구 도봉로 41-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (189,318,2,'02-725-5926','써브웨이 경복궁점','서울 종로구 사직로 115');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (190,434,2,'031-423-1230','써브웨이 인덕원역점','경기 안양시 동안구 관악대로 486');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (191,610,2,'02-307-6196','써브웨이 마포구청점','서울 마포구 월드컵로34길 7');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (192,311,2,'02-3157-3167','써브웨이 구파발점','서울 은평구 진관2로 29-21 드림스퀘어');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (193,213,2,'0507-1434-2240','써브웨이 광장점','서울 광진구 아차산로 480');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (194,611,2,'02-338-9933','써브웨이 망원역점','서울 마포구 월드컵로 87 마포로얄프라자');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (195,913,2,'0507-1438-1003','써브웨이 여의도 국회의사당','서울 영등포구 국회대로 70길 19 대하빌딩 1층');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (196,206,2,'0507-1397-9899','써브웨이 상왕십리점','서울 성동구 상왕십리동 806-2');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (197,409,2,'0507-1305-1596','써브웨이 미아역점','서울 강북구 도봉로 209 성은빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (198,141,2,'02-6923-2155','써브웨이 구로NC점','서울 구로구 구로중앙로 152');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (199,806,2,'0507-1342-2160','써브웨이 송파역점','서울 송파구 송파대로 374 1층 101호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (200,223,2,'02-595-1718','써브웨이 서초법원점','서울 서초구 법원로1길 1 서호빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (201,411,2,'02-918-7432','써브웨이 길음뉴타운점','서울 성북구 길음로7길 6 1층 14호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (202,925,2,'02-557-8805','써브웨이 언주역점','서울 강남구 봉은사로 206 대명빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (203,907,2,'02-2013-5678','써브웨이 증미역점','서울 강서구 양천로 570 NH서울타워 111호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (204,234,2,'02-2637-3002','써브웨이 문래점','서울 영등포구 선유로 70 우리벤처타운2');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (205,134,2,'02-706-5007','써브웨이 남영역점','서울 용산구 한강대로 271');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (206,202,2,'02-2275-9890','써브웨이 을지로3가점','서울 중구 을지로 103-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (207,321,2,'02-2275-9890','써브웨이 을지로3가점','서울 중구 을지로 103-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (208,605,2,'0507-1307-4650','써브웨이 구산역점','서울 은평구 서오릉로 150 써브웨이 구산역점');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (209,317,2,'02-730-8255','써브웨이 독립문점','서울 종로구 송월길 155 경희궁자이4단지 상가 1층 4104-4106호');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (210,926,2,'0507-1304-9389','써브웨이 선정릉역점','서울 강남구 봉은사로 328 써브웨이 선정릉역점');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (211,414,2,'02-741-0677','써브웨이 성대점','서울 종로구 창경궁로 234 동화빌딩');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (212,324,2,'0507-1302-9891','써브웨이 약수역점','서울 중구 다산로 153');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (213,623,2,'0507-1302-9891','써브웨이 약수역점','서울 중구 다산로 153');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (214,338,2,'0507-1481-7975','써브웨이 대청점','서울 강남구 일원로3길 4');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (215,715,2,'02-456-9665','써브웨이 중곡역점','서울 광진구 능동로 400');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (216,739,2,'0507-1449-2116','써브웨이 광명사거리역점','경기 광명시 광명로 892-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (217,2005,2,'02-2652-2521','써브웨이 양천구청점','서울 양천구 목동서로 349 센트럴프라자');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (218,126,2,'02-928-0258','써브웨이 신설동역점','서울 동대문구 왕산로 15-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (219,2003,2,'02-928-0258','써브웨이 신설동역점','서울 동대문구 왕산로 15-1');
Insert into SUBWAY (STORE_NO,STATION_NO,ADMIN_NO,TEL,STORE_NAME,ADDRESS) values (220,811,2,'0507-1427-5584','써브웨이 성남남위례역점','경기 성남시 수정구 위례광장로 21-13 120호');

-- STATION 테이블 더미데이터 INSERT 문
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (100,'소요산',1,'N',6,'0515','2337','0515','2337','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (101,'동두천',1,'N',6,'0552','2424','0552','2415','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (102,'보산',1,'N',12,'0547','2422','0549','2413','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (103,'동두천중앙',1,'N',10,'0545','2419','0547','2410','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (104,'지행',1,'N',10,'0543','2417','0545','2408','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (105,'덕정',1,'N',8,'0538','2412','0540','2403','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (106,'덕계',1,'N',15,'0535','2357','0535','2357','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (107,'양주',1,'N',6,'0529','2404','0531','2355','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (108,'녹양',1,'N',12,'0527','2416','0529','2418','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (109,'가능',1,'N',15,'0525','2414','0527','2416','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (110,'의정부',1,'N',12,'0522','2412','0524','2414','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (111,'회룡',1,'N',12,'0519','2427','0521','2419','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (112,'망월사',1,'N',10,'0517','2424','0519','2416','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (113,'도봉산',1,'Y',14,'0514','2417','0517','2417','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (114,'도봉',1,'N',12,'0516','2419','0519','2419','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (115,'방학',1,'N',6,'0510','2417','0512','2409','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (116,'창동',1,'Y',13,'0507','2415','0509','2407','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (117,'녹천',1,'N',4,'0505','2413','0507','2405','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (118,'월계',1,'N',8,'0503','2410','0505','2402','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (119,'광운대',1,'N',4,'0500','2333','0500','2332','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (120,'석계',1,'Y',6,'0548','2418','0548','2418','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (121,'신이문',1,'N',4,'0545','2415','0545','2416','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (122,'외대앞',1,'N',4,'0544','2414','0544','2414','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (123,'회기',1,'N',4,'0542','2412','0542','2412','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (124,'청량리',1,'N',11,'0511','2442','0511','2343','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (125,'제기동',1,'N',8,'0537','2420','0537','2407','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (126,'신설동',1,'Y',9,'0515','2446','0515','2347','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (127,'동묘앞',1,'Y',8,'0533','2416','0533','2403','A');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (128,'동대문',1,'Y',10,'0519','2449','0519','2351','A');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (129,'종로5가',1,'N',8,'0529','2457','0529','2406','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (130,'종로3가',1,'Y',12,'0527','2455','0527','2404','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (131,'종각',1,'N',14,'0525','2455','0525','2357','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (132,'시청',1,'Y',8,'0528','2458','0528','2400','A');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (133,'서울역',1,'Y',4,'0520','2403','0520','2402','A');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (134,'남영',1,'N',14,'0517','2400','0517','2354','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (135,'용산',1,'N',8,'0514','2358','0514','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (136,'노량진',1,'Y',8,'0511','2354','0511','2348','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (137,'대방',1,'N',6,'0531','2415','0531','2414','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (138,'신길',1,'Y',8,'0533','2416','0533','2415','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (139,'영등포',1,'N',4,'0505','2419','0510','2418','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (140,'신도림',1,'Y',6,'0502','2354','0502','2354','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (141,'구로',1,'N',12,'0500','2352','0500','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (142,'구일',1,'N',7,'0525','2427','0531','2414','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (143,'개봉',1,'N',7,'0523','2425','0529','2412','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (144,'오류동',1,'N',13,'0507','2350','0507','2350','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (145,'온수',1,'Y',10,'0510','2353','0510','2353','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (146,'역곡',1,'N',9,'0512','2355','0512','2355','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (147,'소사',1,'N',8,'0513','2415','0519','2402','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (148,'부천',1,'N',6,'0511','2413','0517','2400','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (149,'중동',1,'N',4,'0508','2411','0514','2358','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (150,'송내',1,'N',10,'0506','2409','0512','2356','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (151,'부개',1,'N',2,'0523','2406','0523','2406','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (152,'부평',1,'N',4,'0502','2404','0508','2351','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (153,'백운',1,'N',7,'0528','2411','0528','2411','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (154,'동암',1,'N',9,'0516','2359','0516','2346','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (155,'간석',1,'N',5,'0533','2416','0533','2416','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (156,'주안',1,'N',5,'0512','2355','0512','2342','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (157,'도화',1,'N',4,'0537','2420','0537','2420','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (158,'제물포',1,'N',5,'0508','2351','0508','2338','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (159,'도원',1,'N',7,'0506','2349','0506','2336','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (160,'동인천',1,'N',6,'0543','2426','0543','2426','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (161,'인천',1,'N',8,'0500','2343','0500','2330','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (200,'시청',2,'Y',6,'0532','2451','0532','2351','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (201,'을지로입구',2,'N',10,'0530','2444','0530','2345','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (202,'을지로3가',2,'Y',4,'0544','2459','0544','2358','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (203,'을지로4가',2,'Y',7,'0533','2447','0533','2348','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (204,'동대문역사문화공원',2,'Y',6,'0535','2450','0535','2350','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (205,'신당',2,'Y',8,'0537','2452','0537','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (206,'상왕십리',2,'N',4,'0539','2453','0538','2353','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (207,'왕십리',2,'Y',8,'0535','2450','0535','2348','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (208,'한양대',2,'N',6,'0533','2449','0533','2345','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (209,'뚝섬',2,'N',12,'0531','2447','0531','2343','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (210,'성수',2,'N',4,'0530','2444','0530','2342','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (211,'건대입구',2,'Y',4,'0532','2446','0532','2344','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (212,'구의',2,'N',8,'0534','2448','0534','2347','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (213,'강변',2,'N',1,'0536','2450','0536','2349','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (214,'잠실나루',2,'N',8,'0538','2452','0538','2351','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (215,'잠실',2,'Y',7,'0540','2454','0540','2354','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (216,'잠실새내',2,'N',6,'0542','2456','0542','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (217,'종합운동장',2,'Y',8,'0532','2446','0532','2346','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (218,'삼성',2,'N',4,'0530','2444','0530','2344','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (219,'선릉',2,'N',7,'0548','2458','0547','2358','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (220,'역삼',2,'N',4,'0546','2456','0545','2356','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (221,'강남',2,'N',4,'0536','2446','0535','2345','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (222,'교대',2,'Y',2,'0542','2452','0542','2353','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (223,'서초',2,'N',4,'0540','2450','0540','2351','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (224,'방배',2,'N',8,'0538','2448','0537','2349','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (225,'사당',2,'Y',8,'0546','2456','0544','2355','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (226,'낙성대',2,'N',6,'0532','2442','0532','2343','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (227,'서울대입구',2,'N',10,'0530','2440','0530','2341','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (228,'봉천',2,'N',7,'0531','2449','0531','2349','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (229,'신림',2,'N',7,'0533','2451','0533','2351','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (230,'신대방',2,'N',4,'0537','2454','0536','2354','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (231,'구로디지털단지',2,'N',10,'0535','2452','0534','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (232,'대림',2,'Y',14,'0533','2450','0532','2350','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (233,'신도림',2,'Y',8,'0530','2447','0530','2347','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (234,'문래',2,'N',10,'0538','2458','0538','2358','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (235,'영등포구청',2,'Y',7,'0537','2457','0537','2357','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (236,'당산',2,'Y',15,'0535','2455','0535','2355','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (237,'합정',2,'Y',10,'0532','2452','0532','2353','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (238,'홍대입구',2,'N',14,'0530','2450','0530','2351','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (239,'신촌',2,'N',6,'0532','2451','0532','2351','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (240,'이대',2,'N',5,'0534','2453','0534','2353','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (241,'아현',2,'N',9,'0535','2454','0535','2354','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (242,'충정로',2,'Y',14,'0537','2456','0537','2356','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (300,'대화',3,'N',4,'0516','2414','0530','2336','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (301,'주엽',3,'N',4,'0530','2438','0545','2358','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (302,'정발산',3,'N',2,'0521','2419','0535','2341','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (303,'마두',3,'N',4,'0525','2434','0541','2353','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (304,'백석',3,'N',4,'0525','2423','0539','2345','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (305,'대곡',3,'N',7,'0529','2427','0543','2349','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (306,'화정',3,'N',9,'0532','2430','0546','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (307,'원당',3,'N',4,'0513','2421','0528','2341','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (308,'원흥',3,'N',8,'0538','2436','0552','2358','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (309,'삼송',3,'N',5,'0507','2416','0523','2335','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (310,'지축',3,'N',8,'0559','2413','0559','2332','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (311,'구파발',3,'N',8,'0556','2409','0556','2329','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (312,'연신내',3,'Y',2,'0553','2455','0553','2405','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (313,'불광',3,'Y',4,'0551','2453','0551','2400','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (314,'녹번',3,'N',6,'0536','2441','0536','2341','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (315,'홍제',3,'N',4,'0539','2443','0539','2343','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (316,'무악재',3,'N',4,'0541','2445','0541','2345','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (317,'독립문',3,'N',10,'0530','2447','0530','2347','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (318,'경복궁',3,'N',4,'0540','2458','0540','2401','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (319,'안국',3,'N',8,'0534','2452','0534','2352','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (320,'종로3가',3,'Y',9,'0536','2454','0536','2354','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (321,'을지로3가',3,'Y',3,'0538','2455','0538','2355','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (322,'충무로',3,'Y',5,'0539','2457','0539','2357','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (323,'동대입구',3,'N',4,'0541','2459','0541','2359','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (324,'약수',3,'Y',4,'0543','2437','0543','2341','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (325,'금호',3,'N',8,'0546','2445','0547','2349','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (326,'옥수',3,'N',8,'0546','2440','0546','2344','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (327,'압구정',3,'N',8,'0542','2441','0543','2345','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (328,'신사',3,'N',5,'0539','2457','0540','2358','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (329,'잠원',3,'N',4,'0537','2455','0538','2356','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (330,'고속터미널',3,'Y',10,'0536','2449','0536','2353','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (331,'교대',3,'Y',4,'0533','2451','0534','2351','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (332,'남부터미널',3,'N',3,'0541','2454','0541','2358','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (333,'양재',3,'N',4,'0543','2456','0543','2400','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (334,'매봉',3,'N',4,'0526','2444','0527','2344','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (335,'도곡',3,'N',5,'0548','2451','0548','2355','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (336,'대치',3,'N',4,'0530','2440','0533','2341','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (337,'학여울',3,'N',4,'0551','2454','0551','2358','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (338,'대청',3,'N',4,'0553','2456','0553','2400','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (339,'일원',3,'N',1,'0524','2435','0527','2335','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (340,'수서',3,'N',5,'0557','2443','0557','2355','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (341,'가락시장',3,'Y',4,'0534','2430','0531','2330','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (342,'경찰병원',3,'N',4,'0532','2428','0529','2329','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (343,'오금',3,'Y',9,'0531','2427','0528','2327','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (400,'진접',4,'N',3,'0524','2425','0532','2334','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (401,'오남',4,'N',8,'0527','2428','0535','2337','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (402,'별내별가람',4,'N',2,'0537','2448','0536','2350','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (403,'당고개',4,'N',4,'0530','2423','0530','2324','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (404,'상계',4,'N',6,'0607','2502','0608','2357','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (405,'노원',4,'Y',4,'0605','2500','0606','2355','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (406,'창동',4,'Y',6,'0532','2430','0532','2331','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (407,'쌍문',4,'N',4,'0534','2433','0534','2333','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (408,'수유',4,'N',4,'0537','2435','0537','2336','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (409,'미아',4,'N',3,'0539','2437','0539','2338','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (410,'미아사거리',4,'N',3,'0553','2449','0554','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (411,'길음',4,'N',4,'0551','2446','0552','2349','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (412,'성신여대입구',4,'N',8,'0548','2444','0549','2347','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (413,'한성대입구',4,'N',4,'0546','2442','0547','2345','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (414,'혜화',4,'N',6,'0544','2459','0545','2359','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (415,'동대문',4,'Y',5,'0539','2451','0541','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (416,'동대문역사문화공원',4,'Y',4,'0541','2453','0543','2353','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (417,'충무로',4,'Y',8,'0544','2455','0545','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (418,'명동',4,'N',8,'0545','2457','0547','2357','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (419,'회현',4,'N',7,'0535','2449','0536','2349','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (420,'서울역',4,'Y',5,'0533','2447','0534','2347','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (421,'숙대입구',4,'N',1,'0551','2448','0552','2346','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (422,'삼각지',4,'Y',2,'0553','2450','0554','2348','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (423,'신용산',4,'N',6,'0543','2442','0543','2342','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (424,'이촌',4,'N',8,'0541','2439','0541','2339','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (425,'동작',4,'Y',10,'0537','2436','0537','2336','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (426,'총신대입구',4,'N',6,'0534','2433','0534','2333','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (427,'사당',4,'Y',6,'0532','2431','0532','2331','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (428,'남태령',4,'N',4,'0552','2411','0552','2403','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (429,'선바위',4,'N',8,'0538','2425','0551','2355','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (430,'경마공원',4,'N',7,'0536','2423','0549','2353','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (431,'대공원',4,'N',4,'0559','2418','0559','2410','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (432,'과천',4,'N',8,'0601','2420','0601','2412','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (433,'정부과천청사',4,'N',3,'0603','2422','0603','2414','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (434,'인덕원',4,'N',4,'0606','2425','0607','2417','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (435,'평촌',4,'N',3,'0609','2428','0609','2420','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (436,'범계',4,'N',4,'0611','2430','0611','2422','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (437,'금정',4,'Y',8,'0543','2409','0540','2425','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (438,'산본',4,'N',6,'0547','2414','0544','2408','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (439,'수리산',4,'N',6,'0529','2432','0541','2354','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (440,'대야미',4,'N',4,'0553','2419','0550','2413','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (441,'반월',4,'N',14,'0555','2422','0552','2416','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (442,'상록수',4,'N',4,'0559','2425','0556','2419','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (443,'한대앞',4,'N',10,'0601','2427','0558','2421','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (444,'중앙',4,'N',10,'0603','2430','0600','2424','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (445,'고잔',4,'N',6,'0605','2432','0602','2426','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (446,'초지',4,'N',4,'0510','2414','0523','2336','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (447,'안산',4,'N',8,'0530','2422','0608','2355','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (448,'신길온천',4,'N',14,'0519','2408','0536','2330','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (449,'정왕',4,'N',4,'0536','2428','0614','2401','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (450,'오이도',4,'N',4,'0513','2402','0530','2324','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (500,'방화',5,'N',5,'0530','2437','0530','2333','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (501,'개화산',5,'N',6,'0532','2439','0532','2335','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (502,'김포공항',5,'Y',6,'0557','2455','0557','2406','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (503,'송정',5,'N',8,'0536','2443','0536','2339','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (504,'마곡',5,'N',6,'0552','2451','0552','2402','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (505,'발산',5,'N',12,'0550','2449','0550','2400','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (506,'우장산',5,'N',6,'0548','2447','0548','2358','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (507,'화곡',5,'N',7,'0530','2428','0530','2335','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (508,'까치산',5,'Y',4,'0532','2430','0532','2337','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (509,'신정',5,'N',10,'0542','2440','0542','2403','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (510,'목동',5,'N',4,'0540','2439','0540','2401','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (511,'오목교',5,'N',8,'0537','2436','0537','2343','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (512,'양평',5,'N',4,'0539','2438','0539','2344','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (513,'영등포구청',5,'Y',5,'0535','2434','0535','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (514,'영등포시장',5,'N',5,'0542','2441','0542','2347','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (515,'신길',5,'Y',8,'0544','2443','0544','2349','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (516,'여의도',5,'Y',4,'0546','2445','0546','2351','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (517,'여의나루',5,'N',4,'0548','2447','0548','2353','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (518,'마포',5,'N',4,'0540','2444','0540','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (519,'공덕',5,'Y',4,'0552','2451','0552','2357','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (520,'애오개',5,'N',3,'0540','2433','0540','2347','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (521,'충정로',5,'Y',4,'0547','2459','0547','2402','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (522,'서대문',5,'N',7,'0545','2457','0545','2400','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (523,'광화문',5,'N',4,'0545','2438','0545','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (524,'종로3가',5,'Y',4,'0541','2453','0541','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (525,'을지로4가',5,'Y',12,'0549','2442','0549','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (526,'동대문역사문화공원',5,'Y',8,'0551','2444','0551','2358','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (527,'청구',5,'Y',7,'0553','2446','0553','2400','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (528,'신금호',5,'N',5,'0555','2448','0555','2402','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (529,'행당',5,'N',1,'0557','2450','0557','2404','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (530,'왕십리',5,'Y',2,'0544','2451','0544','2357','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (531,'마장',5,'N',6,'0545','2453','0545','2359','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (532,'답십리',5,'N',8,'0547','2455','0547','2401','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (533,'장한평',5,'N',10,'0534','2454','0534','2352','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (534,'군자',5,'Y',6,'0532','2451','0532','2350','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (535,'아차산',5,'N',6,'0538','2443','0538','2359','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (536,'광나루',5,'N',4,'0536','2447','0536','2358','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (537,'천호',5,'Y',8,'0533','2444','0533','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (538,'강동',5,'N',7,'0532','2442','0532','2354','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (539,'길동',5,'N',4,'0547','2452','0547','2408','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (540,'굽은다리',5,'N',8,'0549','2454','0549','2410','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (541,'명일',5,'N',3,'0550','2455','0550','2411','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (542,'고덕',5,'N',4,'0553','2457','0553','2413','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (543,'상일동',5,'N',3,'0555','2436','0555','2350','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (544,'강일',5,'N',4,'0557','2438','0557','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (545,'미사',5,'N',8,'0559','2440','0559','2355','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (546,'하남풍산',5,'N',6,'0602','2443','0602','2358','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (547,'하남시청',5,'N',6,'0605','2446','0605','2400','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (548,'하남검단산',5,'N',4,'0530','2418','0532','2340','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (600,'응암',6,'N',14,'0537','2440','0537','2354','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (601,'역촌',6,'N',4,'0539','2442','0539','2355','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (602,'불광',6,'Y',10,'0541','2444','0541','2357','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (603,'독바위',6,'N',10,'0532','2446','0532','2347','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (604,'연신내',6,'Y',6,'0534','2449','0534','2350','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (605,'구산',6,'N',4,'0536','2450','0536','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (606,'새절',6,'N',8,'0546','2438','0546','2402','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (607,'증산',6,'N',14,'0531','2441','0531','2346','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (608,'디지털미디어시티',6,'N',4,'0534','2443','0534','2348','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (609,'월드컵경기장',6,'N',4,'0540','2449','0540','2357','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (610,'마포구청',6,'N',5,'0537','2447','0537','2351','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (611,'망원',6,'N',6,'0537','2445','0537','2353','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (612,'합정',6,'Y',6,'0541','2451','0541','2355','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (613,'상수',6,'N',8,'0533','2442','0533','2350','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (614,'광흥창',6,'N',6,'0544','2455','0544','2358','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (615,'대흥',6,'N',12,'0546','2458','0546','2400','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (616,'공덕',6,'Y',6,'0537','2436','0537','2355','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (617,'효창공원앞',6,'N',7,'0543','2453','0543','2404','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (618,'삼각지',6,'Y',4,'0541','2451','0541','2402','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (619,'녹사평',6,'N',10,'0539','2446','0539','2357','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (620,'이태원',6,'N',4,'0541','2448','0541','2359','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (621,'한강진',6,'N',8,'0530','2432','0530','2349','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (622,'버티고개',6,'N',4,'0541','2458','0541','2406','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (623,'약수',6,'Y',5,'0540','2456','0540','2404','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (624,'청구',6,'Y',5,'0538','2454','0538','2402','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (625,'신당',6,'Y',8,'0537','2439','0537','2357','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (626,'동묘앞',6,'Y',4,'0535','2451','0535','2359','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (627,'창신',6,'N',4,'0533','2449','0533','2357','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (628,'보문',6,'N',4,'0531','2448','0531','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (629,'안암',6,'N',4,'0530','2445','0530','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (630,'고려대',6,'N',3,'0535','2459','0535','2403','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (631,'월곡',6,'N',4,'0533','2449','0533','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (632,'상월곡',6,'N',7,'0532','2456','0532','2400','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (633,'돌곶이',6,'N',4,'0537','2452','0537','2359','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (634,'석계',6,'Y',4,'0535','2452','0535','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (635,'태릉입구',6,'Y',12,'0533','2450','0533','2354','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (636,'화랑대',6,'N',15,'0531','2448','0531','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (637,'봉화산',6,'N',12,'0544','2440','0544','2346','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (638,'신내',6,'N',12,'0539','2442','0543','2346','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (700,'장암',7,'N',10,'0535','2422','0535','2335','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (701,'도봉산',7,'Y',14,'0544','2426','0544','2353','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (702,'수락산',7,'N',12,'0532','2429','0532','2343','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (703,'마들',7,'N',6,'0535','2432','0535','2345','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (704,'노원',7,'Y',13,'0537','2448','0537','2405','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (705,'중계',7,'N',4,'0539','2436','0539','2349','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (706,'하계',7,'N',8,'0540','2437','0540','2351','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (707,'공릉',7,'N',4,'0531','2443','0531','2359','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (708,'태릉입구',7,'Y',6,'0532','2441','0532','2354','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (709,'먹골',7,'N',4,'0533','2443','0533','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (710,'중화',7,'N',4,'0544','2456','0544','2404','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (711,'상봉',7,'N',4,'0542','2453','0542','2402','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (712,'면목',7,'N',11,'0539','2448','0539','2402','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (713,'사가정',7,'N',8,'0539','2450','0539','2359','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (714,'용마산',7,'N',9,'0537','2448','0537','2357','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (715,'중곡',7,'N',8,'0544','2453','0544','2407','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (716,'군자',7,'Y',10,'0546','2455','0546','2409','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (717,'어린이대공원',7,'N',8,'0548','2457','0548','2411','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (718,'건대입구',7,'Y',12,'0538','2441','0538','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (719,'뚝섬유원지',7,'N',14,'0539','2443','0539','2358','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (720,'청담',7,'N',8,'0539','2451','0539','2356','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (721,'강남구청',7,'N',4,'0533','2432','0533','2350','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (722,'학동',7,'N',14,'0546','2447','0547','2402','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (723,'논현',7,'N',8,'0536','2436','0536','2353','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (724,'반포',7,'N',8,'0538','2437','0538','2355','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (725,'고속터미널',7,'Y',7,'0541','2442','0541','2357','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (726,'내방',7,'N',4,'0538','2438','0538','2353','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (727,'이수',7,'N',8,'0549','2456','0549','2402','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (728,'남성',7,'N',3,'0547','2454','0547','2400','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (729,'숭실대입구',7,'N',4,'0537','2449','0537','2355','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (730,'상도',7,'N',3,'0538','2451','0538','2356','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (731,'장승배기',7,'N',4,'0540','2447','0540','2354','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (732,'신대방삼거리',7,'N',8,'0543','2455','0543','2401','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (733,'보라매',7,'N',6,'0536','2443','0536','2350','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (734,'신풍',7,'N',6,'0530','2444','0530','2353','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (735,'대림',7,'Y',4,'0543','2439','0543','2345','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (736,'남구로',7,'N',14,'0541','2437','0541','2343','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (737,'가산디지털단지',7,'Y',4,'0536','2450','0536','2400','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (738,'철산',7,'N',10,'0537','2433','0537','2339','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (739,'광명사거리',7,'N',10,'0541','2455','0541','2404','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (740,'천왕',7,'N',6,'0543','2457','0543','2407','A');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (741,'온수',7,'Y',4,'0530','2440','0530','2347','A');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (742,'까치울',7,'N',8,'0533','2443','0533','2350','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (743,'부천종합운동장',7,'N',14,'0546','2448','0546','2403','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (744,'춘의',7,'N',4,'0544','2446','0544','2401','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (745,'신중동',7,'N',4,'0542','2444','0542','2359','A');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (746,'부천시청',7,'N',5,'0541','2443','0540','2357','A');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (747,'상동',7,'N',6,'0542','2452','0542','2359','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (748,'삼산체육관',7,'N',6,'0537','2439','0537','2354','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (749,'굴포천',7,'N',8,'0545','2456','0545','2402','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (750,'부평구청',7,'N',6,'0534','2436','0533','2350','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (751,'산곡',7,'N',12,'0550','2500','0550','2407','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (752,'석남',7,'N',6,'0528','2430','0528','2344','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (800,'암사',8,'N',7,'0530','2448','0530','2350','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (801,'천호',8,'Y',4,'0532','2450','0532','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (802,'강동구청',8,'N',10,'0534','2457','0534','2401','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (803,'몽촌토성',8,'N',4,'0536','2454','0536','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (804,'잠실',8,'Y',8,'0538','2456','0538','2358','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (805,'석촌',8,'Y',4,'0540','2458','0540','2400','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (806,'송파',8,'N',5,'0542','2500','0542','2402','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (807,'가락시장',8,'Y',5,'0537','2454','0537','2402','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (808,'문정',8,'N',8,'0527','2445','0527','2350','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (809,'장지',8,'N',4,'0529','2447','0529','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (810,'복정',8,'N',4,'0544','2449','0544','2357','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (811,'남위례',8,'N',4,'0541','2446','0541','2354','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (812,'산성',8,'N',4,'0539','2444','0539','2352','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (813,'남한산성입구',8,'N',3,'0538','2456','0538','2401','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (814,'단대오거리',8,'N',4,'0539','2458','0539','2403','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (815,'신흥',8,'N',7,'0541','2459','0541','2404','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (816,'수진',8,'N',4,'0531','2436','0531','2344','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (817,'모란',8,'N',4,'0530','2435','0530','2343','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (900,'개화',9,'N',12,'0530','2443','0530','2343','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (901,'김포공항',9,'Y',2,'0541','2459','0540','2407','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (902,'공항시장',9,'N',4,'0537','2450','0537','2350','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (903,'신방화',9,'N',8,'0538','2452','0538','2351','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (904,'마곡나루',9,'N',8,'0535','2452','0535','2401','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (905,'양천향교',9,'N',6,'0533','2457','0532','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (906,'가양',9,'N',10,'0537','2446','0537','2344','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (907,'증미',9,'N',7,'0540','2448','0539','2346','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (908,'등촌',9,'N',7,'0542','2450','0541','2348','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (909,'염창',9,'N',4,'0536','2450','0536','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (910,'신목동',9,'N',10,'0532','2454','0531','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (911,'선유도',9,'N',14,'0532','2456','0532','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (912,'당산',9,'Y',8,'0530','2445','0530','2342','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (913,'국회의사당',9,'N',10,'0542','2452','0542','2351','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (914,'여의도',9,'Y',7,'0540','2450','0540','2350','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (915,'샛강',9,'N',15,'0532','2452','0531','2348','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (916,'노량진',9,'Y',10,'0534','2454','0534','2351','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (917,'노들',9,'N',14,'0534','2453','0534','2354','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (918,'흑석',9,'N',6,'0532','2451','0532','2352','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (919,'동작',9,'Y',5,'0530','2448','0530','2344','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (920,'구반포',9,'N',9,'0538','2457','0537','2358','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (921,'신반포',9,'N',14,'0536','2455','0536','2357','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (922,'고속터미널',9,'Y',4,'0536','2454','0535','2350','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (923,'사평',9,'N',4,'0532','2451','0532','2353','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (924,'신논현',9,'N',2,'0530','2445','0530','2341','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (925,'언주',9,'N',8,'0531','2447','0531','2343','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (926,'선정릉',9,'N',10,'0539','2457','0539','2400','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (927,'삼성중앙',9,'N',6,'0537','2455','0537','2358','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (928,'봉은사',9,'N',6,'0535','2453','0535','2356','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (929,'종합운동장',9,'Y',4,'0540','2456','0540','2351','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (930,'삼전',9,'N',8,'0530','2448','0530','2351','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (931,'석촌고분',9,'N',7,'0531','2449','0531','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (932,'석촌',9,'Y',4,'0533','2451','0533','2358','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (933,'송파나루',9,'N',8,'0535','2453','0535','2400','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (934,'한성백제',9,'N',3,'0537','2452','0538','2357','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (935,'올림픽공원',9,'Y',4,'0535','2449','0535','2355','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (936,'둔촌오륜',9,'N',3,'0542','2459','0542','2407','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (937,'중앙보훈병원',9,'N',4,'0530','2444','0530','2350','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (2000,'용답',2,'N',8,'0536','2457','0536','2357','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (2001,'신답',2,'N',6,'0535','2456','0533','2356','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (2002,'용두',2,'N',6,'0532','2453','0532','2353','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (2003,'신설동',2,'Y',4,'0530','2451','0530','2351','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (2004,'도림천',2,'N',14,'0532','2453','0532','2349','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (2005,'양천구청',2,'N',4,'0536','2459','0536','2353','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (2006,'신정네거리',2,'N',10,'0533','2456','0533','2350','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (2007,'까치산',2,'Y',10,'0530','2453','0530','2347','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1000,'가산디지털단지',1,'Y',6,'0507','2343','0507','2345','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1001,'독산',1,'N',4,'0509','2345','0509','2347','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1002,'금천구청',1,'N',8,'0630','2337','0630','2337','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1003,'광명',1,'N',14,'0539','2417','0539','2417','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1004,'석수',1,'N',4,'0515','2351','0515','2353','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1005,'관악',1,'N',4,'0518','2354','0518','2356','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1006,'안양',1,'N',5,'0521','2357','0521','2359','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1007,'명학',1,'N',6,'0528','2406','0528','2406','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1008,'금정',1,'Y',6,'0525','2403','0525','2403','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1009,'군포',1,'N',8,'0523','2401','0523','2401','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1010,'당정',1,'N',6,'0520','2358','0520','2358','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1011,'의왕',1,'N',12,'0517','2355','0517','2355','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1012,'성균관대',1,'N',6,'0514','2352','0514','2352','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1013,'화서',1,'N',7,'0540','2417','0541','2419','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1014,'수원',1,'N',4,'0507','2345','0507','2345','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1015,'세류',1,'N',10,'0500','2425','0500','2416','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1016,'병점',1,'N',4,'0537','2335','0534','2335','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1017,'서동탄',1,'N',8,'0548','2427','0548','2417','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1018,'세마',1,'N',4,'0506','2336','0506','2336','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1019,'오산대',1,'N',5,'0541','2420','0541','2410','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1020,'오산',1,'N',5,'0513','2343','0513','2344','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1021,'진위',1,'N',8,'0517','2347','0517','2347','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1022,'송탄',1,'N',4,'0520','2350','0520','2350','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1023,'서정리',1,'N',4,'0526','2406','0526','2356','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1024,'평택지제',1,'N',4,'0522','2401','0522','2351','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1025,'평택',1,'N',4,'0536','2406','0536','2406','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1026,'성환',1,'N',3,'0540','2410','0540','2411','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1027,'직산',1,'N',4,'0545','2415','0545','2416','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1028,'두정',1,'N',7,'0525','2354','0550','2329','A');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1029,'천안',1,'N',4,'0527','2356','0552','2331','A');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1030,'봉명',1,'N',4,'0529','2359','0555','2334','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1031,'쌍용',1,'N',12,'0516','2401','0516','2401','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1032,'아산',1,'N',8,'0535','2404','0600','2339','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1033,'탕정',1,'N',7,'0509','2354','0509','2354','A');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1034,'배방',1,'N',5,'0543','2412','0608','2347','A');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1035,'온양온천',1,'N',1,'0500','2345','0500','2345','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (1036,'신창',1,'N',2,'0543','2412','0608','2347','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (5000,'둔촌동',5,'N',6,'0532','2436','0532','2351','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (5001,'올림픽공원',5,'Y',8,'0540','2438','0542','2349','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (5002,'방이',5,'N',10,'0536','2440','0536','2355','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (5003,'오금',5,'Y',6,'0538','2442','0538','2357','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (5004,'개롱',5,'N',6,'0539','2444','0539','2358','I');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (5005,'거여',5,'N',4,'0541','2446','0541','2400','O');
Insert into STATION (STATION_NO,STATION_NAME,LINE_NO,TRANSFER_YN,EXIT_COUNT,WEEK_START_TIME,WEEK_END_TIME,HOL_START_TIME,HOL_END_TIME,TOILET_IO) values (5006,'마천',5,'N',8,'0531','2429','0533','2340','I');


