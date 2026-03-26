USE emtct4;
GO

DROP TABLE IF EXISTS base.dim_sex;

-- $BEGIN

CREATE TABLE base.dim_sex (
  sex_id INT NOT NULL ,
  sex_code CHAR(1) NOT NULL,
  sex_name NVARCHAR(20) NULL

);

ALTER TABLE [base].dim_sex ADD CONSTRAINT PK_sex_id PRIMARY KEY ([sex_id]);

-- $END