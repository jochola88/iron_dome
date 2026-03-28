USE emtct4;
GO

DROP TABLE IF EXISTS base.fact_prep_pop1_monthly;

-- $BEGIN

CREATE TABLE base.fact_prep_pop1_monthly (
    fact_prep_pop1_monthly_id BIGINT IDENTITY(1,1),
    date_id INT NULL,
    location_id INT NULL,
    sex_id INT NULL,
    risk_group NVARCHAR(100),
    age_group_prep NVARCHAR(100),
    clients_engaged_prep INT NULL,
    clients_willing_initiate INT NULL,
    clients_commenced_prep_from_ci INT NULL,
    clients_newly_initiated INT NULL,
    clients_reinitiated INT NULL,
    clients_continued INT NULL,
    clients_hiv_positive_on_prep INT NULL,
    clients_sti_diagnosed_on_prep INT NULL
);

ALTER TABLE [base].fact_prep_pop1_monthly ADD CONSTRAINT PK_prep_pop1_monthly_id PRIMARY KEY ([fact_prep_pop1_monthly_id]);
ALTER TABLE [base].fact_prep_pop1_monthly ADD CONSTRAINT FK_prep_pop1_monthly_date_id FOREIGN KEY ([date_id]) REFERENCES [base].dim_date ([date_id]);
ALTER TABLE [base].fact_prep_pop1_monthly ADD CONSTRAINT FK_prep_pop1_monthly_location_id FOREIGN KEY ([location_id]) REFERENCES [base].dim_location ([location_id]);
ALTER TABLE [base].fact_prep_pop1_monthly ADD CONSTRAINT FK_prep_pop1_monthly_sex_id FOREIGN KEY ([sex_id]) REFERENCES [base].dim_sex ([sex_id]);


-- $END

