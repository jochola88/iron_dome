USE emtct4;
GO


-- DROP the staging.ci_prep_population  table with pivoted data
DROP TABLE IF EXISTS staging.ci_prep_population;

-- $BEGIN

DECLARE  
    @sql     NVARCHAR(MAX) = '';

-- Drop Temporary table if exists
DROP TABLE IF EXISTS #temp_ci_prep_population;

-- Create a Temp table for the Contact Investigation PrEP Indicators Data
SELECT cis.*, cnm.column_name
INTO #temp_ci_prep_population
FROM staging.vw_ci_prep_population_indicators cis
JOIN [external].column_name_mappings cnm ON cis.dataelementid = cnm.dataelementid;

-- Create a multi-column index on the Temp table
CREATE INDEX idx_multi_temp_ci_prep_population ON #temp_ci_prep_population
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

    -- construct dynamic SQL
SET @sql ='
SELECT * INTO staging.ci_prep_population FROM   
(
SELECT 
    periodid,
    organisationunitid,
    categoryoptioncomboid,
    attributeoptioncomboid,
    datasetid,
	categorization,
	startdate,
	facility_uid,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_engaged_fsw'' THEN value END) AS ci_prep_cnt_engaged_fsw,
    MAX(CASE WHEN column_name = ''ci_prep_cnt_clients_engaged_msp'' THEN value END) AS ci_prep_cnt_clients_engaged_msp,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_hiv_pos_on_prep_sd'' THEN value END) AS ci_prep_cnt_hiv_pos_on_prep_sd,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_clients_engaged_tg'' THEN value END) AS ci_prep_cnt_clients_engaged_tg,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_willing_initiate_tg'' THEN value END) AS ci_prep_cnt_willing_initiate_tg,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_continued_fsw'' THEN value END) AS ci_prep_cnt_continued_fsw,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_hiv_pos_on_prep_fsw'' THEN value END) AS ci_prep_cnt_hiv_pos_on_prep_fsw,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_clients_engaged_hsti'' THEN value END) AS ci_prep_cnt_clients_engaged_hsti,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_commenced_from_engaged_hsti'' THEN value END) AS ci_prep_cnt_commenced_from_engaged_hsti,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_commenced_from_engaged_msp'' THEN value END) AS ci_prep_cnt_commenced_from_engaged_msp,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_clients_engaged_sd'' THEN value END) AS ci_prep_cnt_clients_engaged_sd,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_willing_initiate_sd'' THEN value END) AS ci_prep_cnt_willing_initiate_sd,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_new_initiated_hsti'' THEN value END) AS ci_prep_cnt_new_initiated_hsti,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_new_initiated_sd'' THEN value END) AS ci_prep_cnt_new_initiated_sd,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_reinitiated_sd'' THEN value END) AS ci_prep_cnt_reinitiated_sd,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_willing_initiate_hsti'' THEN value END) AS ci_prep_cnt_willing_initiate_hsti,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_willing_initiate_msp'' THEN value END) AS ci_prep_cnt_willing_initiate_msp,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_reinitiated_msp'' THEN value END) AS ci_prep_cnt_reinitiated_msp,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_continued_hsti'' THEN value END) AS ci_prep_cnt_continued_hsti,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_continued_msp'' THEN value END) AS ci_prep_cnt_continued_msp,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_sti_diagnosed_hsti'' THEN value END) AS ci_prep_cnt_sti_diagnosed_hsti,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_sti_diagnosed_msp'' THEN value END) AS ci_prep_cnt_sti_diagnosed_msp,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_commenced_from_engaged_sd'' THEN value END) AS ci_prep_cnt_commenced_from_engaged_sd,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_new_initiated_msp'' THEN value END) AS ci_prep_cnt_new_initiated_msp,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_reinitiated_msm'' THEN value END) AS ci_prep_cnt_reinitiated_msm,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_reinitiated_fsw'' THEN value END) AS ci_prep_cnt_reinitiated_fsw,
    MAX(CASE WHEN column_name = ''ci_prep_cnt_reinitiated_hsti'' THEN value END) AS ci_prep_cnt_reinitiated_hsti,
    MAX(CASE WHEN column_name = ''ci_prep_cnt_hiv_pos_on_prep_hsti'' THEN value END) AS ci_prep_cnt_hiv_pos_on_prep_hsti,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_hiv_pos_on_prep_msp'' THEN value END) AS ci_prep_cnt_hiv_pos_on_prep_msp,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_sti_diagnosed_sd'' THEN value END) AS ci_prep_cnt_sti_diagnosed_sd,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_new_initiated_fsw'' THEN value END) AS ci_prep_cnt_new_initiated_fsw,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_reinitiated_tg'' THEN value END) AS ci_prep_cnt_reinitiated_tg,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_continued_msm'' THEN value END) AS ci_prep_cnt_continued_msm,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_continued_tg'' THEN value END) AS ci_prep_cnt_continued_tg,
    MAX(CASE WHEN column_name = ''ci_prep_cnt_sti_diagnosed_msm'' THEN value END) AS ci_prep_cnt_sti_diagnosed_msm,
    MAX(CASE WHEN column_name = ''ci_prep_cnt_sti_diagnosed_tg'' THEN value END) AS ci_prep_cnt_sti_diagnosed_tg,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_continued_sd'' THEN value END) AS ci_prep_cnt_continued_sd,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_clients_engaged_msm'' THEN value END) AS ci_prep_cnt_clients_engaged_msm,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_willing_initiate_msm'' THEN value END) AS ci_prep_cnt_willing_initiate_msm,
    MAX(CASE WHEN column_name = ''ci_prep_cnt_willing_initiate_fsw'' THEN value END) AS ci_prep_cnt_willing_initiate_fsw,
    MAX(CASE WHEN column_name = ''ci_prep_cnt_new_initiated_tg'' THEN value END) AS ci_prep_cnt_new_initiated_tg,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_hiv_pos_on_prep_msm'' THEN value END) AS ci_prep_cnt_hiv_pos_on_prep_msm,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_new_clients_initiated_msm'' THEN value END) AS ci_prep_cnt_new_clients_initiated_msm,
	MAX(CASE WHEN column_name = ''ci_prep_cnt_clients_hiv_positive_tg'' THEN value END) AS ci_prep_cnt_clients_hiv_positive_tg,
    MAX(CASE WHEN column_name = ''ci_prep_cnt_clients_sti_diagnosed_fsw'' THEN value END) AS ci_prep_cnt_clients_sti_diagnosed_fsw

FROM #temp_ci_prep_population
GROUP BY 
    periodid,
    organisationunitid,
    categoryoptioncomboid,
    attributeoptioncomboid,
    datasetid,
	categorization,
	startdate,
	facility_uid
) AS t'

-- execute the dynamic SQL
EXECUTE sp_executesql @sql;

DROP TABLE IF EXISTS #temp_ci_prep_population;

-- $END
