*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding CAASP test results 

Dataset Name: CAASP1516_analytic_file created in external file
STAT6250-01_w17-team-2_project1_data_preparation.sas, which is assumed to be in 
the same directory as this file

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick;
%let dataPrepFileName = STAT6250-01_w17-team-2_project1_data_preparation.sas;
%let sasUEFilePrefix = team-2_project1;

* load external file that generates analytic dataset FRPM1516_analytic_file,using 
a system path dependent on the host operating system, after setting the
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


title1
"Research Question 1: What's the difference between the mean scores of students who 
are economically disadvantaged and those who are not?"
;

title2
"Rationale: This should help us identify what's the economic status impact on the 
test score and see how big it is"
;

footnote1
"Based on the output above, we can see that for those who are economically doing well have a better 
performance on the test. But the difference is not as high"
;

*
Methodology: Use PROC MEANS to compute the mean scores for the data input of data-
set and output the results to a temporary dataset. Use PROC FORMAT to extract and sort 
just the means the temporary dataset to just compare the subset of students who are economically 
disadvantaged and those who are not disadvantaged.
;

proc format;
	value subgroup_id_fmt
		31="Subgroup 31"
		111="Subgroup 111"
		;

proc means data = CAASP1516_analytic_file;
				class subgroup_id;
				var Mean_scale_score;
				format subgroup_id subgroup_id_fmt.;
run;
title;
footnote;


title1
"Research Question 2: Is the economics status has the same impact across different 
ethnicities?"
; 

title2
"Rationale: By controlling one factor ethinicity, this is to help us identify if there
is any difference of economic status' impact on ethnicities and by comparing 
the result of different ethnicities, we can see which ethinicity is affected by the
economic status the most"
;

footnote1
"from the result above, we can indeed tell that economic wellbeing can make a difference 
among different ethnicities"
;

footnote2
"The impact of the eocnomic difference on different ethnicities are different and surprisingly,
the impact on Asians are not the biggest. We may need to take a further look to study for the
difference impact on different ethnicities"
;

proc format;
	value subgroup_id_fmt
		31="Subgroup 31"
		111="Subgroup 111"
		200="Subgroup 200"
		220="Subgroup 220"
		201="Subgroup 201"
		221="Subgroup 221"
		202="Subgroup 202"
		222="Subgroup 222"
		203="Subgroup 203"
		223="Subgroup 223"
	    204="Subgroup 224"
		224="Subgroup 224"
        205="Subgroup 225"
		225="Subgroup 225"
		206="Subgroup 206"
		226="Subgroup 226"
		207="Subgroup 207"
		227="Subgroup 227"
		;

proc means data = CAASP1516_analytic_file;
				class subgroup_id;
				var Mean_scale_score;
				format subgroup_id subgroup_id_fmt.;
run;
title;
footnote;

*
Methodology: Use PROC MEANS to compute the mean scores for the data input of data-
set and output the results to a temporary dataset. Use PROC FORMAT to extract and sort 
just the means the temporary dataset to just compare the subset of students who are economically 
disadvantaged and those who are not disadvantaged within different ethnicities.
; 

title1
"Research Question 3: Which of the areas (arts or science subject) does it impact the 
most due to economic status?"
;

title2
"Rationale: Through this, we can identify which area of study is impacted the most by
the economic status"
; 

footnote1
"from the result above, we can find out that the economic status has more impact on test group 2, which
is the scientific subject. This is probably due to the fact that wealthier family usually have study 
tutoring and it can have visible effect on science objects than humanity objects"
;

footnote2
"the ethnicity of the student may also reflect on the test score for different subjects. We can maybe take a
further study on the correlationship between those two"
;

proc format;
	value subgroup_id_fmt
		31="Subgroup 31"
		111="Subgroup 111"
		;

proc means data = CAASP1516_analytic_file;
				class subgroup_id test_id;
				where test_id = 1;
				var Mean_scale_score;
				format subgroup_id subgroup_id_fmt.;
run;

proc means data = CAASP1516_analytic_file;
				class subgroup_id test_id;
				where test_id = 2;
				var Mean_scale_score;
				format subgroup_id subgroup_id_fmt.;
run;
title;
footnote;

*
Methodology: Use PROC MEANS to compute the mean scores for the data input of data-
set and output the results to a temporary dataset. Use PROC FORMAT to extract and sort 
just the means the temporary dataset to just compare just the results of the 
subsets of students who are economically disadvantaged and those who are not. Then 
compare the result of economic impact on different subjects.
; 


/* NOTE: Need to compare the results of the mean to test which area is impacted the most. */
