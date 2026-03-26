USE emtct4;
GO

-- DROP the staging.sti_monthly_summary  table with pivoted data
DROP TABLE IF EXISTS staging.sti_monthly_summary;

-- $BEGIN

DECLARE 
    @columns NVARCHAR(MAX) = '', 
    @sql     NVARCHAR(MAX) = '';

-- Drop Temporary table if exists
DROP TABLE IF EXISTS #temp_sti_monthly_summary;

-- Create a Temp table for the STI Monthly Summary Data
SELECT sms.*, cnm.column_name
INTO #temp_sti_monthly_summary
FROM staging.vw_sti_monthly_summary sms
JOIN [external].column_name_mappings cnm ON sms.dataelementid = cnm.dataelementid;

-- Create a multi-column index on the Temp table
CREATE INDEX idx_multi_temp_sti_monthly_summary ON #temp_sti_monthly_summary
    (
    periodid, 
    organisationunitid,
    categoryoptioncomboid,
    attributeoptioncomboid,
    datasetid,
    categorization,
    startdate,
    facility_uid
    );
-- select the column names
SELECT 
    @columns+=QUOTENAME(column_name) + ','
FROM (
    SELECT DISTINCT column_name
    FROM #temp_sti_monthly_summary
) t
ORDER BY 
    column_name;

-- remove the last comma
SET @columns = LEFT(@columns, LEN(@columns) - 1);

-- construct dynamic SQL
SET @sql ='
SELECT * INTO staging.sti_monthly_summary FROM   
(
    SELECT 
        periodid, 
        organisationunitid,
        categoryoptioncomboid,
        attributeoptioncomboid,
        datasetid,
	    categorization,
	    startdate,
	    facility_uid
        column_name,
        value 
    FROM 
        #temp_sti_monthly_summary
) t 
PIVOT(
    MAX(value) 
    FOR column_name IN ('+ @columns +')
) AS pivot_table;';

-- execute the dynamic SQL
EXECUTE sp_executesql @sql;

DROP TABLE IF EXISTS #temp_sti_monthly_summary;

-- $END