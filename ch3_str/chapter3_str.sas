/* ex 3.1 */

DATA score;
    LENGTH name $ 9 grade $ 6;
    INPUT name $ score;
    IF 1<=score<=3 THEN grade='LOW';
        ELSE IF 4<=score<=7 THEN grade='MIDDLE';
        ELSE IF 8<=score<=10 THEN grade='HIGH';
CARDS;
HyunCheol 7
YongChan 10
MinHee 3
;
RUN;

PROC PRINT DATA=score;
RUN;


/* ex 3.2 */

DATA one_1;
   LENGTH lastname $15 name1 $8;
   INPUT lastname $ name1 $;  
CARDS;
Longlastname1  John
Mc Allister  Mike
Longlastname3  Jim
;
RUN;
PROC PRINT DATA=one_1;
RUN;

DATA one_2;
   LENGTH lastname $15 name1 $8;
   INPUT lastname $15. name1 $; 
CARDS;
Longlastname1  John
Mc Allister  Mike
Longlastname3  Jim
;
RUN;
PROC PRINT DATA=one_2;
RUN;

DATA one_3;
   LENGTH lastname $15 name1 $8;
   INPUT lastname $13. name1 $CHAR6.;
CARDS;
Longlastname1  John
Mc Allister  Mike
Longlastname3  Jim
;
RUN;
PROC PRINT DATA=one_3;
RUN;

DATA one_4;
   LENGTH lastname $15 name1 $8;
   INPUT lastname & $15. name1 $;
CARDS;
Longlastname1  John
Mc Allister  Mike
Longlastname3  Jim
;
RUN;
PROC PRINT DATA=one_4;
RUN;



/* ex 3.3 */

DATA char;
    INPUT string $CHAR3.;
    IF string<= 'M' THEN sign1='T';
    IF string<=:'M' THEN sign2='T';
CARDS;
001
 20
  5
Min
min
 OP
김
철
현
#04
&33
# 4
;
RUN;

PROC SORT DATA=char;
    BY string;
RUN;




/* ex 3.4 */

DATA name;
    LENGTH first $5 last $10 degree $4 full $30;
    INFILE CARDS MISSOVER;
    INPUT last $ first $ degree $;
    IF degree=' ' | degree='Unkn'
                  THEN full=first||last||'(unknown)';
        ELSE           full=first||last||'('||degree||')';
CARDS;
Minsu  Park
HyunHee  Lee  PhD
ChulSu  Kim  MD
Inho  Choi  Unkn
;
RUN;


/* ex 3.5 */

DATA testcn;
    INPUT sale $9.;
    fmtsale=INPUT(sale,comma9.);
CARDS;
2,115,353
;
RUN;


/* ex 3.6 */

DATA testnc;
    INPUT ymd 8.;
    fmtymd=PUT(ymd,$8.);
    cyear=SUBSTR(fmtymd,1,4);
    nyear=INPUT(cyear,4.);
CARDS;
20010304
;
RUN;


/* ex 3.7 */

DATA one;
    INPUT name $ resp1 resp2 resp3;
CARDS;
Kang      10       9        8
Park       2       8        4
Lee        5       7        6
;
RUN;

DATA two(DROP=resp1 resp2 resp3 i);
    SET one;
    ARRAY ttt[*] resp1 resp2 resp3;
    LENGTH item $ 5;
    DO i=1 TO DIM(ttt);
        response=ttt[i];
        CALL VNAME(ttt[i],item);
        OUTPUT;
    END;
RUN;