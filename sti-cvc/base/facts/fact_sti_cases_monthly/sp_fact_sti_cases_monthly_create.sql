USE emtct4;
GO

DROP TABLE IF EXISTS base.fact_sti_cases_monthly;

-- $BEGIN

CREATE TABLE base.fact_sti_cases_monthly (
    fact_sti_cases_monthly_id BIGINT IDENTITY(1,1),
    date_id INT NULL,
    location_id INT NULL,
    sti_condition_id INT NULL,
    sex_id INT NULL,
    age_group_id INT NULL,
    case_count INT NULL,
    source_dataset VARCHAR(100)
);

ALTER TABLE [base].fact_sti_cases_monthly ADD CONSTRAINT PK_sti_cases_monthly_id PRIMARY KEY ([fact_sti_cases_monthly_id]);
ALTER TABLE [base].fact_sti_cases_monthly ADD CONSTRAINT FK_sti_cases_monthly_date_id FOREIGN KEY ([date_id]) REFERENCES [base].dim_date ([date_id]);
ALTER TABLE [base].fact_sti_cases_monthly ADD CONSTRAINT FK_sti_cases_monthly_location_id FOREIGN KEY ([location_id]) REFERENCES [base].dim_location ([location_id]);
ALTER TABLE [base].fact_sti_cases_monthly ADD CONSTRAINT FK_sti_cases_monthly_sti_condition_id FOREIGN KEY ([sti_condition_id]) REFERENCES [base].dim_sti_condition ([sti_condition_id]);
ALTER TABLE [base].fact_sti_cases_monthly ADD CONSTRAINT FK_sti_cases_monthly_sex_id FOREIGN KEY ([sex_id]) REFERENCES [base].dim_sex ([sex_id]);
ALTER TABLE [base].fact_sti_cases_monthly ADD CONSTRAINT FK_sti_cases_monthly_age_group_id FOREIGN KEY ([age_group_id]) REFERENCES [base].dim_age_group ([age_group_id]);


-- $END

