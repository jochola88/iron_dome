USE emtct4;
GO

-- $BEGIN

EXEC base.sp_fact_ci_general_monthly_create;
EXEC base.sp_fact_ci_general_monthly_insert;

-- $END