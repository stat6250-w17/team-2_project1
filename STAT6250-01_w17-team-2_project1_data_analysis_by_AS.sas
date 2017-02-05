*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the CAASP1516_analytic_file analytic dataset to address several 
research questions regarding free/reduced-price meals at CA public K-12 schools
Dataset Name: CAASP1516_analytic_file created in external file
STAT6250-01_w17-team-2_project1_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
;

* environmental setup;
%let dataPrepFileName = STAT6250-01_w17-team-2_project1_data_preparation.sas;
%let sasUEFilePrefix = team-2_project1;

* load external file that generates analytic dataset FRPM1516_analytic_file
using a system path dependent on the host operating system, after setting the
relative file import path to the current directory, if using Windows;
%macro setup;
%if
    &SYSSCP. = WIN
%then
    %do;
        X
        "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))"""
        ;           
        %include ".\&dataPrepFileName.";
    %end;
%else
    %do;
        %include "~/&sasUEFilePrefix./&dataPrepFileName.";
    %end;
%mend;
%setup
;





*---------------------------------REPORT 1------------------------------------;
title1
"Research Question: Find the mean scores of various subgroups based on 
 parent education level ";

title2
"Rationale: Does the parent education have an impact on student performance? 
             Are students with support at home able to perform better on SBAC 
             testing?";

title3 
"Subject : English/Language Arts";

*Methodology: Use PROC MEANS to compute the mean of scores for each subgroup of
              students across entire district for each test based on parent 
              education level(English and Mathematics).
;


/*For Test ID 1 - English/Language Arts*/
proc means data=CAASP1516_analytic_file maxdec=2;
     where subgroupCategory =' "Parent Education"'/*only stats for parent ed */ 
       and test_ID = 1                            /*Only english test results*/
       and school_code > 0;
    class subgroupCategory SubgroupDescription;
    var 
	Area_1_Percentage_Above_Standard
	Area_1_Percentage_Near_Standard
	Area_1_Percentage_Below_Standard
	Area_2_Percentage_Above_Standard
	Area_2_Percentage_Near_Standard
	Area_2_Percentage_Below_Standard
	Area_3_Percentage_Above_Standard
	Area_3_Percentage_Near_Standard
	Area_3_Percentage_Below_Standard
	Area_4_Percentage_Above_Standard
	Area_4_Percentage_Near_Standard
	Area_4_Percentage_Below_Standard
	;
/*	label Area_1_Percentage_Above_Standard="Reading % Above Standard";
	label Area_1_Percentage_Near_Standard ="Reading % Near Standard";
	label Area_1_Percentage_Below_Standard="Reading % Below Standard";
	label Area_2_Percentage_Above_Standard="Writing % Above Standard";
	label Area_2_Percentage_Near_Standard ="Writing % Near Standard";
	label Area_2_Percentage_Below_Standard="Writing % Below Standard";
	label Area_3_Percentage_Above_Standard="Listening % Above Standard";
	label Area_3_Percentage_Near_Standard ="Listening % Near Standard";
	label Area_3_Percentage_Below_Standard="Listening % Below Standard";
	label Area_4_Percentage_Above_Standard="Research/Inquiry % Above Standard";
	label Area_4_Percentage_Near_Standard ="Research/Inquiry % Near Standard";
	label Area_4_Percentage_Below_Standard="Research/Inquiry % Below Standard";
	
*/
run;


title3 
"Subject : Mathematics";

/*For Test ID 2 - Mathematics*/
proc means data=CAASP1516_analytic_file maxdec=2;
     where subgroupCategory =' "Parent Education"' /*only stats for parent ed */
       and test_ID = 2                         /*Only mathematics test results*/
       and school_code > 0;
    class subgroupcategory SubgroupDescription;
    var 
	Area_1_Percentage_Above_Standard
	Area_1_Percentage_Near_Standard
	Area_1_Percentage_Below_Standard
	Area_2_Percentage_Above_Standard
	Area_2_Percentage_Near_Standard
	Area_2_Percentage_Below_Standard
	Area_3_Percentage_Above_Standard
	Area_3_Percentage_Near_Standard
	Area_3_Percentage_Below_Standard
	;
/*	label Area_1_Percentage_Above_Standard="Concepts/Procedures % Above Standard";
	label Area_1_Percentage_Near_Standard ="Concepts/Procedures % Near Standard";
	label Area_1_Percentage_Below_Standard="Concepts/Procedures % Below Standard";
	label Area_2_Percentage_Above_Standard="Problem Solving/Modeling % Above Standard";
	label Area_2_Percentage_Near_Standard ="Problem Solving/Modeling % Near Standard";
	label Area_2_Percentage_Below_Standard="Problem Solving/Modeling % Below Standard";
	label Area_3_Percentage_Above_Standard="Communicating Reasoning % Above Standard";
	label Area_3_Percentage_Near_Standard ="Communicating Reasoning % Near Standard";
	label Area_3_Percentage_Below_Standard="Communicating Reasoning % Below Standard";
	
*/
run;


