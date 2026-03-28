USE emtct4;
GO

DROP TABLE IF EXISTS base.fact_ci_sex_disagg_monthly;

-- $BEGIN

CREATE TABLE base.fact_ci_sex_disagg_monthly (
    fact_ci_sex_disagg_monthly_id BIGINT IDENTITY(1,1),
    date_id INT NULL,
    location_id INT NULL,
    sex_id INT NULL,
    children_listed_by_index INT NULL,
    children_tested_hiv INT NULL,
    children_positive_hiv INT NULL,
    children_known_hiv_positive INT NULL,
    children_newly_diagnosed_hiv INT NULL,
    hiv_neg_partners_linked_prevention INT NULL,
    index_clients_screened_ipv INT NULL,
    aids_related_deaths INT NULL,
    non_aids_related_deaths INT NULL,
    interviewed_counselled_total INT NULL,
    gds_cases INT NULL,
    gud_cases INT NULL,
    pid_cases INT NULL,
    clients_reached_field_visits INT NULL,
    clients_not_reached_3plus_field INT NULL,
    clients_reached_calls INT NULL,
    clients_not_reached_3plus_calls INT NULL,
);

ALTER TABLE [base].fact_ci_sex_disagg_monthly ADD CONSTRAINT PK_ci_sex_disagg_monthly_id PRIMARY KEY ([fact_ci_sex_disagg_monthly_id]);
ALTER TABLE [base].fact_ci_sex_disagg_monthly ADD CONSTRAINT FK_ci_sex_disagg_monthly_date_id FOREIGN KEY ([date_id]) REFERENCES [base].dim_date ([date_id]);
ALTER TABLE [base].fact_ci_sex_disagg_monthly ADD CONSTRAINT FK_ci_sex_disagg_monthly_location_id FOREIGN KEY ([location_id]) REFERENCES [base].dim_location ([location_id]);
ALTER TABLE [base].fact_ci_sex_disagg_monthly ADD CONSTRAINT FK_ci_sex_disagg_monthly_sex_id FOREIGN KEY ([sex_id]) REFERENCES [base].dim_sex ([sex_id]);


-- $END

