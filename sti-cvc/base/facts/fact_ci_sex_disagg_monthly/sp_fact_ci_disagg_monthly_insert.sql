USE emtct4;
GO

TRUNCATE TABLE base.fact_ci_general_monthly;

-- $BEGIN

WITH ci_general_cte AS (
    SELECT
        'New Syphilis P&S' AS condition_category,
        cgi.cnt_new_cases_reported_syphilis_ps AS new_cases_reported,
        cgi.ci_gi_cnt_new_cases_interviewed_syphilis_ps AS new_cases_interviewed,
        cgi.ci_gi_cnt_contacts_named_syphilis_ps AS contacts_named,
        cgi.cnt_contacts_locatable_syphilis_ps AS contacts_locatable,
        cgi.cnt_contacts_located_syphilis_ps AS contacts_located,
        cgi.ci_gi_cnt_contacts_tested_syphilis_ps AS contacts_tested,
        cgi.cnt_contacts_positive_syphilis_ps AS contacts_positive,
        cgi.ci_gi_cnt_contacts_prev_pos_syph_ps AS contacts_known_positive,
        cgi.ci_gi_cnt_new_hiv_syph_ps AS positive_contacts_newly_diagnosed,
        cgi.startdate,
        cgi.facility_uid,
        cgi.categorization,
        dd.date_id,
        dl.location_id,
        ds.sex_id
    FROM staging.ci_general_indicators cgi LEFT JOIN base.dim_date dd ON cgi.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON cgi.facility_uid = dl.location_uid
    LEFT JOIN base.dim_sex ds ON cgi.categorization = ds.sex_code

    UNION ALL 

    SELECT
        'New Syphilis SEL' AS condition_category,
        cgi.ci_gi_cnt_new_cases_reported_syphilis_sel AS new_cases_reported,
        cgi.new_new_cases_interviewed_syphilis_sel AS new_cases_interviewed,
        cgi.cnt_contacts_named_syphilis_sel AS contacts_named,
        cgi.ci_gi_cnt_contacts_locatable_syphilis_sel AS contacts_locatable,
        cgi.cnt_contacts_located_syphilis_sel AS contacts_located,
        cgi.ci_gi_cnt_contacts_tested_syphilis_sel AS contacts_tested,
        cgi.ci_gi_cnt_contacts_positive_syphilis_sel AS contacts_positive,
        cgi.ci_gi_cnt_contacts_prev_pos_syph_sel AS contacts_known_positive,
        cgi.ci_gi_cnt_new_hiv_syph_sel AS positive_contacts_newly_diagnosed,
        cgi.startdate,
        cgi.facility_uid,
        cgi.categorization,
        dd.date_id,
        dl.location_id,
        ds.sex_id
    FROM staging.ci_general_monthly cgi LEFT JOIN base.dim_date dd ON cgi.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON cgi.facility_uid = dl.location_uid
    LEFT JOIN base.dim_sex ds ON cgi.categorization = ds.sex_code

    UNION ALL

    SELECT
        'New HIV' AS condition_category,
        cgi.ci_gi_cnt_new_cases_reported_hiv AS new_cases_reported,
        cgi.cnt_new_cases_interviewed_hiv AS new_cases_interviewed,
        cgi.ci_gi_cnt_contacts_named_hiv AS contacts_named,
        cgi.cnt_contacts_locatable_hiv AS contacts_locatable,
        cgi.ci_gi_cnt_contacts_located_hiv AS contacts_located,
        cgi.cnt_contacts_tested_examined_hiv AS contacts_tested,
        cgi.ci_gi_cnt_contacts_positive_hiv AS contacts_positive,
        cgi.ci_gi_cnt_contacts_prev_pos_hiv AS contacts_known_positive,
        cgi.ci_gi_cnt_new_hiv_hiv AS positive_contacts_newly_diagnosed,
        cgi.startdate,
        cgi.facility_uid,
        cgi.categorization,
        dd.date_id,
        dl.location_id,
        ds.sex_id
    FROM staging.ci_general_monthly cgi LEFT JOIN base.dim_date dd ON cgi.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON cgi.facility_uid = dl.location_uid
    LEFT JOIN base.dim_sex ds ON cgi.categorization = ds.sex_code

 UNION ALL

    SELECT
        'New AIDS' AS condition_category,
        cgi.cnt_new_cases_reported_aids AS new_cases_reported,
        cgi.ci_gi_cnt_new_cases_interviewed_aids AS new_cases_interviewed,
        cgi.cnt_contacts_named_aids AS contacts_named,
        cgi.ci_gi_cnt_contacts_locatable_aids AS contacts_locatable,
        cgi.cnt_contacts_located_aids AS contacts_located,
        cgi.cnt_contacts_tested_examined_aids AS contacts_tested,
        cgi.ci_gi_cnt_contacts_positive_aids AS contacts_positive,
        cgi.ci_gi_cnt_contacts_prev_pos_aids AS contacts_known_positive,
        cgi.ci_gi_cnt_new_hiv_aids AS positive_contacts_newly_diagnosed,
        cgi.startdate,
        cgi.facility_uid,
        cgi.categorization,
        dd.date_id,
        dl.location_id,
        ds.sex_id
    FROM staging.ci_general_monthly cgi LEFT JOIN base.dim_date dd ON cgi.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON cgi.facility_uid = dl.location_uid
    LEFT JOIN base.dim_sex ds ON cgi.categorization = ds.sex_code

 UNION ALL

    SELECT
        'HIV/AIDS Surveillance' AS condition_category,
        cgi.ci_gi_cnt_new_cases_reported_surv AS new_cases_reported,
        cgi.cnt_new_cases_interviewed_hiv_surv AS new_cases_interviewed,
        cgi.ci_gi_cnt_contacts_named_surv AS contacts_named,
        cgi.ci_gi_cnt_contacts_locatable_surv AS contacts_locatable,
        cgi.ci_gi_cnt_contacts_located_surv AS contacts_located,
        cgi.ci_gi_cnt_contacts_tested_surv AS contacts_tested,
        cgi.ci_gi_cnt_contacts_pos_surv AS contacts_positive,
        cgi.ci_gi_cnt_contacts_prev_pos_surv AS contacts_known_positive,
        cgi.ci_gi_cnt_contacts_new_hiv_pos_surv AS positive_contacts_newly_diagnosed,
        cgi.startdate,
        cgi.facility_uid,
        cgi.categorization,
        dd.date_id,
        dl.location_id,
        ds.sex_id
    FROM staging.ci_general_monthly cgi LEFT JOIN base.dim_date dd ON cgi.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON cgi.facility_uid = dl.location_uid
    LEFT JOIN base.dim_sex ds ON cgi.categorization = ds.sex_code

UNION ALL

    SELECT
        'AIDS Deaths' AS condition_category,
        cgi.cnt_new_cases_reported_aids_deaths AS new_cases_reported,
        cgi.cnt_new_cases_interviewed_aids_deaths AS new_cases_interviewed,
        cgi.ci_gi_cnt_contacts_named_aids_death AS contacts_named,
        cgi.cnt_contacts_locatable_aids_death AS contacts_locatable,
        cgi.ci_gi_cnt_contacts_located_aids_death AS contacts_located,
        cgi.cnt_contacts_tested_examined_aids_death AS contacts_tested,
        cgi.cnt_contacts_positive_aids_death AS contacts_positive,
        cgi.ci_gi_cnt_contacts_prev_pos_aidsdeath AS contacts_known_positive,
        cgi.ci_gi_cnt_contacts_new_hiv_pos_aids_death AS positive_contacts_newly_diagnosed,
        cgi.startdate,
        cgi.facility_uid,
        cgi.categorization,
        dd.date_id,
        dl.location_id,
        ds.sex_id
    FROM staging.ci_general_monthly cgi LEFT JOIN base.dim_date dd ON cgi.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON cgi.facility_uid = dl.location_uid
    LEFT JOIN base.dim_sex ds ON cgi.categorization = ds.sex_code


)
INSERT INTO base.fact_sti_cases_monthly (
    date_id,
    location_id,
    sex_id,
    condition_category,
    new_cases_reported,
    new_cases_interviewed,
    contacts_named,
    contacts_locatable,
    contacts_located,
    contacts_tested,
    contacts_positive,
    contacts_known_positive,
    positive_contacts_newly_diagnosed

) 
SELECT 
    date_id,
    location_id,
    sex_id,
    condition_category,
    new_cases_reported,
    new_cases_interviewed,
    contacts_named,
    contacts_locatable,
    contacts_located,
    contacts_tested,
    contacts_positive,
    contacts_known_positive,
    positive_contacts_newly_diagnosed
FROM 
   ci_general_cte; 
    
-- $END

