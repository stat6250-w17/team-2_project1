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
        "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget
            (SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))"""
        ;           
        %include ".\&dataPrepFileName.";
    %end;
%else
    %do;
        %include "~/&sasUEFilePrefix./&dataPrepFileName.";
    %end;
%mend;
%setup


proc contents data = CAASP1516_analytic_file; /* Use this data in all your 
        analysis code */
run;


/************************ COMMON CODE IN ALL ANALYSIS FILES TILL HERE*********/


*
Research Question 1: Does English proficiency affect performance on state math 
tests for the 2015 version of the test versus the 2016 version of the test? 

Rationale: Are the 2015 and/or 2016 state math tests based too heavily on 
language skills, and how do they compare in outcomes for English language 
learners?

Methodology: Use PROC MEANS to find mean subgroup math scores 
(Mean_Scale_Score) for students in English-fluent subgroups 
(Subgroup_ID = 6,7,8,180) vs the mean of the Mean_Scale_Score for students 
who are English learners (Subgroup_ID = 120,142,160) for the state math test 
(Test_Id = 2) in 2015 and 2016 (Test_Year = 2015, 2016) and output the results 
to a temporary dataset. 
;

*--------------CODE BLOCK ----------------;

 /*For Test ID 2 - Mathematics Test, CAASP 2015, 2016 */
 /*subset results for English-proficient student math results*/
 
title1 'Calculating mean math scores of English-proficient students';
proc means data=CAASP1516_analytic_file(where=(Subgroup_Id 
    in (6,7,8,180) and Test_Id=2 and Test_Year in (2015,2016))) 
    maxdec=2 n mean std median min max;

    class Test_Year;
	var Mean_Scale_Score; 
    output out=eng_prof; 

 run;
title1;
 title2 'Calculating mean math scores of non-English-proficient students';
 proc means data=CAASP1516_analytic_file(where=(Subgroup_Id in (120,142,160) 
    and Test_Id=2 and Test_Year in (2015,2016))) 
    maxdec=2 n mean std median min max;

    class Test_Year;
	var Mean_Scale_Score; 
    output out=non_eng_prof; 

 run;
title2;

footnote1 'CAASP Math Test Results 2015,2016';



*
Research Question 2: Is mastery of state math standards correlated with parents 
having at least some college compared with students whose parents are 
high school graduates or who have not graduated from high school. 

Rationale: This would indicate whether parent educational achievement levels
are directly related to student academic outcomes in math, a key subject
for 21st-century jobs.

Methodolody: Use PROC MEANS to compute mean subgroup math scores 
(Mean_Scale_Score) for all student subgroups across all districts for those 
with parents with some college and beyond (Subgroup_ID = 92,93,94) and for 
those whose parents do not have at least some college background 
(Subgroup_ID = 90,91) for 2015 and 2016 (Test_Year = 2015, 2016) and output the
results to a temporary dataset. 
;

*--------------CODE BLOCK ----------------;
 /*For Test ID 2 - Mathematics Test, CAASP 2015, 2016 */
 /*subset results for student math results by parent education*/
 
title1 'Calculating mean math scores of students whose parents have not 
    attended college';
proc means data=CAASP1516_analytic_file(where=(Subgroup_Id 
    in (90,91) and Test_Id=2 and Test_Year in (2015,2016))) 
    maxdec=2 n mean std median min max;

    class Test_Year;
	var Mean_Scale_Score; 
    output out=parent_no_college; 

 run;
title1;
title2 'Calculating mean math scores of students whose parents have 
    attended at least some college or beyond';
 proc means data=CAASP1516_analytic_file(where=(Subgroup_Id 
    in (92,93,94) and Test_Id=2 and Test_Year in (2015,2016))) 
    maxdec=2 n mean std median min max;

    class Test_Year;
	var Mean_Scale_Score; 
    output out=parent_some_college; 

 run;
title2;

footnote1 'CAASP Math Test Results 2015,2016';

*
Research Question 3: Does economic disadvantage correlate with low math scores?

Rationale: Should we focus more resources on helping economically-disadvantaged
students succeed in higher-income STEM pathways?

Methodology: Use PROC MEANS to compute the mean subgroup math scores 
(Mean_Scale_Score) for all student subgroups for those who are economically 
disadvantaged (Subgroup_ID = 31) vs. those who are not economically 
disadvantaged (Subgroup_ID = 111) for 2015 and 2016 (Test_Year = 2015, 2016) 
and output the results to a termporary dataset. 
;

*--------------CODE BLOCK ----------------;
 /*For Test ID 2 - Mathematics Test, CAASP 2015, 2016 */
 /*subset results for student math results by economic disadvantage*/
 
title1 'Calculating mean math scores of students who are economically disadvantaged';
proc means data=CAASP1516_analytic_file(where=(Subgroup_Id=31 and Test_Id=2 
    and Test_Year in (2015,2016))) 
    maxdec=2 n mean std median min max;

    class Test_Year;
	var Mean_Scale_Score; 
    output out=econ_disadv; 

 run;
title1;
title2 'Calculating mean math scores of students who are not economically 
    disadvantaged';
 proc means data=CAASP1516_analytic_file(where=(Subgroup_Id=111 and Test_Id=2 
    and Test_Year in (2015,2016)))  
    maxdec=2 n mean std median min max;

    class Test_Year;
	var Mean_Scale_Score; 
    output out=no_econ_disadv; 

 run;
title2;

footnote1 'CAASP Math Test Results 2015,2016';
