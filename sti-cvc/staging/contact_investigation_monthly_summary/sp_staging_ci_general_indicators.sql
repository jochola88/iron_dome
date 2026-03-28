USE emtct4;
GO


-- DROP the staging.ci_general_indicators  table with pivoted data
DROP TABLE IF EXISTS staging.ci_general_indicators;

-- $BEGIN

DECLARE 
    -- @columns NVARCHAR(MAX) = '', 
    @sql     NVARCHAR(MAX) = '';

-- Drop Temporary table if exists
DROP TABLE IF EXISTS #temp_ci_general_indicators;

-- Create a Temp table for the Contact Investigator General Indicators Data
SELECT cis.*, cnm.column_name
INTO #temp_ci_general_indicators
FROM staging.vw_ci_general_indicators cis
JOIN [external].column_name_mappings cnm ON cis.dataelementid = cnm.dataelementid;

-- Create a multi-column index on the Temp table
CREATE INDEX idx_multi_temp_ci_general_indicators ON #temp_ci_general_indicators
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
SELECT * INTO staging.ci_general_indicators FROM   
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
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_locatable_aids'' THEN value END) AS ci_gi_cnt_contacts_locatable_aids,
    MAX(CASE WHEN column_name = ''ci_gi_cnt_new_cases_reported_surv'' THEN value END) AS ci_gi_cnt_new_cases_reported_surv,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_tested_surv'' THEN value END) AS ci_gi_cnt_contacts_tested_surv,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_prev_pos_aids'' THEN value END) AS ci_gi_cnt_contacts_prev_pos_aids,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_named_surv'' THEN value END) AS ci_gi_cnt_contacts_named_surv,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_located_surv'' THEN value END) AS ci_gi_cnt_contacts_located_surv,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_prev_pos_aidsdeath'' THEN value END) AS ci_gi_cnt_contacts_prev_pos_aidsdeath,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_locatable_surv'' THEN value END) AS ci_gi_cnt_contacts_locatable_surv,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_prev_pos_hiv'' THEN value END) AS ci_gi_cnt_contacts_prev_pos_hiv,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_new_hiv_syph_sel'' THEN value END) AS ci_gi_cnt_new_hiv_syph_sel,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_new_hiv_hiv'' THEN value END) AS ci_gi_cnt_new_hiv_hiv,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_pos_surv'' THEN value END) AS ci_gi_cnt_contacts_pos_surv,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_prev_pos_syph_ps'' THEN value END) AS ci_gi_cnt_contacts_prev_pos_syph_ps,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_prev_pos_syph_sel'' THEN value END) AS ci_gi_cnt_contacts_prev_pos_syph_sel,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_prev_pos_surv'' THEN value END) AS ci_gi_cnt_contacts_prev_pos_surv,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_new_hiv_syph_ps'' THEN value END) AS ci_gi_cnt_new_hiv_syph_ps,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_new_hiv_aids'' THEN value END) AS ci_gi_cnt_new_hiv_aids,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_new_hiv_pos_surv'' THEN value END) AS ci_gi_cnt_contacts_new_hiv_pos_surv,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_new_hiv_pos_aids_death'' THEN value END) AS ci_gi_cnt_contacts_new_hiv_pos_aids_death,
	MAX(CASE WHEN column_name = ''cnt_new_cases_interviewed_hiv_surv'' THEN value END) AS cnt_new_cases_interviewed_hiv_surv,
	MAX(CASE WHEN column_name = ''cnt_contacts_locatable_aids_death'' THEN value END) AS cnt_contacts_locatable_aids_death,
	MAX(CASE WHEN column_name = ''cnt_contacts_locatable_hiv'' THEN value END) AS cnt_contacts_locatable_hiv,
	MAX(CASE WHEN column_name = ''cnt_new_cases_interviewed_aids_deaths'' THEN value END) AS cnt_new_cases_interviewed_aids_deaths,
	MAX(CASE WHEN column_name = ''cnt_new_cases_interviewed_hiv'' THEN value END) AS cnt_new_cases_interviewed_hiv,
	MAX(CASE WHEN column_name = ''cnt_new_cases_reported_aids'' THEN value END) AS cnt_new_cases_reported_aids,
	MAX(CASE WHEN column_name = ''cnt_new_cases_reported_syphilis_ps'' THEN value END) AS cnt_new_cases_reported_syphilis_ps,
    MAX(CASE WHEN column_name = ''cnt_contacts_named_syphilis_sel'' THEN value END) AS cnt_contacts_named_syphilis_sel,
    MAX(CASE WHEN column_name = ''cnt_contacts_tested_examined_hiv'' THEN value END) AS cnt_contacts_tested_examined_hiv,
	MAX(CASE WHEN column_name = ''cnt_contacts_locatable_syphilis_ps'' THEN value END) AS cnt_contacts_locatable_syphilis_ps,
	MAX(CASE WHEN column_name = ''cnt_contacts_tested_examined_aids_death'' THEN value END) AS cnt_contacts_tested_examined_aids_death,
	MAX(CASE WHEN column_name = ''cnt_contacts_located_syphilis_ps'' THEN value END) AS cnt_contacts_located_syphilis_ps,
	MAX(CASE WHEN column_name = ''cnt_contacts_tested_examined_aids'' THEN value END) AS cnt_contacts_tested_examined_aids,
	MAX(CASE WHEN column_name = ''cnt_new_cases_reported_aids_deaths'' THEN value END) AS cnt_new_cases_reported_aids_deaths,
	MAX(CASE WHEN column_name = ''new_new_cases_interviewed_syphilis_sel'' THEN value END) AS new_new_cases_interviewed_syphilis_sel,
    MAX(CASE WHEN column_name = ''cnt_contacts_positive_aids_death'' THEN value END) AS cnt_contacts_positive_aids_death,
    MAX(CASE WHEN column_name = ''cnt_contacts_positive_syphilis_ps'' THEN value END) AS cnt_contacts_positive_syphilis_ps,
	MAX(CASE WHEN column_name = ''cnt_contacts_named_aids'' THEN value END) AS cnt_contacts_named_aids,
	MAX(CASE WHEN column_name = ''cnt_contacts_located_aids'' THEN value END) AS cnt_contacts_located_aids,
	MAX(CASE WHEN column_name = ''cnt_contacts_located_syphilis_sel'' THEN value END) AS cnt_contacts_located_syphilis_sel,
    MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_located_aids_death'' THEN value END) AS ci_gi_cnt_contacts_located_aids_death,
    MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_locatable_syphilis_sel'' THEN value END) AS ci_gi_cnt_contacts_locatable_syphilis_sel,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_named_aids_death'' THEN value END) AS ci_gi_cnt_contacts_named_aids_death,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_new_cases_reported_hiv'' THEN value END) AS ci_gi_cnt_new_cases_reported_hiv,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_positive_syphilis_sel'' THEN value END) AS ci_gi_cnt_contacts_positive_syphilis_sel,
    MAX(CASE WHEN column_name = ''ci_gi_cnt_new_cases_reported_syphilis_sel'' THEN value END) AS ci_gi_cnt_new_cases_reported_syphilis_sel,
    MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_tested_syphilis_sel'' THEN value END) AS ci_gi_cnt_contacts_tested_syphilis_sel,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_located_hiv'' THEN value END) AS ci_gi_cnt_contacts_located_hiv,
	MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_tested_syphilis_ps'' THEN value END) AS ci_gi_cnt_contacts_tested_syphilis_ps,
    MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_named_syphilis_ps'' THEN value END) AS ci_gi_cnt_contacts_named_syphilis_ps,
    MAX(CASE WHEN column_name = ''ci_gi_cnt_new_cases_interviewed_aids'' THEN value END) AS ci_gi_cnt_new_cases_interviewed_aids,
    MAX(CASE WHEN column_name = ''ci_gi_cnt_new_cases_interviewed_syphilis_ps'' THEN value END) AS ci_gi_cnt_new_cases_interviewed_syphilis_ps,
    MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_positive_hiv'' THEN value END) AS ci_gi_cnt_contacts_positive_hiv,
    MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_positive_aids'' THEN value END) AS ci_gi_cnt_contacts_positive_aids,
    MAX(CASE WHEN column_name = ''ci_gi_cnt_contacts_named_hiv'' THEN value END) AS ci_gi_cnt_contacts_named_hiv
FROM #temp_sti_monthly_summary
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

DROP TABLE IF EXISTS #temp_ci_general_indicators;

-- $END
