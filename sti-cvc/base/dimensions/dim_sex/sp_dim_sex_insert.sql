USE emtct4;
GO

TRUNCATE TABLE base.dim_sex;
    
-- $BEGIN

    INSERT INTO base.dim_sex (
        sex_id,
        sex_code,
        sex_name
    )
    VALUES
        (1, 'M',    'Male'),
        (2, 'F',    'Female'),
        (3, 'T',  'Transgender')

   
-- $END

SELECT * FROM base.dim_sex;