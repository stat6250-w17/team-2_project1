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


/************************ COMMON CODE IN ALL ANALYSIS FILES TILL HERE*********/

* Check and remove duplicate rows in the dataset;

proc sort
        nodupkey
        data=CAASP1516_analytic_file
        out=_null_
    ;
    by School_Code 
       Test_Year 
       Subgroup_ID 
       SubgroupCategory 
       Grade
       Test_Id
	   ;

run;


/************** REST OF THE CODE WILL BE SPECIFIC TO YOUR ANALYSIS ***********/

*----------------------------------------------------------------------;
title1
"Research Question: Find the mean scores of various subgroups based on 
 parent education level ";

title2
"Rationale: Does the parent education have an impact on student performance? Are students with support at home able to perform better on SBAC testing?";

title3
"Language Arts.";
*
Research Question: Find the mean scores of various subgroups based on parent education level 
Rationale: Does the parent education have an impact on student performance? Are students with support at home able to perform better on SBAC testing?

Methodology: Use PROC MEANS to compute the mean of scores for each subgroup of students across entire district for each test (English and Mathematics), and output the results to a temporary dataset.
 Use PROC SORT extract and sort just the means the temporary dataset, and use PROC PRINT to print the results in the descending order of mean scores.
;

*--------------CODE BLOCK ----------------;


/*For Test ID 1 - English/Language Arts*/
proc sort data=CAASP1516_analytic_file;/*subset results for only Parent education related resultrows & Test_ID 1*/
      by test_ID subgroup_ID
;

proc means mean noprint data=CAASP1516_analytic_file;/*subset results for only Parent education related resultrows & Test_ID 1*/
     where subgroupCategory = ' "Parent Education"' and test_ID = 1 and school_code > 0;
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
    output out=CAASP1516_analytic_file_temp;
run;


title3
"Mathematics";

/*For Test ID 2 - Mathematics*/
proc means mean noprint data=CAASP1516_analytic_file;/*subset results for only Parent education related resultrows & Test_ID 1*/
     where subgroupCategory = ' "Parent Education"' and test_ID = 2 and school_code > 0;
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
Area_4_Percentage_Above_Standard
Area_4_Percentage_Near_Standard
Area_4_Percentage_Below_Standard
;
    output out=CAASP1516_analytic_file_temp;
run;


proc print noobs data=CAASP1516_analytic_file_temp;
    id Test_ID Subgroup_ID SubgroupCategory SubgroupDescription;
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

/************************************************** TILL HERE **********************************************/


*-----------------------------------------------------------------------------------;
footnote1
""
;
footnote2
""
;

*-----------------------------------------------------------------------------------;
title1
"Report 2";
title2
"Research Question: Compare performance of boys vs. girls across different grade levels. ";

title2
"Rationale: This would reveal if the SBAC testing methodology is better suited for one gender or if the scores are relatively even.";



*
 
Methodolody: Calculate mean scores for boys and girls for each grade level across teh entire county

;
*--------------CODE BLOCK ----------------;
proc means data=CAASP1516_analytic_file ;
  where subgroupCategory = ' "Gender"' and school_code > 0;/*Subset data to process result rows for subgroupCategory = 'Gender'*/;
    class subgroupCategory SubgroupDescription;
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


*-----------------------------------------------------------------------------------;
footnote1
"End of report 2"
;
*-----------------------------------------------------------------------------------;
title1
"Report 3.";
title2
"Research Question: Find the mean scores for 2015, 2016 by grade level for each of the 
Areas of measurement for each testing (four areas for Language Arts and three for Mathematics)";

title2
"Rationale: Although two years data is not enought o show a trend, 
            it would be interesting to see which areas are consistently most challenging to students.";


*
Research Question: Find the mean scores for 2015, 2016 by grade level for each of the Areas of measurement for each testing (four areas for Language Arts and three for Mathematics)
Rationale: Although two years data is not enought o show a trend, it would be interesting to see which areas are consistently most challenging to students.

Methodology: Calculate grade-wise mean scores for each area of assessment and compare (using a graph?) how results for 2015 compare with that of 2016. 
;

*--------------CODE BLOCK ----------------;
proc means data=CAASP1516_analytic_file;
    where test_ID = 1 and school_code > 0;
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

/*Grade wise means for Mathematics*/
proc means min q1 median q3 max data=CAASP1516_analytic_file;
    where test_ID = 2 and school_code > 0;
    class grade;
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


/*-----------------------------------------------------------------------------------;
footnote1
""
;
*-----------------------------------------------------------------------------------;

