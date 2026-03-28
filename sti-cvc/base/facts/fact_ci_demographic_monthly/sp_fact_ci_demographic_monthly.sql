USE emtct4;
GO

-- $BEGIN

EXEC base.sp_fact_ci_demographic_monthly_create;
EXEC base.sp_fact_ci_demographic_monthly_insert;

-- $END