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
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPA
TH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset FRPM1516_analytic_file;
%include '.\STAT6250-01_w17-team-2_project1_data_preparation.sas';

*
Research Question 1: What's the difference between the mean scores of students who 
are economically disadvantaged and those who are not?

Rationale: This should help us identify what's the economic status impact on the 
test score and see how big it is

Methodology: Use PROC MEANS to compute the mean scores for the data input of data-
set and output the results to a temporary dataset. Use PROC SORT extract and sort 
just the means the temporary dataset, and use PROC PRINT to print just the subset 
of students who are economically disadvantaged and those who are not disadvantaged

* ---Code Block------;

/*for Test ID 1 - English/Languge Arts*/

proc means mean onprint data=CAASP1516_analytic_file;
           class subgroupID=31;
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
    
    proc means mean onprint data=CAASP1516_analytic_file;
           class subgroupID=111;
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
    
    
/*for Test ID 2 - Mathematics*/

proc means mean onprint data=CAASP1516_analytic_file;
           class subgroupID=31;
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
 
proc means mean onprint data=CAASP1516_analytic_file;
           class subgroupID=111;
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

*

Research Question 2: Is the economics status has the same impact across different 
ethnicities? 

Rationale: By controlling one factor ethinicity, this is to help us identify if there
is any difference of economic status' impact on ethnicities and by comparing 
the result of different ethnicities, we can see which ethinicity is affected by the
economic status the most

Methodology: Use PROC MEANS to compute the mean scores for the data input of dataset 
and output the results to a temporary dataset. Use PROC SORT extract and sort just 
the means the temporary dataset, and use PROC PRINT to print just the results of the 
subsets of students who are economically disadvantaged and those who are not. Then 
compare the result. 

/*for Test ID 1 - English/Languge Arts*/

proc means mean onprint data=CAASP1516_analytic_file;
           class subgroupID=31, subgroupID=74, subgroupID=75, subgroupID=76,
           subgroupID=77, subgroupID=78, subgroupID=79, subgroupID=80;
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

    proc means mean onprint data=CAASP1516_analytic_file;
           class subgroupID=111, subgroupID=74, subgroupID=75, subgroupID=76,
           subgroupID=77, subgroupID=78, subgroupID=79, subgroupID=80;
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

/*for Test ID 2 - Mathematics*/

proc means mean onprint data=CAASP1516_analytic_file;
           class subgroupID=31, subgroupID=74, subgroupID=75, subgroupID=76,
           subgroupID=77, subgroupID=78, subgroupID=79, subgroupID=80;
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
 
proc means mean onprint data=CAASP1516_analytic_file;
           class subgroupID=111, subgroupID=74, subgroupID=75, subgroupID=76,
           subgroupID=77, subgroupID=78, subgroupID=79, subgroupID=80;
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

*
Research Question 3: Which of the areas (arts or science subject) does it impact the 
most due to economic status? 

Rationale: Through this, we can identify which area of study is impacted the most by
the economic status 

Methodology: Use PROC MEANS to compute the mean scores for the data input of dataset 
and output the results to a temporary dataset. Use PROC SORT extract and sort just 
the means the temporary dataset, and use PROC PRINT to print just the results of the 
subsets of students who are economically disadvantaged and those who are not. Then 
compare the result of economic impact on different subjects. 

/*for Test ID 1 - English/Languge Arts*/

proc means mean onprint data=CAASP1516_analytic_file;
           class subgroupID=31;
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
    
    proc means mean onprint data=CAASP1516_analytic_file;
           class subgroupID=111;
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
    
    
/*for Test ID 2 - Mathematics*/

proc means mean onprint data=CAASP1516_analytic_file;
           class subgroupID=31;
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
 
proc means mean onprint data=CAASP1516_analytic_file;
           class subgroupID=111;
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
/* NOTE: Need to compare the results of the mean to test which area is impacted the most. */
