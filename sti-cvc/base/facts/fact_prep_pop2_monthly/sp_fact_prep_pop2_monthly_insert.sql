USE emtct4;
GO

TRUNCATE TABLE base.fact_prep_pop2_monthly;

-- $BEGIN

WITH ci_prep_cte AS (
    SELECT
        TRIM(PARSENAME(REPLACE(cpp.categorization,',','.'),1)) AS age_group_prep,
        'MSM' AS risk_group,
        ci_prep_cnt_clients_engaged_msm AS clients_engaged_prep,
        ci_prep_cnt_willing_initiate_msm AS clients_willing_initiate,
        ci_prep_cnt_new_clients_initiated_msm AS clients_newly_initiated,
        ci_prep_cnt_reinitiated_msm AS clients_reinitiated,
        ci_prep_cnt_continued_msm AS clients_continued,
        ci_prep_cnt_hiv_pos_on_prep_msm AS clients_hiv_positive_during_period,
        ci_prep_cnt_sti_diagnosed_msm AS clients_sti_diagnosed_on_prep,
        cpp.startdate,
        cpp.facility_uid,
        cpp.categorization,
        dd.date_id,
        dl.location_id,
        ds.sex_id
    FROM staging.ci_prep_population cpp LEFT JOIN base.dim_date dd ON cpp.startdate = dd.report_date
    LEFT JOIN base.dim_location dl ON cpp.facility_uid = dl.location_uid
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(cpp.categorization,',','.'),2)) = ds.sex_code

    UNION ALL 
SELECT
        TRIM(PARSENAME(REPLACE(cpp.categorization,',','.'),1)) AS age_group_prep,
        'FSW' AS risk_group,
        ci_prep_cnt_engaged_fsw AS clients_engaged_prep,
        ci_prep_cnt_willing_initiate_fsw AS clients_willing_initiate,
        ci_prep_cnt_new_initiated_fsw AS clients_newly_initiated,
        ci_prep_cnt_reinitiated_fsw AS clients_reinitiated,
        ci_prep_cnt_continued_fsw AS clients_continued,
        ci_prep_cnt_hiv_pos_on_prep_fsw AS clients_hiv_positive_during_period,
        ci_prep_cnt_clients_sti_diagnosed_fsw AS clients_sti_diagnosed_on_prep,
        cpp.startdate,
        cpp.facility_uid,
        cpp.categorization,
        dd.date_id,
        dl.location_id,
        ds.sex_id
    FROM staging.ci_prep_population cpp LEFT JOIN base.dim_date dd ON cpp.startdate = dd.report_date
    LEFT JOIN base.dim_location dl ON cpp.facility_uid = dl.location_uid
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(cpp.categorization,',','.'),2)) = ds.sex_code

UNION ALL 

SELECT
        TRIM(PARSENAME(REPLACE(cpp.categorization,',','.'),1)) AS age_group_prep,
        'TG' AS risk_group,
        ci_prep_cnt_clients_engaged_tg AS clients_engaged_prep,
        ci_prep_cnt_willing_initiate_tg AS clients_willing_initiate,
        ci_prep_cnt_new_initiated_sd AS clients_newly_initiated,
        ci_prep_cnt_reinitiated_sd AS clients_reinitiated,
        ci_prep_cnt_continued_sd AS clients_continued,
        ci_prep_cnt_hiv_pos_on_prep_sd AS clients_hiv_positive_during_period,
        ci_prep_cnt_sti_diagnosed_sd AS clients_sti_diagnosed_on_prep,
        cpp.startdate,
        cpp.facility_uid,
        cpp.categorization,
        dd.date_id,
        dl.location_id,
        ds.sex_id
    FROM staging.ci_prep_population cpp LEFT JOIN base.dim_date dd ON cpp.startdate = dd.report_date
    LEFT JOIN base.dim_location dl ON cpp.facility_uid = dl.location_uid
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(cpp.categorization,',','.'),2)) = ds.sex_code
    

)
INSERT INTO base.fact_prep_pop1_monthly (
    date_id,
    location_id,
    sex_id,
    risk_group,
    age_group_prep,
    clients_engaged_prep,
    clients_willing_initiate,
    clients_commenced_prep_from_ci,
    clients_newly_initiated,
    clients_reinitiated,
    clients_continued,
    clients_hiv_positive_on_prep,
    clients_sti_diagnosed_on_prep

) 
SELECT 
    date_id,
    location_id,
    sex_id,
    risk_group,
    age_group_prep,
    clients_engaged_prep,
    clients_willing_initiate,
    clients_commenced_prep_from_ci,
    clients_newly_initiated,
    clients_reinitiated,
    clients_continued,
    clients_hiv_positive_on_prep,
    clients_sti_diagnosed_on_prep
FROM 
   ci_prep_cte; 
    
-- $END

