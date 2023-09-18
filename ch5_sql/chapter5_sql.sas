/* sql.kbl1 */
LIBNAME sql'/home/u47346135/sasuser.v94';

DATA sql.kbl1;
    LENGTH team $ 8 name $ 12;
	INPUT team $ name $ posi $ backn score freeth freetry reb assist foul time@@;
	CARDS;
대우 김훈       F  7 24 1  2  1 4 3 38
대우 우지원     F 10 22 7  8  8 2 2 36
기아 강동희     G  5 14 5  6  2 7 0 32
기아 리드       C 22 27 5  9 19 1 4 35
삼성 문경은     F 14 37 9 11  2 3 2 40
삼성 스트릭랜  C 55 45 5  9 14 1 4 40
나래 정인교     G  5 28 8 10  2 2 2 36
나래 주희정     G 15 11 1  1  2 2 5 38
나산 조던       G  9 23 7  9  2 4 0 34
나산 이민형     F 14 14 2  3  3 3 0 36
동양 그레이     G  9 33 1  3 14 1 2 40
동양 전희철     F 13 16 3  6  8 1 2 32
;
RUN;

/* sql.kbl2 */
DATA sql.kbl2;
    LENGTH  name $ 12;
	INPUT name $ backn suc2p try2p suc3p try3p @@;
	CARDS;
김훈        7 10 11 1  4
우지원     10  6 10 1  4
강동희      5  3  6 1  3
리드       22 11 15 0  1
문경은     14  5 11 6 11
스트릭랜   55 20 31 0  0
정인교      5  4  7 4 12
주희정     15  5 6 0 0
조던        9  5  8 2  8
이민형     14  3  6 2  5
그레이      9  14 18 1 3
전희철     13  2  7 3  6
;
RUN;

/* sql.kbl3 */
DATA sql.kbl3;
    LENGTH team $ 8 name $ 12;
	INPUT team $ name $ posi $ backnum score freeth freetry reb assist foul time;
	CARDS;
대우 데이비스   F 44 21 1  2  7 2 1 35
대우 우지원     F 10 22 3  4  3 2 4 37
기아 허재       G  9 24 4  4  7 2 3 38
기아 김영만     F 11 18 4  4  3 3 2 36
삼성 문경은    F 14 16 9 11  5 4 2 40
삼성 스트릭랜   C 55 27 5  5 12 0 1 34
나래 장윤섭     F 13 18 3  3  6 1 3 27
나래 윌리포드   C 22 22 1  4 16 1 3 38
나산 조던       G  9 28 5 13  3 3 0 40
나산 이민형     F 14 21 1  1  5 0 3 38
동양 그레이     G  9 21 2  4  3 2 4 38
동양 김병철     G 10 23 5  6  8 6 3 40
;
RUN;

/* p. 123 */
PROC SQL;
	SELECT team, SUM(score) AS totscore FROM sql.kbl1 
	WHERE posi='G' 
	GROUP BY team 
	ORDER BY totscore;
RUN;

PROC SUMMARY DATA=sql.kbl1;
	WHERE posi='G';
	CLASS team;
	VAR score;
	OUTPUT OUT=sumscore SUM=totscore;
RUN;
PROC SORT DATA=sumscore;
	BY totscore;
RUN;

PROC PRINT DATA=sumscore NOOBS;
	VAR team totscore;
	WHERE _type_=1;
RUN;

/* ex 5.1 */
PROC SQL;
	SELECT * FROM sql.kbl1;
RUN;

PROC SQL;
	SELECT team, posi 
	FROM sql.kbl1;
RUN;

/* ex 5.2 */
PROC SQL;
	SELECT DISTINCT team, posi FROM sql.kbl1;
RUN;

/* ex 5.3 */
TITLE '자유투 성공률';
PROC SQL;
	SELECT name, freeth, (freeth/freetry)*100 AS percent 
	FROM sql.kbl1;
RUN;

/* ex 5.4 */
TITLE '자유투 성공률이 낮은 선수';
PROC SQL;
	SELECT name, freeth, (freeth/freetry)*100 AS percent, 
	CASE 
	WHEN CALCULATED percent<60 THEN '****' 
	ELSE '  ' 
	END 
	FROM sql.kbl1;
RUN;

/* ex 5.5 */
PROC SQL;
	SELECT name, freeth, (freeth/freetry)*100 AS percent 
	FORMAT=4.1 LABEL='백분율' 
	FROM sql.kbl1;
RUN;

/* ex 5.6 */
TITLE '포지션별 득점 순위';
PROC SQL;
	SELECT name, posi, score FROM sql.kbl1 
	ORDER BY posi, score;
RUN;

