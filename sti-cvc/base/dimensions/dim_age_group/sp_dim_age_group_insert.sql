USE emtct4;
GO

TRUNCATE TABLE base.dim_age_group;
    
-- $BEGIN

    INSERT INTO base.dim_age_group (
        age_group_name,
        age_group_min,
        age_group_max,
        sort_order
    )
    SELECT 
        age_group_name,
        age_group_min,
        age_group_max,
        sort_order
    FROM 
        [external].five_year_age_groups;
   
-- $END

SELECT * FROM base.dim_age_group;