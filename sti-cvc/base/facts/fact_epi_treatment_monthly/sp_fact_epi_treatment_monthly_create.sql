USE emtct4;
GO

DROP TABLE IF EXISTS base.fact_ci_general_monthly;

-- $BEGIN

CREATE TABLE base.fact_ci_general_monthly (
    fact_ci_general_monthly_id BIGINT IDENTITY(1,1),
    date_id INT NULL,
    location_id INT NULL,
    sex_id INT NULL,
    condition_category NVARCHAR(100),
    new_cases_reported INT NULL,
    new_cases_interviewed INT NULL,
    contacts_named INT NULL,
    contacts_locatable INT NULL,
    contacts_located INT NULL,
    contacts_tested INT NULL,
    contacts_positive INT NULL,
    contacts_known_positive INT NULL,
    positive_contacts_newly_diagnosed INT NULL
);

ALTER TABLE [base].fact_ci_general_monthly ADD CONSTRAINT PK_ci_general_monthly_id PRIMARY KEY ([fact_sti_clinic_monthly_id]);
ALTER TABLE [base].fact_ci_general_monthly ADD CONSTRAINT FK_ci_general_monthly_date_id FOREIGN KEY ([date_id]) REFERENCES [base].dim_date ([date_id]);
ALTER TABLE [base].fact_ci_general_monthly ADD CONSTRAINT FK_ci_general_monthly_location_id FOREIGN KEY ([location_id]) REFERENCES [base].dim_location ([location_id]);
ALTER TABLE [base].fact_ci_general_monthly ADD CONSTRAINT FK_ci_general_monthly_sex_id FOREIGN KEY ([sex_id]) REFERENCES [base].dim_sex ([sex_id]);


-- $END

