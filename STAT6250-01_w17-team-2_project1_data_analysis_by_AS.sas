*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding free/reduced-price meals at CA public K-12 schools
Dataset Name: CAASP1516_analytic_file created in external file
STAT6250-01_w17-team-2_project1_data_preparation.sas, which is assumed to be in the same directory as this file
See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick;
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset CAASP1516_analytic_file;
%include '.\STAT6250-01_w17-team-2_project_data_preparation.sas';


*
Research Question 1: Find the mean scores of various subgroups based on parent education level? 
Rationale: Does the parent education have an impact on student performance? Are students with support at home able to perform better on SBAC testing?

Methodology: Use PROC MEANS to compute the mean of scores for each subgroup of students across entire district, and output the results to a temportatry dataset. Use PROC
SORT extract and sort just the means the temporary dataset, and use PROC PRINT to print the results in the descending order of mean scores.
;

*
Research Question 2: Compare performance of boys vs. girls across different grade levels. 
Rationale: This would reveal if the SBAC testing methodology is better suited for one gender or if the scores are relatively even.
 
Methodolody: Calculate mean scores for boys and girls for each grade level across the entire county

;


*
Research Question: Find the mean scores for 2015, 2016 by grade level for each of the Areas of measurement for each testing (four areas for Language Arts and three for Mathematics)
Rationale: Although two years' data is not enough to show a trend, it would be interesting to see which areas are consistently most challenging to students.

Methodology: Calculate grade-wise mean scores for each area of assessment and compare (using a graph?) how results for 2015 compare with that of 2016. 
;