*-----------------------------------------------------------------------------;
footnote1
"The results show that there is a definite correlation between the parent education level 
 and the % of students performing above standard in each assessment area."
;



*----------------------------Report 2-----------------------------------------;
title1
"Research Question: Compare performance of boys vs. girls across different 
 grade levels and for each test English and Mathematics";

title2
"Rationale: This would reveal if the SBAC testing methodology is better suited 
            for one gender or if the scores are relatively even.";

title3
"Subject : English/Language Arts";


*
Methodolody: Calculate mean scores for boys and girls for each grade level 
             across the entire county
;

/*Gender results by grade for English*/
proc means data=CAASP1516_analytic_file maxdec=2;
  where subgroupCategory = ' "Gender"' 
    and test_ID = 1                   /*English*/
    and school_code > 0;
    class grade subgroupCategory SubgroupDescription;
    var    Area_1_Percentage_Above_Standard
	   Area_1_Percentage_Near_Standard
	   Area_1_Percentage_Below_Standard
	   Area_2_Percentage_Above_Standard
	   Area_2_Percentage_Near_Standard
	   Area_2_Percentage_Below_Standard
	   Area_3_Percentage_Above_Standard
	   Area_3_Percentage_Near_Standard
	   Area_3_Percentage_Below_Standard
	   Area_4_Percentage_Above_Standard
	   Area_4_Percentage_Near_Standard
	   Area_4_Percentage_Below_Standard
;
run;

title3
"Subject : Mathematics";

/*Gender results by grade for Mathematics*/
proc means data=CAASP1516_analytic_file maxdec=2;
    where subgroupCategory = ' "Gender"' 
    and test_ID = 2                   /*Mathematics*/
    and school_code > 0;
    class grade subgroupCategory SubgroupDescription;
    var    Area_1_Percentage_Above_Standard
	   Area_1_Percentage_Near_Standard
	   Area_1_Percentage_Below_Standard
	   Area_2_Percentage_Above_Standard
	   Area_2_Percentage_Near_Standard
	   Area_2_Percentage_Below_Standard
	   Area_3_Percentage_Above_Standard
	   Area_3_Percentage_Near_Standard
	   Area_3_Percentage_Below_Standard
	   Area_4_Percentage_Above_Standard
	   Area_4_Percentage_Near_Standard
	   Area_4_Percentage_Below_Standard
;
run;

*-----------------------------------------------------------------------------;
footnote1
"The difference between boys and girls for % student performing above/near/below
 standard is wider in English than in Math."
;
*-----------------------------------------------------------------------------;

title1
"Research Question: Find the mean scores for 2015, 2016 by grade level for 
                    each of the Areas of measurement for each test area 
                    (four areas for Language Arts and three for Mathematics)";

title2
"Rationale: Although two years data is not enought o show a trend, it would 
            be interesting to see which areas are consistently most 
            challenging to students.";



*
Methodology: Calculate grade-wise mean scores for each area of assessment 
              and compare how results for 2015 compare with that of 2016. 
;

title3 "Subject : English/Language Arts";

/*Grade wise means for English*/
proc means data=CAASP1516_analytic_file maxdec=2;
     where test_ID = 1 
       and school_code > 0
 	;
    class Test_year grade;
    var
	Area_1_Percentage_Above_Standard
	Area_1_Percentage_Near_Standard
	Area_1_Percentage_Below_Standard
	Area_2_Percentage_Above_Standard
	Area_2_Percentage_Near_Standard
	Area_2_Percentage_Below_Standard
	Area_3_Percentage_Above_Standard
	Area_3_Percentage_Near_Standard
	Area_3_Percentage_Below_Standard
	Area_4_Percentage_Above_Standard
	Area_4_Percentage_Near_Standard
	Area_4_Percentage_Below_Standard    
	;
run;


title3
"Subject : Mathematics";

/*Grade wise means for Mathematics*/
proc means data=CAASP1516_analytic_file maxdec=2;
    where test_ID = 2 
      and school_code > 0;
    class Test_year grade;
    var
	Area_1_Percentage_Above_Standard
	Area_1_Percentage_Near_Standard
	Area_1_Percentage_Below_Standard
	Area_2_Percentage_Above_Standard
	Area_2_Percentage_Near_Standard
	Area_2_Percentage_Below_Standard
	Area_3_Percentage_Above_Standard
	Area_3_Percentage_Near_Standard
	Area_3_Percentage_Below_Standard
	Area_4_Percentage_Above_Standard
	Area_4_Percentage_Near_Standard
	Area_4_Percentage_Below_Standard    
	;
run;


footnote1
"Needs further detailed comparison. But on the outset the results look fairly similar 
.e.g Grade 3 for English and Mathematics show a similar pattern of % above/near/below
standards."
;

title1"";
title2"";
title3"";
footnote1"";
footnote2"";
footnote3"";

*-----------------------------------------------------------------------------;

QUIT;