/* ex 5.7 */
PROC SQL;
	SELECT AVG(freeth/freetry*100) AS avgper 
	FORMAT=4.1 LABEL='평균 자유투 성공률 ' 
	FROM sql.kbl1;
RUN;
PROC SQL;
	SELECT COUNT(*) LABEL='행의 수' FROM sql.kbl1;
RUN;
PROC SQL;
	SELECT MIN(score) LABEL='최하 득점', MAX(score) LABEL='최고 득점' FROM sql.kbl1;
RUN;
PROC SQL;
	SELECT SUM(score) LABEL='총득점' FROM sql.kbl1;
RUN;

/* ex 5.8 */
PROC SQL;
	TITLE '포지션별 자유투 성공률';
	SELECT posi, AVG(freeth/freetry*100) AS avgper 
	FORMAT=4.1 LABEL='평균 자유투 성공률' 
	FROM sql.kbl1 
	GROUP BY posi;
RUN;	
PROC SQL;
	TITLE '포지션별 선수 수';
	SELECT posi, count(posi) FROM sql.kbl1 
	GROUP BY posi;
RUN;

/* ex 5.9 */
PROC SQL;
	TITLE '자유투 성공률이 높은 팀';
	SELECT team, avg(freeth/freetry*100) AS avgper 
	FORMAT=4.1 LABEL=' 자유투 성공률' 
	FROM sql.kbl1 
	GROUP BY team 
	HAVING avgper>70;
RUN;

PROC SQL;
	TITLE '가드의 자유투 성공률';
	SELECT posi, name, freeth/freetry*100 AS per 
	FORMAT=4.1 LABEL='자유투 성공률' 
	FROM sql.kbl1 
	WHERE posi='G'
	ORDER BY per;
RUN;

PROC SQL;
	TITLE '가드의 평균 자유투 성공률이 높은 팀';
	SELECT team, avg(freeth/freetry*100) AS avgper 
	FORMAT=4.1 LABEL=' 자유투 성공률' 
	FROM sql.kbl1 
	WHERE posi='G' 
	GROUP BY team 
	HAVING avgper>70;
RUN;

/* ex 5.10 */
PROC SQL;
	TITLE '두 경기에 모두 출전한 선수';
	SELECT name FROM sql.kbl1 
	INTERSECT 
	SELECT name FROM sql.kbl3;
RUN;

PROC SQL;
	TITLE '12월 경기에만 출전한 선수';
	SELECT team, name FROM sql.kbl1 
	EXCEPT 
	SELECT team, name FROM sql.kbl3;
RUN;

PROC SQL;
	TITLE '나래팀 출전 선수';
	SELECT team, name FROM sql.kbl1 
	WHERE team='나래' 
	UNION 
	SELECT team, name FROM sql.kbl3 
	WHERE team='나래';
RUN;

/* ex 5.11 */
PROC SQL;
	TITLE '두 경기의 평균 득점';
	SELECT '12월 경기:', avg(score) FORMAT=5.2 LABEL='평균 득점' 
	FROM sql.kbl1 
	UNION 
	SELECT '2월 경기:', avg(score) FORMAT=5.2 LABEL='평균 득점' 
	FROM sql.kbl3;
RUN;

/* ex 5.12 */
PROC SQL;
	CREATE TABLE sql.fthrow AS SELECT posi, avg(freeth/freetry*100) AS avgper 
	FORMAT=4.1 LABEL='자유투 성공률' 
	FROM sql.kbl1 
	GROUP BY posi;
	SELECT * from sql.fthrow;
RUN;

/* ex 5.13 */
PROC SQL;
	CREATE TABLE sql.score AS SELECT team, name, posi, score 
	FROM sql.kbl1 
	WHERE posi='G';
	SELECT * FROM sql.score;
RUN;

PROC SQL;
	INSERT INTO sql.score 
	SELECT team, name, posi, score 
	FROM sql.kbl1 WHERE team IN ('동양');
	SELECT * FROM sql.score;
RUN;

/* ex 5.14 */
PROC SQL;
	INSERT INTO sql.score 
	SET team='나래', name='윌리포드', posi='C', score=31;
	SELECT * FROM sql.score;
RUN;	

/* ex 5.15 */
PROC SQL;
	INSERT INTO sql.score 
	VALUES ('기아', '김유택', 'F', 8) 
	VALUES ('기아', '김영만', 'F', 12);
	SELECT * FROM sql.score;
RUN;

/* ex 5.16 */
PROC SQL;
	CREATE TABLE sql.score AS 
	SELECT team, name, posi, score 
	FROM sql.kbl1 
	WHERE posi='G';
	SELECT * FROM sql.score;
RUN;

PROC SQL;
	UPDATE sql.score 
	SET score=score*1.5;
	SELECT * FROM sql.score;
RUN;

