USE emtct4;
GO

-- DROP the staging.sti_monthly_summary  table with pivoted data
DROP TABLE IF EXISTS staging.sti_monthly_summary;

-- $BEGIN

DECLARE 
    @columns NVARCHAR(MAX) = '', 
    @sql     NVARCHAR(MAX) = '';

-- Drop Temporary table if exists
DROP TABLE IF EXISTS #temp_sti_monthly_summary;

-- Create a Temp table for the STI Monthly Summary Data
SELECT sms.*, cnm.column_name
INTO #temp_sti_monthly_summary
FROM staging.vw_sti_monthly_summary sms
JOIN [external].column_name_mappings cnm ON sms.dataelementid = cnm.dataelementid;

-- Create a multi-column index on the Temp table
CREATE INDEX idx_multi_temp_sti_monthly_summary ON #temp_sti_monthly_summary
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
SELECT * INTO staging.sti_monthly_summary FROM   
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
	MAX(CASE WHEN column_name = ''sti_gud_granuloma_inguinale'' THEN value END) AS sti_gud_granuloma_inguinale,
    MAX(CASE WHEN column_name = ''sti_gud_hep_bc_new'' THEN value END) AS sti_gud_hep_bc_new,
	MAX(CASE WHEN column_name = ''sti_gud_htlv_new'' THEN value END) AS sti_gud_htlv_new,
	MAX(CASE WHEN column_name = ''sti_other_epi_gc_chlam'' THEN value END) AS sti_other_epi_gc_chlam,
	MAX(CASE WHEN column_name = ''sti_other_epi_syph_partner'' THEN value END) AS sti_other_epi_syph_partner,
	MAX(CASE WHEN column_name = ''sti_other_ophthalmia_neon'' THEN value END) AS sti_other_ophthalmia_neon,
	MAX(CASE WHEN column_name = ''sti_other_pid'' THEN value END) AS sti_other_pid,
	MAX(CASE WHEN column_name = ''sti_other_genital_warts'' THEN value END) AS sti_other_genital_warts,
	MAX(CASE WHEN column_name = ''sti_clinic_new_attendees'' THEN value END) AS sti_clinic_new_attendees,
	MAX(CASE WHEN column_name = ''sti_syph_cong_lt2'' THEN value END) AS sti_syph_cong_lt2,
	MAX(CASE WHEN column_name = ''sti_clinic_attendees'' THEN value END) AS sti_clinic_attendees,
	MAX(CASE WHEN column_name = ''sti_gud_chancroid'' THEN value END) AS sti_gud_chancroid,
	MAX(CASE WHEN column_name = ''sti_syph_tertiary'' THEN value END) AS sti_syph_tertiary,
	MAX(CASE WHEN column_name = ''sti_syph_late_latent'' THEN value END) AS sti_syph_late_latent,
	MAX(CASE WHEN column_name = ''sti_syph_cong_2_4'' THEN value END) AS sti_syph_cong_2_4,
	MAX(CASE WHEN column_name = ''sti_syph_early_latent_a3'' THEN value END) AS sti_syph_early_latent_a3,
	MAX(CASE WHEN column_name = ''sti_gud_lgv'' THEN value END) AS sti_gud_lgv,
	MAX(CASE WHEN column_name = ''sti_syph_primary_a1'' THEN value END) AS sti_syph_primary_a1,
	MAX(CASE WHEN column_name = ''sti_syph_secondary_a2'' THEN value END) AS sti_syph_secondary_a2,
	MAX(CASE WHEN column_name = ''sti_gds_discharge'' THEN value END) AS sti_gds_discharge,
	MAX(CASE WHEN column_name = ''sti_gds_cervicitis'' THEN value END) AS sti_gds_cervicitis,
	MAX(CASE WHEN column_name = ''sti_gud_gen_herpes'' THEN value END) AS sti_gud_gen_herpes,
	MAX(CASE WHEN column_name = ''sti_clinic_tested_hiv'' THEN value END) AS sti_clinic_tested_hiv,
	MAX(CASE WHEN column_name = ''sti_clinic_tested_syph'' THEN value END) AS sti_clinic_tested_syph,
	MAX(CASE WHEN column_name = ''sti_clinic_new_hiv_diag'' THEN value END) AS sti_clinic_new_hiv_diag,
	MAX(CASE WHEN column_name = ''sti_clinic_dx_inf_syph_ps'' THEN value END) AS sti_clinic_dx_inf_syph_ps,
    MAX(CASE WHEN column_name = ''sti_other_epididymo_orchitis'' THEN value END) AS sti_other_epididymo_orchitis
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

DROP TABLE IF EXISTS #temp_sti_monthly_summary;

-- $END