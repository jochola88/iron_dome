USE emtct4;
GO

DROP TABLE IF EXISTS base.fact_ci_demographic_monthly;

-- $BEGIN

CREATE TABLE base.fact_ci_demographic_monthly (
    fact_ci_demographic_monthly_id BIGINT IDENTITY(1,1),
    date_id INT NULL,
    location_id INT NULL,
    cs_new_cases_reported INT NULL,
    cs_cases_investigated INT NULL,
    cs_cases_closed INT NULL,
    hei_new_cases_reported INT NULL,
    hei_cases_investigated INT NULL,
    hei_cases_closed INT NULL,
    on_new_cases_reported INT NULL,
    on_cases_investigated INT NULL,
    on_cases_closed INT NULL,
    group_counselling_sessions INT NULL,
    group_counselling_persons_reached INT NULL,
    individual_counselling_sessions INT NULL,
    individual_counselling_persons INT NULL,
    targeted_outreach_sessions INT NULL,
    targeted_outreach_persons INT NULL,
    field_visits_count INT NULL,
    field_visits_persons_reached INT NULL


);

ALTER TABLE [base].fact_ci_demographic_monthly ADD CONSTRAINT PK_ci_demographic_monthly_id PRIMARY KEY ([fact_ci_demographic_monthly_id]);
ALTER TABLE [base].fact_ci_demographic_monthly ADD CONSTRAINT FK_ci_demographic_monthly_date_id FOREIGN KEY ([date_id]) REFERENCES [base].dim_date ([date_id]);
ALTER TABLE [base].fact_ci_demographic_monthly ADD CONSTRAINT FK_ci_demographic_monthly_location_id FOREIGN KEY ([location_id]) REFERENCES [base].dim_location ([location_id]);



-- $END

