USE emtct4;
GO

TRUNCATE TABLE base.fact_sti_cases_monthly;

-- $BEGIN

WITH sti_cases_cte AS (
    SELECT 
        sms.sti_syph_primary_a1 AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Primary (A1)' = dsc.condition_name

    UNION ALL 
        sms.sti_syph_secondary_a2 AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Secondary (A2)' = dsc.condition_name
    UNION ALL 
        sms.sti_syph_early_latent_a3 AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Early Latent (A3)' = dsc.condition_name
    UNION ALL 
        sms.sti_syph_late_latent AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Late Latent' = dsc.condition_name
    UNION ALL 
        sms.sti_syph_tertiary AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Tertiary' = dsc.condition_name
    UNION ALL 
        sms.sti_syph_cong_lt2 AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Congenital < 2 years' = dsc.condition_name
    UNION ALL 
        sms.sti_syph_cong_2_4 AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Congenital  2 - 4 years' = dsc.condition_name
    UNION ALL 
        sms.sti_gds_discharge AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Genital Discharge' = dsc.condition_name
    UNION ALL 
        sms.sti_gds_cervicitis AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Cervicitis' = dsc.condition_name
    UNION ALL 
        sms.sti_gud_gen_herpes AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Genital Herpes' = dsc.condition_name
    UNION ALL 
        sms.sti_gud_chancroid AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Chancroid' = dsc.condition_name
    UNION ALL 
        sms.sti_gud_granuloma_inguinale AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Granuloma Inguinale' = dsc.condition_name
    UNION ALL 
        sms.sti_gud_lgv AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'LGV' = dsc.condition_name
    UNION ALL 
        sms.sti_other_ophthalmia_neon AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Ophthalmia Neonatorum (< 1 month)' = dsc.condition_name
    UNION ALL 
        sms.sti_other_epididymo_orchitis AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Epididymo-orchitis' = dsc.condition_name
    UNION ALL 
        sms.sti_other_pid AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Pelvic inflammatory Disease (PID)' = dsc.condition_name
    UNION ALL 
        sms.sti_other_genital_warts AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Genital Warts' = dsc.condition_name
    UNION ALL 
        sms.sti_gud_hep_bc_new AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'Hepatitis B/C' = dsc.condition_name
    UNION ALL 
        sms.sti_gud_htlv_new AS case_count,
        sms.startdate,
        sms.facility_uid,
        sms.categorization,
        dd.date_id,
        dl.location_id,
        dag.age_group_id,
        ds.sex_id,
        dsc.sti_condition_id,
        'STI Monthly Summary 2026+' AS source_dataset
    FROM staging.sti_monthly_summary sms LEFT JOIN base.dim_date dd ON sms.start_date = dd.report_date
    LEFT JOIN base.dim_location dl ON sms.facility_uid = dl.location_uid
    LEFT JOIN base.dim_age_group dag ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),2)) = dag.age_group_name
    LEFT JOIN base.dim_sex ds ON TRIM(PARSENAME(REPLACE(sms.categorization,',','.'),1)) = dag.sex_code
    LEFT JOIN base.dim_sti_condition dsc ON 'HTLV I / II' = dsc.condition_name

)
INSERT INTO base.fact_sti_cases_monthly (
    date_id,
    location_id,
    sti_condition_id,
    sex_id,
    age_group_id,
    case_count,
    source_dataset
) 
SELECT 
    date_id,
    location_id,
    sti_condition_id,
    sex_id,
    age_group_id,
    case_count,
    source_dataset 
FROM 
   sti_cases_cte; 

    
-- $END