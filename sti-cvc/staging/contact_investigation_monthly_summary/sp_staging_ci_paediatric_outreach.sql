USE emtct4;
GO


-- DROP the staging.ci_paediatric_outreach  table with pivoted data
DROP TABLE IF EXISTS staging.ci_paediatric_outreach;

-- $BEGIN

DECLARE 
    @sql     NVARCHAR(MAX) = '';

-- Drop Temporary table if exists
DROP TABLE IF EXISTS #temp_ci_paediatric_outreach;

-- Create a Temp table for the Contact Investigator Paediatric and Otreach Indicators Data
-- group_row_id identifies a row within a group
SELECT cpo.*, cnm.column_name, CAST(NULL AS VARCHAR(100)) AS group_row_name
INTO #temp_ci_paediatric_outreach
FROM staging.vw_ci_paediatric_outreach cpo
JOIN [external].column_name_mappings cnm ON cpo.dataelementid = cnm.dataelementid;


-- Update the group_row_name
UPDATE #temp_ci_paediatric_outreach
SET 
	group_row_name = (
		CASE WHEN categorization = 'Congenital Syphilis' AND column_name = 'cnt_new_cases_reported' THEN 'cs_cnt_new_cases_reported'
			WHEN categorization = 'Congenital Syphilis' AND column_name = 'ci_pi_cnt_cases_investigated' THEN 'cs_ci_pi_cnt_cases_investigated'
			WHEN categorization = 'Congenital Syphilis' AND column_name = 'cnt_cases_closed' THEN 'cs_cnt_cases_closed'
			WHEN categorization = 'Ophthalmia Neonatorum' AND column_name = 'cnt_new_cases_reported' THEN 'on_cnt_new_cases_reported'
			WHEN categorization = 'Ophthalmia Neonatorum' AND column_name = 'ci_pi_cnt_cases_investigated' THEN 'on_ci_pi_cnt_cases_investigated'
			WHEN categorization = 'Ophthalmia Neonatorum' AND column_name = 'cnt_cases_closed' THEN 'on_cnt_cases_closed'
			WHEN categorization = 'Paediatric HIV Exposed' AND column_name = 'cnt_new_cases_reported' THEN 'hei_cnt_new_cases_reported'
			WHEN categorization = 'Paediatric HIV Exposed' AND column_name = 'ci_pi_cnt_cases_investigated' THEN 'hei_ci_pi_cnt_cases_investigated'
			WHEN categorization = 'Paediatric HIV Exposed' AND column_name = 'cnt_cases_closed' THEN 'hei_cnt_cases_closed'

			WHEN categorization = 'No. Done' AND column_name = 'group_counselling_sessions' THEN 'group_counselling_sessions_done'
			WHEN categorization = 'No. Done' AND column_name = 'individual_counselling_sessions' THEN 'individual_counselling_sessions_done'
			WHEN categorization = 'No. Done' AND column_name = 'targeted_outreach_sessions' THEN 'targeted_outreach_sessions_done'
			WHEN categorization = 'No. Done' AND column_name = 'ci_field_visits' THEN 'ci_field_visits_done'

			WHEN categorization = 'Persons Reached' AND column_name = 'group_counselling_sessions' THEN 'group_counselling_sessions_persons_reached'
			WHEN categorization = 'Persons Reached' AND column_name = 'individual_counselling_sessions' THEN 'individual_counselling_sessions_persons_reached'
			WHEN categorization = 'Persons Reached' AND column_name = 'targeted_outreach_sessions' THEN 'targeted_outreach_sessions_persons_reached'
			WHEN categorization = 'Persons Reached' AND column_name = 'ci_field_visits' THEN 'ci_field_visits_done_persons_reached'

		END
	);

-- Create a multi-column index on the Temp table
CREATE INDEX idx_multi_temp_ci_paediatric_indicator ON #temp_ci_paediatric_outreach
    (
    periodid, 
    organisationunitid,
    attributeoptioncomboid,
    datasetid,
    startdate,
    facility_uid
    );

    -- construct dynamic SQL
SET @sql ='
SELECT * INTO staging.ci_paediatric_outreach FROM   
(
SELECT 
    periodid,
    organisationunitid,
    attributeoptioncomboid,
    datasetid,
	startdate,
	facility_uid,
	MAX(CASE WHEN group_row_name = ''cs_cnt_new_cases_reported'' THEN value END) AS cs_cnt_new_cases_reported,
    MAX(CASE WHEN group_row_name = ''cs_ci_pi_cnt_cases_investigated'' THEN value END) AS cs_ci_pi_cnt_cases_investigated,
	MAX(CASE WHEN group_row_name = ''cs_cnt_cases_closed'' THEN value END) AS cs_cnt_cases_closed,
	MAX(CASE WHEN group_row_name = ''on_cnt_new_cases_reported'' THEN value END) AS on_cnt_new_cases_reported,
	MAX(CASE WHEN group_row_name = ''on_ci_pi_cnt_cases_investigated'' THEN value END) AS on_ci_pi_cnt_cases_investigated,
	MAX(CASE WHEN group_row_name = ''on_cnt_cases_closed'' THEN value END) AS on_cnt_cases_closed,
	MAX(CASE WHEN group_row_name = ''hei_cnt_new_cases_reported'' THEN value END) AS hei_cnt_new_cases_reported,
	MAX(CASE WHEN group_row_name = ''hei_ci_pi_cnt_cases_investigated'' THEN value END) AS hei_ci_pi_cnt_cases_investigated,
	MAX(CASE WHEN group_row_name = ''hei_cnt_cases_closed'' THEN value END) AS hei_cnt_cases_closed,
	MAX(CASE WHEN group_row_name = ''group_counselling_sessions_done'' THEN value END) AS group_counselling_sessions_done,
	MAX(CASE WHEN group_row_name = ''individual_counselling_sessions_done'' THEN value END) AS individual_counselling_sessions_done,
	MAX(CASE WHEN group_row_name = ''targeted_outreach_sessions_done'' THEN value END) AS targeted_outreach_sessions_done,
	MAX(CASE WHEN group_row_name = ''ci_field_visits_done'' THEN value END) AS ci_field_visits_done,
	MAX(CASE WHEN group_row_name = ''group_counselling_sessions_persons_reached'' THEN value END) AS group_counselling_sessions_persons_reached,
	MAX(CASE WHEN group_row_name = ''individual_counselling_sessions_persons_reached'' THEN value END) AS individual_counselling_sessions_persons_reached,
	MAX(CASE WHEN group_row_name = ''targeted_outreach_sessions_persons_reached'' THEN value END) AS targeted_outreach_sessions_persons_reached,
	MAX(CASE WHEN group_row_name = ''ci_field_visits_done_persons_reached'' THEN value END) AS ci_field_visits_done_persons_reached

FROM #temp_ci_paediatric_outreach
GROUP BY 
    periodid,
    organisationunitid,
    attributeoptioncomboid,
    datasetid,
	startdate,
	facility_uid
) AS t'

-- execute the dynamic SQL
EXECUTE sp_executesql @sql;

DROP TABLE IF EXISTS #temp_ci_paediatric_outreach;

-- $END
