﻿*******************************************************************************;

* 
This file prepares the dataset described below for analysis.
Dataset Name: CAASP Test Results for English language arts/literacy and Mathematics for Fremont Unified School District for Alameda county for years 2015 and 2016 (2 separate datasets)

Experimental Units: Test result for each type of test for each school in Alameda 
Number of Observations 14431 (2015) and 13952 (2016)

Number of Features: 33
Data Source: The files CAASP_Test_ results_2015_2016.xls has been created by downloading and combining the datasets below into a single xls with multiple worksheets. 

http://caaspp.cde.ca.gov/SB2016/ResearchFileList?ps=true&lstTestType=B&lstCounty=01&lstCntyNam=Alameda&lstDistrict=61176-000&lstDistNam=Fremont%20Unified%20School%20District&lstTestYear=2015

Notes for creating the xls file: Download the test data (CSV format) for year 2015 & 2016. Also download the Entity(schools) data and, the lookup tables Test and Subgroups data for each year. Add an Area N key to explain the various Area n scores in teh dataset.

Data Dictionary: The column names are self-explanatory in the data and can be seen when opened in Excel. Descriptions for the ‘Area n’ fields can be obtained at http://caaspp.cde.ca.gov/sb2016/UnderstandingCAASPPReports

Unique ID:  The columns ‘CountyCode + DistrictCode + SchoolCode + TestYear + SubgroupID + Grade + Test ID’ together form the primary key.
;

* setup environmental parameters;
%let inputDatasetURL =
https://github.com/stat6250/team-2_project1/CAASP_Test_Results_2015_2016.xlsx
;


* load raw CAASP dataset from GitHub repository for use in the DATA step;
filename CAASPtmp "%sysfunc(getoption(work))/caasptmp.xlsx";

PROC HTTP
    method="get" 
    url="http://github.com/stat6250/team-2_project1/raw/master/CAASP_Test_Results_2015_2016.xlsx" 
    out=CAASPtmp
    ;
run;



/*Import each of the worksheets from the XLSX files into SAS as a separate dataset*/
*CAASP Test Results 2015;
PROC IMPORT FILE=CAASPtmp  
OUT= WORK.CAASP_test_results_2015
DBMS=XLSX
REPLACE;
SHEET="CAASP Test Results 2015"; 
GETNAMES=YES;

;
RUN;


/*CAASP Test Results 2016*/
PROC IMPORT FILE = CAASPtmp 
OUT= WORK.CAASP_test_results_2016
DBMS=XLSX
REPLACE;
SHEET="CAASP Test Results 2016"; 
GETNAMES=YES;
RUN;


/*Test code worksheet*/
PROC IMPORT FILE = CAASPtmp 
OUT= WORK.Test
DBMS=XLSX
REPLACE;
SHEET="Test"; 
GETNAMES=YES;
RUN;


/*Subgroup code worksheet*/
PROC IMPORT FILE = CAASPtmp 
OUT= WORK.Subgroup
DBMS=XLSX
REPLACE;
SHEET="Subgroup"; 
GETNAMES=YES;
RUN;


/*AreaKey code worksheet*/
PROC IMPORT FILE = CAASPtmp 
OUT= WORK.AreaKey
DBMS=XLSX
REPLACE;
SHEET="AreaKey"; 
GETNAMES=YES;
RUN;


/*School code worksheet*/
PROC IMPORT FILE = CAASPtmp
OUT= WORK.School
DBMS=XLSX
REPLACE;
SHEET="School"; 
GETNAMES=YES;
RUN;


filename CAASPtmp clear; /*clear the fileref created for the 	    
                            			input xls file*/

/* Using Proc SQL, create an analytic dataset that will be used for each of the analysis
   questions. This query uses the SQL statement to combine(using UNION) data for years 2015 and 2016 
   and pulls in the subgroup, test, school name etc lookup worksheets to provide all
   necessary columns in a single dataset  named 'CAASP1516_analytic_file'. 
   Note to team 2: The analysis code files reference this dataset name in 
   PROC MEAN, PROC SORT.
*/

PROC SQL;
CREATE TABLE CAASP1516_analytic_file
AS
Select 
'Alameda County' as County, /* */
'Fremont Unified School District' as District_Name,
a.School_Code, e.School_name,
a.Test_Year,
a.Subgroup_ID, c.SubgroupDescription, c.SubgroupCategory,
a.Test_Type,
a.Total_CAASPP_Enrollment,
a.Total_Tested_At_Entity_Level,
a.Total_Tested_with_Scores,
a.Grade,
a.Test_Id,b.Test_Name,
a.CAASPP_Reported_Enrollment,
a.Students_Tested,
a.Mean_Scale_Score,
a.Percentage_Standard_Exceeded,
a.Percentage_Standard_Met,
/*a.Percentage_Standard_Met_and_Above as pcnt_met_and_above,*/
a.Percentage_Standard_Nearly_Met,
a.Percentage_Standard_Not_Met,
a.Students_with_Scores,
a.Area_1_Percentage_Above_Standard,
a.Area_1_Percentage_Near_Standard,
a.Area_1_Percentage_Below_Standard,
a.Area_2_Percentage_Above_Standard,
a.Area_2_Percentage_Near_Standard,
a.Area_2_Percentage_Below_Standard,
a.Area_3_Percentage_Above_Standard,
a.Area_3_Percentage_Near_Standard,
a.Area_3_Percentage_Below_Standard,
a.Area_4_Percentage_Above_Standard,
a.Area_4_Percentage_Near_Standard,
a.Area_4_Percentage_Below_Standard

from CAASP_Test_Results_2015 a,
     Test b,
     Subgroup c,
     AreaKey d,
     School e
Where a.test_id = b.test_id
and   a.subgroup_ID = c.subgroup_ID
and   a.school_code = e.school_code 

UNION

Select 
'Alameda County' as County, /* */
'Fremont Unified School District' as District_Name,
a.School_Code, e.School_name,
a.Test_Year,
a.Subgroup_ID, c.SubgroupDescription, c.SubgroupCategory,
a.Test_Type,
a.Total_CAASPP_Enrollment,
a.Total_Tested_At_Entity_Level,
a.Total_Tested_with_Scores,
a.Grade,
a.Test_Id,b.Test_Name,
a.CAASPP_Reported_Enrollment,
a.Students_Tested,
a.Mean_Scale_Score,
a.Percentage_Standard_Exceeded,
a.Percentage_Standard_Met,
/*a.Percentage_Standard_Met_and_Above as pcnt_met_and_above,*/
a.Percentage_Standard_Nearly_Met,
a.Percentage_Standard_Not_Met,
a.Students_with_Scores,
a.Area_1_Percentage_Above_Standard,
a.Area_1_Percentage_Near_Standard,
a.Area_1_Percentage_Below_Standard,
a.Area_2_Percentage_Above_Standard,
a.Area_2_Percentage_Near_Standard,
a.Area_2_Percentage_Below_Standard,
a.Area_3_Percentage_Above_Standard,
a.Area_3_Percentage_Near_Standard,
a.Area_3_Percentage_Below_Standard,
a.Area_4_Percentage_Above_Standard,
a.Area_4_Percentage_Near_Standard,
a.Area_4_Percentage_Below_Standard

from CAASP_Test_Results_2016 a,
     Test b,
     Subgroup c,
     AreaKey d,
     School e
Where a.test_id = b.test_id
and   a.subgroup_ID = c.subgroup_ID
and   a.school_code = e.school_code ;

PROC PRINT data = CAASP1516_analytic_file
;



QUIT;