/* 예 1.1 */
DATA one;
INFILE CARDS DLM='&$*,';
INPUT a b c;
CARDS;
11&$12,13
2$$$22* 23
  3*  32,33
;
RUN;

/* 예 1.2 */
DATA scores;
INFILE CARDS DLM=',';
INPUT test1 test2 test3;
CARDS;
91,87,95
97,,92
1,1,1
;
RUN;

DATA scores1;
INFILE CARDS DSD;
INPUT test1 test2 test3;
CARDS;
91,87,95
97,,92
1,1,1
;
RUN;

DATA topics;
INFILE CARDS DSD;
INPUT speaker : $15. title : $40. location & $10.;
CARDS;
Whitfield,"Looking at Water, Looking at Life",Blue Room
Fuentes,"Life After the Revolution",Red Room
Townsend,"Peace in Our Times",Green Room
;
RUN;

/* 예 1.3 */
DATA one;
INFILE '/home/u47346135/sasuser.v94/ex1-03.txt' EXPANDTABS;
INPUT a b c;
RUN;

/* 예 1.4 */

DATA one;
INFILE CARDS; 
INPUT a b c;
CARDS;
1 2 3
4 5
6 7 8
9 0 1 2
3 4 5
;
RUN;

DATA one;
INFILE CARDS MISSOVER;
INPUT a b c;
CARDS;
1 2 3
4 5
6 7 8
9 0 1 2
3 4 5
;
RUN;

DATA one;
INFILE CARDS STOPOVER;
INPUT a b c;
CARDS;
1 2 3
4 5
6 7 8
9 0 1 2
3 4 5
;
RUN;


/* 예 1.5 */

DATA one;
INFILE '/home/u47346135/sasuser.v94/ex1-05.txt'; 
INPUT a 5.;
RUN;

DATA one;
INFILE '/home/u47346135/sasuser.v94/ex1-05.txt' MISSOVER;
INPUT a 5.;
RUN;

DATA one;
INFILE '/home/u47346135/sasuser.v94/ex1-05.txt' TRUNCOVER ;
INPUT a 5.;
RUN;

/* 예 1.6 */

DATA one;
INFILE '/home/u47346135/sasuser.v94/ex1-06.txt'; 
INPUT (id name class type) ($5.);
RUN;

DATA one;
INFILE '/home/u47346135/sasuser.v94/ex1-06.txt' LRECL=20 PAD ;
INPUT (id name class type) ($5.);
RUN;

DATA one;
INFILE '/home/u47346135/sasuser.v94/ex1-06.txt'LRECL=20 LINESIZE=10;
INPUT (id name class type) ($5.);
RUN;


/* 예 1.7 */

DATA one;
LENGTH name $8 class $7;
INPUT name $ class $;
CARDS;
H.C.KANG    CHEM101
Y.C.JUNG    ENGL201
S.H.JUN     MATH102
H.C.KANG    MATH102
K.J.AHAN    CHEM101
S.H.JUN     ENGE201
K.J.AHAN    CHEM101
S.H.JUN     CHEM101
Y.C.JUNG    ENGL201
H.C.KANG    MATH102
;
RUN;

PROC SORT DATA=one;
BY name;
RUN;

DATA two;
RETAIN oldname;
SET one;
IF name=oldname THEN DELETE;
oldname=name;
DROP oldname;
RUN;


/* 예 1.8 */

DATA one;
RETAIN y 0;
INPUT x @@;
y=0.2*x+0.8*y;
CARDS;
1 2 3 4 5
;
RUN;


/* 예 1.9 */

DATA one;
INPUT x1 x2 x3;
RETAIN k 0;
IF NMISS(OF x1-x3)>0 THEN k=k+1;
CARDS;
1 2 3
4 5 .
. 7 .
. 8 9
1 2 3
;
RUN;

DATA one;
INPUT x1 x2 x3;
IF NMISS(OF x1-x3)>0 THEN k+1;
CARDS;
1 2 3
4 5 .
. 7 .
. 8 9
1 2 3
;
RUN;


/* 예 1.10 */

DATA one;
INPUT a1-a5;
CARDS;
11  12  13  14  15
21   .  23  24  25
31  32  33  34  35
41  42  43  44  45
51  52  53   .  55
;
RUN;

DATA two;
SET one;
ARRAY k[*] a1-a5;
DO i=1 TO 5;
IF k[i]=. THEN DELETE;
END;
DROP i;
RUN;


/* 예 1.11 */

DATA one;
INPUT a1b1-a1b5 a2b1-a2b5;
CARDS;
11   12   13   14   15   21    22    23    24    25
31   32   33   34   35   41    42    43    44    45
;
RUN;

DATA two;
FORMAT c1-c5 5.3;
ARRAY k1[2,5] a1b1-a1b5 a2b1-a2b5;
ARRAY k2[5] c1-c5;
SET one;
DO j=1 TO DIM2(k1);
   k2[j]=k1[1,j]/k1[2,j];
END;
dim1_k1=DIM1(k1); dim2_k1=DIM2(k1); dim_k2=DIM(k2);
DROP j;
RUN;


/* 예 1.12 */

DATA one;
ARRAY names[*] $ n1-n9;
ARRAY caps[*] $ c1-c9;
INPUT names[*];
DO i=1 TO 9;
   caps[i]=UPCASE(names[i]);
END;
DROP i;
CARDS;
smithers michaels gonzalez hurth frank bleigh rounder joseph peters
;
RUN;


/* 예 1.13 */

DATA one(DROP=i);
ARRAY test[3] _TEMPORARY_ (90 80 70);
ARRAY score[3] s1-s3;
INPUT id score[*];
DO i=1 to 3;
IF score[i]>=test[i] THEN
DO; newscore=score[i]; output;
END;
END;
CARDS;
1234 99 60 82
5678 80 85 75
;
RUN;
