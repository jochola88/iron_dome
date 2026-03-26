USE emtct4;
GO


-- DROP the staging.contact_investigator_monthly_summary  table with pivoted data
DROP TABLE IF EXISTS staging.contact_investigator_monthly_summary;

-- $BEGIN

DECLARE 
    @columns NVARCHAR(MAX) = '', 
    @sql     NVARCHAR(MAX) = '';

-- Drop Temporary table if exists
DROP TABLE IF EXISTS #temp_contact_investigator_monthly_summary;

-- Create a Temp table for the Contact Investigator Data
SELECT cis.*, cnm.column_name
INTO #temp_contact_investigator_monthly_summary
FROM staging.vw_contact_investigator_monthly_summary cis
JOIN [external].column_name_mappings cnm ON cis.dataelementid = cnm.dataelementid;

-- Create a multi-column index on the Temp table
CREATE INDEX idx_multi_temp_contact_investigator_monthly_summary ON #temp_contact_investigator_monthly_summary
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
    FROM #temp_contact_investigator_monthly_summary
) t
ORDER BY 
    column_name;

-- remove the last comma
SET @columns = LEFT(@columns, LEN(@columns) - 1);

-- construct dynamic SQL
SET @sql ='
SELECT * INTO staging.contact_investigator_monthly_summary FROM   
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
        #temp_contact_investigator_monthly_summary
) t 
PIVOT(
    MAX(value) 
    FOR column_name IN ('+ @columns +')
) AS pivot_table;';

-- execute the dynamic SQL
EXECUTE sp_executesql @sql;

DROP TABLE IF EXISTS #temp_contact_investigator_monthly_summary;

-- $END
