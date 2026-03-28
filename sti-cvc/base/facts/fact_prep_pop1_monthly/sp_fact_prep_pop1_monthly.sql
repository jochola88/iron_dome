USE emtct4;
GO

-- $BEGIN

EXEC base.sp_fact_ci_prep_pop1_monthly_create;
EXEC base.sp_fact_ci_prep_pop1_monthly_insert;

-- $END