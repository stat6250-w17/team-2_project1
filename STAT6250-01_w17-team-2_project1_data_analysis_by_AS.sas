*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding free/reduced-price meals at CA public K-12 schools
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


proc contents data = CAASP1516_analytic_file; /* Use this data in all your analysis code */
run;


/************************ COMMON CODE IN ALL ANALYSIS FILES TILL HERE*********/


/************** REST OF THE CODE WILL BE SPECIFIC TO YOUR ANALYSIS ***********/

*
Research Question: Find the mean scores of various subgroups based on parent education level 
Rationale: Does the parent education have an impact on student performance? Are students with support at home able to perform better on SBAC testing?

Methodology: Use PROC MEANS to compute the mean of scores for each subgroup of students across entire district for each test (English and Mathematics), and output the results to a temporary dataset.
 Use PROC SORT extract and sort just the means the temporary dataset, and use PROC PRINT to print the results in the descending order of mean scores.
;

*--------------CODE BLOCK ----------------;


/*For Test ID 1 - English/Language Arts*/
proc means mean noprint data=CAASP1516_analytic_file;/*subset results for only Parent education related resultrows & Test_ID 1*/
    class subgroupName;
    var Area_1_Percentage_Above_Standard,
Area_1_Percentage_Near_Standard,
Area_1_Percentage_Below_Standard,
Area_2_Percentage_Above_Standard,
Area_2_Percentage_Near_Standard,
Area_2_Percentage_Below_Standard,
Area_3_Percentage_Above_Standard,
Area_3_Percentage_Near_Standard,
Area_3_Percentage_Below_Standard,
Area_4_Percentage_Above_Standard,
Area_4_Percentage_Near_Standard,
Area_4_Percentage_Below_Standard
;
    output out=CAASP1516_analytic_file_temp;
run;


/*For Test ID 2 - Mathematics*/
proc means mean noprint data=CAASP1516_analytic_file;/*subset results for only Parent education related resultrows & Test_ID 2*/
    class subgroupName;
    var Area_1_Percentage_Above_Standard,
Area_1_Percentage_Near_Standard,
Area_1_Percentage_Below_Standard,
Area_2_Percentage_Above_Standard,
Area_2_Percentage_Near_Standard,
Area_2_Percentage_Below_Standard,
Area_3_Percentage_Above_Standard,
Area_3_Percentage_Near_Standard,
Area_3_Percentage_Below_Standard,
Area_4_Percentage_Above_Standard,
Area_4_Percentage_Near_Standard,
Area_4_Percentage_Below_Standard
;
    output out=CAASP1516_analytic_file_temp;
run;


proc print noobs data=CAASP1516_analytic_file_temp;
    id Test_ID, SubgroupName;
    var    Area_1_Percentage_Above_Standard,
Area_1_Percentage_Near_Standard,
Area_1_Percentage_Below_Standard,
Area_2_Percentage_Above_Standard,
Area_2_Percentage_Near_Standard,
Area_2_Percentage_Below_Standard,
Area_3_Percentage_Above_Standard,
Area_3_Percentage_Near_Standard,
Area_3_Percentage_Below_Standard,
Area_4_Percentage_Above_Standard,
Area_4_Percentage_Near_Standard,
Area_4_Percentage_Below_Standard
;
run;


*
Research Question: Compare performance of boys vs. girls across different grade levels. 
Rationale: This would reveal if the SBAC testing methodology is better suits one gender or if the scores are relatively even.
 
Methodolody: Calculate mean scores for boys and girls for each grade level across teh entire county

;
*--------------CODE BLOCK ----------------;
proc means min q1 median q3 max data=CAASP1516_analytic_file/*Subset data to process result rows for subgroupCategory = 'Gender'*/;
    class SubgroupName;
    var /*Assessment Areas*/;
run;


*
Research Question: Find the mean scores for 2015, 2016 by grade level for each of the Areas of measurement for each testing (four areas for Language Arts and three for Mathematics)
Rationale: Although two years data is not enought o show a trend, it would be interesting to see which areas are consistently most challenging to students.

Methodology: Calculate grade-wise mean scores for each area of assessment and compare (using a graph?) how results for 2015 compare with that of 2016. 
;

*--------------CODE BLOCK ----------------;
proc means min q1 median q3 max data=CAASP1516_analytic_file;
    class grade
    var
Area_1_Percentage_Above_Standard,
Area_1_Percentage_Near_Standard,
Area_1_Percentage_Below_Standard,
Area_2_Percentage_Above_Standard,
Area_2_Percentage_Near_Standard,
Area_2_Percentage_Below_Standard,
Area_3_Percentage_Above_Standard,
Area_3_Percentage_Near_Standard,
Area_3_Percentage_Below_Standard,
Area_4_Percentage_Above_Standard,
Area_4_Percentage_Near_Standard,
Area_4_Percentage_Below_Standard    ;
run;