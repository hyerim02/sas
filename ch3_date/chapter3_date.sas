/* ex 3.8 */

DATA dept;
    INPUT name $10. bdate DATE7. +1 hired MMDDYY8.;
    hiredate=hired+(365.25*3);
    hireqtr=QTR(hiredate);
    IF hired>'01jan94'D THEN new='YES';
    FORMAT bdate MMDDYY8. hired YYMMDD8. hiredate WEEKDATE17.;
CARDS;
김철수 01jan60 09-15-90
최민지 05oct49 01-24-92
이영희 18mar88 10-10-93
오인수 29feb80 05-29-94
;
RUN;

PROC PRINT DATA=dept;
RUN;

/* ex 3.9 */

DATA ex39a;
    INFILE '/home/u47346135/sasuser.v94/sales.dat';
    INPUT id  @8 saled @15 asd @23 ascost;
    diff=asd-saled;
RUN;
PROC PRINT; RUN;

DATA ex39b;
    INFILE '/home/u47346135/sasuser.v94/sales.dat';
    INPUT id @8 saled yymmdd6. @15 asd yymmdd6. @23 ascost;
    diff=asd-saled;
RUN;
PROC PRINT; RUN;


/* ex 3.10 */

DATA ex38;
    INFILE '/home/u47346135/sasuser.v94/sales.dat';
    INPUT id  @8 saled yymmdd6. @15 asd yymmdd6. @23 ascost;
    diff=asd-saled;
    FORMAT saled asd yymmdd8.;
RUN;
PROC PRINT; RUN;


/* Date Function */

DATA mdyexam1;
        INPUT mon day year;
        date=MDY(mon,day,year);
        FORMAT date YYMMDD8.;
CARDS;
12 11 1997
03 18 1998
;
PROC PRINT; RUN;

DATA mdyex; 
    INPUT mon day year;
    newdate=MDY(mon,day,year);
    FORMAT newdate YYMMDD10.;
CARDS;
12 11 1997
03 18 1998
;
PROC PRINT; RUN;

DATA todayex;
    SET mdyex;
    today=TODAY();
    diff=today-newdate;
    FORMAT today newdate YYMMDD10.; /* or FORMAT today newdate YYMMDD8.; */
RUN;
PROC PRINT; RUN;


/* ex 3.11 */

DATA fct_ex;
    SET ex38;
    sale_day=DAY(saled);
    sale_mon=MONTH(saled);
    saleyear=YEAR(saled);
    s_weeked=WEEKDAY(saled);
    KEEP saled asd ascost sale_day sale_mon saleyear s_weeked; 
    FORMAT asd DATE7.; 
RUN;
PROC PRINT; RUN;


/* ex 3.12 */

DATA intnxex1;
    date2=INTNX('MONTH','05JAN2000'D,10);
    date3=INTNX('YEAR',date2,1);
    FORMAT date2 date3 YYMMDD10.;
RUN;
PROC PRINT; RUN;


/* p. 71 */

DATA intnxex2;
    date1=INTNX('YEAR' ,'18MAR96'D, 2);
    date2=INTNX('YEAR' ,'18JAN98'D, 0);
    date3=INTNX('MONTH','21FEB98'D,-1);
    date4=INTNX('MONTH','31DEC97'D, 1);
    FORMAT date1-date4 YYMMDD6.;
RUN;
PROC PRINT; RUN;

/* ex 3.13 */

DATA intnxex3;
    INPUT sales;
    date=INTNX('MONTH','01JAN2001'D,_N_-1);
    FORMAT date YYMON7.;
CARDS;
113
137
149
;
RUN;
PROC PRINT; RUN;


/* ex 3.14 */

DATA formatex;
    INPUT id  @8 saled yymmdd6. @15 asd yymmdd6. @23 ascost;
    diff=asd-saled;
    FORMAT saled asd yymmdd8.;
CARDS;
000001 980123 980310  5000
000002 980125 980215  15000
000003 980211 980301  7000
000004 980301 980320  9000
;
RUN;
PROC PRINT; RUN;

DATA intckex;
    SET formatex;
    today=TODAY();
    nas_week=INTCK('WEEK',saled,asd);
    nmonth=INTCK('MONTH',saled,today); 
FORMAT today YYMMDD8.;
RUN;
PROC PRINT; RUN;