/* ex 5.17 */
PROC SQL;
	CREATE TABLE sql.score AS 
	SELECT team, name, posi, score 
	FROM sql.kbl1 
	WHERE posi='G';
	SELECT * FROM sql.score;
RUN;

PROC SQL;
	UPDATE sql.score SET score=score+5 WHERE team IN ('동양');
	UPDATE sql.score SET score=score-5 WHERE team IN ('나래');
	SELECT * FROM sql.score;
RUN;

/* p. 142 */
PROC SQL;
	CREATE TABLE sql.score AS 
	SELECT team, name, posi, score 
	FROM sql.kbl1 
	WHERE posi='G';
	SELECT * FROM sql.score;
RUN;
PROC SQL;	
	UPDATE sql.score 
	SET score=score+
	CASE WHEN team IN ('동양') THEN 5 
    	WHEN team IN ('나래') THEN -5 
    	ELSE 0 
	END;
	SELECT * FROM sql.score;
RUN;

/* ex 5.18 */
PROC SQL;
	ALTER TABLE sql.kbl1 
	ADD pof num LABEL='자유투 성공률' FORMAT 6.2;
	SELECT team, name, posi, score, pof 
	FROM sql.kbl1 
	WHERE posi='G';
RUN;
PROC SQL;
	UPDATE sql.kbl1 
	SET pof=(freeth/freetry)*100;
	SELECT team, name, posi, score, pof 
	FROM sql.kbl1 
	WHERE posi='G';
RUN;


/* ex 5.19 */
PROC SQL;
	CREATE VIEW sql.view1 AS 
	SELECT team LABEL=' 구단', 
	COUNT(team) AS number LABEL='선수 수', 
	SUM(score) AS tot LABEL='총득점', 
	AVG(score) AS aos FORMAT=5.2 LABEL='평균득점' 
	FROM sql.kbl1 
	GROUP BY team;
	SELECT * FROM sql.view1;
RUN;

/* p. 146 */
PROC SQL;
	DESCRIBE VIEW sql.view1;
RUN;
PROC SQL;
	DESCRIBE TABLE sql.kbl1;
RUN;

/* p. 147 */
PROC MEANS DATA=sql.view1 MAXDEC=2;
	VAR tot aos;
RUN;

/* p. 148 */
PROC SQL;
	CREATE TABLE sql.kbl1 AS 
	SELECT team, name, posi 
	FROM sql.kbl1;
RUN;
PROC MEANS DATA=sql.view1 MAXDEC=2;
	VAR tot aos;
RUN;

/* ex 5.20 */
DATA so2;
	INPUT city $ so2;
	CARDS;
서울    0.013
부산    0.022
;
RUN;

DATA co;
	INPUT city $ co;
	CARDS;
부산    1.2
대구    1.0
인천    1.3
;
RUN;

PROC SQL;
	SELECT * FROM so2, co;
RUN;

/* p. 150 */
PROC SQL;
	SELECT * FROM so2, co 
	WHERE so2.city=co.city;
RUN;

PROC SQL;
	SELECT kbl1.team, kbl1.name, kbl1.posi, kbl2.suc3p,
	kbl1.score AS score1, kbl3.score AS score2 
	FROM sql.kbl1, sql.kbl2, sql.kbl3
	WHERE kbl1.name=kbl2.name=kbl3.name
	AND kbl3.posi='G';
RUN;


/* ex 5.21 */
PROC SQL;
	SELECT k1.name, k1.posi, k1.reb as reb1, k3.reb as reb2 FROM sql.kbl1 AS k1 
	LEFT JOIN sql.kbl3 as k3 ON k1.name=k3.name;
RUN;	
	

PROC SQL;
	SELECT k1.name, k1.posi, k1.reb as reb1, k3.reb as reb2 FROM sql.kbl1 AS k1 
	LEFT JOIN sql.kbl3 as k3 ON k1.name=k3.name AND k3.posi='G';
RUN;	

/* ex 5.22 */
PROC SQL;
	SELECT k1.name, k1.posi, k1.reb as reb1, k3.reb as reb2 FROM sql.kbl1 AS k1 
	RIGHT JOIN sql.kbl3 as k3 ON k1.name=k3.name;
RUN;

/* ex 5.23 */
PROC SQL;
	SELECT k1.name, k1.posi, k1.reb AS reb1, k3.reb AS reb2 FROM sql.kbl1 AS k1 
	FULL JOIN sql.kbl3 AS k3 ON k1.name=k3.name;
RUN;

/* ex 5.24 */
PROC SQL;
	SELECT k1.posi, k1.name, COALESCE(k3.score, k1.score) LABEL='최근 득점' 
	FROM sql.kbl1 AS k1 
	LEFT JOIN sql.kbl3 AS k3 ON k1.name=k3.name;
QUIT;