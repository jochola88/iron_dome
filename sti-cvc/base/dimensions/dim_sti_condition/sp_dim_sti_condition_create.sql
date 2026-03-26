USE emtct4;
GO

DROP TABLE IF EXISTS base.dim_sti_condition;

-- $BEGIN 

CREATE TABLE base.dim_sti_condition (
  sti_condition_id INT IDENTITY(1,1) ,
  condition_name NVARCHAR(255) NOT NULL,
  syndrome_category NVARCHAR(255) NOT NULL,
  condition_code NVARCHAR(255) NULL,
  is_testable TINYINT NOT NULL

);

ALTER TABLE [base].dim_sti_condition ADD CONSTRAINT PK_sti_condition_id PRIMARY KEY ([sti_condition_id]);

-- $END