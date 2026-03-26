USE emtct4;
GO

-- $BEGIN

EXEC base.sp_dim_location_create;
EXEC base.sp_dim_location_insert_regions;
EXEC base.sp_dim_location_insert_parishes;
EXEC base.sp_dim_location_insert_facilities;
EXEC base.sp_dim_location_update_parent_ids;

-- $END