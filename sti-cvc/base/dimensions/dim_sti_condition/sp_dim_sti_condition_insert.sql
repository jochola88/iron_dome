USE emtct4;
GO

TRUNCATE TABLE base.dim_sti_condition;
    
-- $BEGIN

    INSERT INTO base.dim_sti_condition (
        condition_name,
        syndrome_category,
        condition_code,
        is_testable
    )
    SELECT 
        condition_name,
        syndrome_category,
        condition_code,
        is_testable
    FROM 
        [external].sti_conditions;
   
-- $END

SELECT * FROM base.dim_sti_condition;