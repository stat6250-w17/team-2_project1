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

* set relative file import path to current directory (using standard SAS trick;
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,
%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset CAASP1516_analytic_file;
%include '.\STAT6250-01_w17-team-2_project_data_preparation.sas';


*
Research Question 1: Find the mean math scores of English Language Learners in 
the country for less than 1 yr, English Language Learners in the U.S. for more 
than one year, and fluent English speakers.
Rationale: Are state math scores based too heavily on language skills?
Methodology: Use PROC MEANS to compute the mean of scores for each subgroup of 
students across all districts, and output the results to a temportatry dataset. 
Use PROC SORT extract and sort just the means the temporary dataset, and use 
PROC PRINT to print the results in the descending order of mean scores.
;

*
Research Question 2: Compare the performance of students on state math tests
whose parents have at least some college with students whose parents are 
high school graduates or who have not graduated from high school. 
Rationale: This would indicate whether parent educational achievement levels
are directly related to student academic outcomes in math, a key subject
for 21st-century jobs.
Methodolody: Calculate mean math scores for all students for each grade level 
across the entire county for those with parents with some college and beyond
and for those whose parents do not have at least some college background.
;


*
Research Question 3: Find the mean scores for 2015, 2016 by grade level for 
students who are on the school lunch program. 
Rationale: Is there a strong correlation between poverty levels and academic 
achievement?
Methodology: Calculate grade-wise mean scores for each area of assessment 
and compare how results for 2015 compare with that of 2016. 
;
