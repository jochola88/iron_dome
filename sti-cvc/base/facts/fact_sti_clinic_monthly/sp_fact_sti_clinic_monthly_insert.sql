USE emtct4;
GO

TRUNCATE TABLE base.fact_sti_clinic_monthly;

-- $BEGIN

WITH sti_clinic_cte AS (
        sms.sti_clinic_attendees AS sti_attendees,
        sms.sti_clinic_new_attendees AS new_sti_attendees,
        sms.sti_clinic_tested_hiv AS attendees_tested_hiv,
        sms.sti_clinic_tested_syph AS attendees_tested_syphilis,
        sms.sti_clinic_new_hiv_diag AS attendees_newly_diagnosed_hiv,
        sms.sti_clinic_dx_inf_syph_ps AS attendees_dx_infectious_syphilis,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
)
INSERT INTO base.fact_sti_cases_monthly (
    date_id,
    location_id,
    sex_id,
    age_group_id,
    sti_attendees,
    new_sti_attendees,
    attendees_tested_hiv,
    attendees_tested_syphilis,
    attendees_newly_diagnosed_hiv,
    attendees_dx_infectious_syphilis

) 
SELECT 
    date_id,
    location_id,
    sex_id,
    age_group_id,
    sti_attendees,
    new_sti_attendees,
    attendees_tested_hiv,
    attendees_tested_syphilis,
    attendees_newly_diagnosed_hiv,
    attendees_dx_infectious_syphilis
FROM 
   sti_clinic_cte; 
    
-- $END

