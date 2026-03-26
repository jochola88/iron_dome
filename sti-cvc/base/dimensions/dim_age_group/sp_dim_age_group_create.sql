USE emtct4;
GO

DROP TABLE IF EXISTS base.dim_age_group;

-- $BEGIN

CREATE TABLE base.dim_age_group (
  age_group_id INT IDENTITY(1,1) ,
  age_group_name VARCHAR(20) NOT NULL,
  age_group_min INT NULL,
  age_group_max INT NULL,
  sort_order INT NOT NULL

);

ALTER TABLE [base].dim_age_group ADD CONSTRAINT PK_age_group_id PRIMARY KEY ([age_group_id]);

-- $END