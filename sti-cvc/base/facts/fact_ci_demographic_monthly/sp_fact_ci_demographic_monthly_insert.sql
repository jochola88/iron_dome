USE emtct4;
GO

TRUNCATE TABLE base.fact_ci_demographic_monthly;

-- $BEGIN


INSERT INTO base.fact_ci_demographic_monthly (
     date_id,
    location_id,
    cs_new_cases_reported,
    cs_cases_investigated,
    cs_cases_closed,
    hei_new_cases_reported,
    hei_cases_investigated,
    hei_cases_closed,
    on_new_cases_reported,
    on_cases_investigated,
    on_cases_closed,
    group_counselling_sessions,
    group_counselling_persons_reached,
    individual_counselling_sessions,
    individual_counselling_persons,
    targeted_outreach_sessions,
    targeted_outreach_persons,
    field_visits_count,
    field_visits_persons_reached

) 
SELECT 
    date_id,
    location_id,
    cs_cnt_new_cases_reported,
    cs_ci_pi_cnt_cases_investigated,
    cs_cnt_cases_closed,
    hei_cnt_new_cases_reported,
    hei_ci_pi_cnt_cases_investigated,
    hei_cnt_cases_closed,
    on_cnt_new_cases_reported,
    on_ci_pi_cnt_cases_investigated,
    on_cnt_cases_closed,
    group_counselling_sessions_done,
    group_counselling_sessions_persons_reached,
    individual_counselling_sessions_done,
    individual_counselling_sessions_persons_reached,
    targeted_outreach_sessions_done,
    targeted_outreach_sessions_persons_reached,
    ci_field_visits_done,
    ci_field_visits_done_persons_reached
FROM 
   staging.ci_paediatric_outreach cpo LEFT JOIN base.dim_date dd ON cpo.startdate = dd.report_date
    LEFT JOIN base.dim_location dl ON cpo.facility_uid = dl.location_uid;
    
-- $END
