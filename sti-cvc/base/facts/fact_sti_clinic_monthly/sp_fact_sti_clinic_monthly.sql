USE emtct4;
GO

-- $BEGIN

EXEC base.sp_fact_sti_clinic_monthly_create;
EXEC base.sp_fact_sti_clinic_monthly_insert;

-- $END