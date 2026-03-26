USE emtct4;
GO

-- DROP the staging.emtct_monthly_report  table with pivoted data
DROP TABLE IF EXISTS staging.emtct_monthly_report;


-- $BEGIN

DECLARE 
    @columns NVARCHAR(MAX) = '', 
    @sql     NVARCHAR(MAX) = '';

-- Drop Temporary table if exists
DROP TABLE IF EXISTS #temp_emtct_monthly_report;

-- Create a Temp table for the EMTCT Monthly Report Data
SELECT emr.*, cnm.column_name
INTO #temp_emtct_monthly_report
FROM staging.vw_emtct_monthly_report emr
JOIN [external].column_name_mappings cnm ON emr.dataelementid = cnm.dataelementid;

-- Create a multi-column index on the Temp table
CREATE INDEX idx_multi_temp_emtct_monthly_report ON #temp_emtct_monthly_report
    (
    periodid, 
    organisationunitid,
    categoryoptioncomboid,
    attributeoptioncomboid,
    datasetid
    );

-- select the column names
SELECT 
    @columns+=QUOTENAME(column_name) + ','
FROM (
    SELECT DISTINCT column_name
    FROM #temp_emtct_monthly_report
) t
ORDER BY 
    column_name;

-- remove the last comma
SET @columns = LEFT(@columns, LEN(@columns) - 1);

-- construct dynamic SQL
SET @sql ='
SELECT * INTO staging.emtct_monthly_report FROM   
(
    SELECT 
        periodid, 
        organisationunitid,
        categoryoptioncomboid,
        attributeoptioncomboid,
        datasetid,
        column_name,
        value 
    FROM 
        #temp_emtct_monthly_report
) t 
PIVOT(
    MAX(value) 
    FOR column_name IN ('+ @columns +')
) AS pivot_table;';

-- execute the dynamic SQL
EXECUTE sp_executesql @sql;

DROP TABLE IF EXISTS #temp_emtct_monthly_report;

-- $END