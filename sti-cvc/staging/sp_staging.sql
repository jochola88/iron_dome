USE recency_uganda_prod_analysis_test;
GO

-- $BEGIN

 PRINT 'Dropping staging tables'
 EXEC dbo.sp_xf_system_drop_all_tables_in_schema 'staging'

PRINT 'Executing sp_staging_recency_hts_client_card'
EXEC staging.sp_staging_recency_hts_client_card;

PRINT 'Executing sp_staging_recency_uvri_result'
EXEC staging.sp_staging_recency_uvri_result;

-- $END