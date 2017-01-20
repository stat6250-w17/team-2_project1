*******************************************************************************;

* 
This file prepares the dataset described below for analysis.
Dataset Name: CAASP Test Results for English language arts/literacy and Mathematics for Alameda county for years 2015 and 2016 (2 separate datasets)

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
filename CAASPtemp TEMP;
proc http
    method="get" 
    url="&inputDatasetURL." 
    out=CAASPtemp
    ;
run;
proc import
    file=CAASPtemp
    out=CAASP1516_raw
    dbms=xls
    ;
run;
filename CAASPtemp clear;

* check raw CAASP dataset for duplicates with respect to its composite key;
proc sort nodupkey data=CAASP1516_raw dupout=CAASP1516_raw_dups out=_null_;
    by CountyCode   DistrictCode   SchoolCode   TestYear   SubgroupID   Grade   Test ID;
run;


* Create analytic dataset template from CAASP xls, by pulling test and subgroup descriptions into a single dataset to be used for analysis;
data CAASP1516_analytic_file;
    retain
/*list order of columns - to be completed*/
    ;
    keep
/* Select columns for the analytics dataset - to be completed*/
    ;
    set CAASP1516_raw;
run;

