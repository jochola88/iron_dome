USE emtct4;
GO

DROP TABLE IF EXISTS base.fact_sti_clinic_monthly;

-- $BEGIN

CREATE TABLE base.fact_sti_clinic_monthly (
    fact_sti_clinic_monthly_id BIGINT IDENTITY(1,1),
    date_id INT NULL,
    location_id INT NULL,
    sex_id INT NULL,
    age_group_id INT NULL,
    sti_attendees INT NULL,
    new_sti_attendees INT NULL,
    attendees_tested_hiv INT NULL,
    attendees_tested_syphilis INT NULL,
    attendees_newly_diagnosed_hiv INT NULL,
    attendees_dx_infectious_syphilis INT NULL
);

ALTER TABLE [base].fact_sti_clinic_monthly ADD CONSTRAINT PK_sti_clinic_monthly_id PRIMARY KEY ([fact_sti_clinic_monthly_id]);
ALTER TABLE [base].fact_sti_clinic_monthly ADD CONSTRAINT FK_sti_clinic_monthly_date_id FOREIGN KEY ([date_id]) REFERENCES [base].dim_date ([date_id]);
ALTER TABLE [base].fact_sti_clinic_monthly ADD CONSTRAINT FK_sti_clinic_monthly_location_id FOREIGN KEY ([location_id]) REFERENCES [base].dim_location ([location_id]);
ALTER TABLE [base].fact_sti_clinic_monthly ADD CONSTRAINT FK_sti_clinic_monthly_sex_id FOREIGN KEY ([sex_id]) REFERENCES [base].dim_sex ([sex_id]);
ALTER TABLE [base].fact_sti_clinic_monthly ADD CONSTRAINT FK_sti_clinic_monthly_age_group_id FOREIGN KEY ([age_group_id]) REFERENCES [base].dim_age_group ([age_group_id]);


-- $END

