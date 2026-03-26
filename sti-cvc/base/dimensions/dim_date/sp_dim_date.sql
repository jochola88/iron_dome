USE emtct4;
GO

DROP TABLE IF EXISTS base.dim_date;

-- $BEGIN  
    SET NOCOUNT ON;
-- create table if it does not exist
BEGIN
    CREATE TABLE base.dim_date (
        date_id INT NOT NULL PRIMARY KEY,
        report_date DATE NOT NULL,
        [year] INT NOT NULL,
        [month] INT NOT NULL,
        month_name VARCHAR(20) NOT NULL,
        year_month_label VARCHAR(10) NOT NULL,
        quarter INT NOT NULL,
        quarter_name VARCHAR(2) NOT NULL,
        year_quarter_label VARCHAR(10) NOT NULL,
        year_half INT NOT NULL,
        half_name VARCHAR(2) NOT NULL,
        year_half_label VARCHAR(10) NOT NULL,
        reporting_period VARCHAR(7) NOT NULL
    );
END


DECLARE @start_year INT = 2000;
DECLARE @end_year INT = YEAR(GETDATE()) + 5;

DECLARE @year INT = @start_year;
DECLARE @month INT;
DECLARE @date_id INT = 1;

WHILE @year <= @end_year
BEGIN
    SET @month = 1;

    WHILE @month <= 12
    BEGIN
        DECLARE @report_date DATE = DATEFROMPARTS(@year, @month, 1);
        DECLARE @quarter INT = DATEPART(QUARTER, @report_date);
        DECLARE @quarter_name VARCHAR(2) = 'Q' + CAST(@quarter AS VARCHAR(1));
        DECLARE @year_quarter_label VARCHAR(10) = CAST(@year AS VARCHAR(4)) + '-' + @quarter_name;
        DECLARE @year_half INT = CASE WHEN @month <= 6 THEN 1 ELSE 2 END;
        DECLARE @half_name VARCHAR(2) = 'H' + CAST(@year_half AS VARCHAR(1));
        DECLARE @year_half_label VARCHAR(10) = CAST(@year AS VARCHAR(4)) + '-' + @half_name;

        INSERT INTO base.dim_date (
            date_id,
            report_date,
            [year],
            [month],
            month_name,
            year_month_label,
            quarter,
            quarter_name,
            year_quarter_label,
            year_half,
            half_name,
            year_half_label,
            reporting_period
        )
        VALUES (
            @date_id,
            @report_date,
            @year,
            @month,
            DATENAME(MONTH, @report_date),
            dbo.fn_SentenceCase(LEFT(DATENAME(MONTH, @report_date), 3)) + ' ' + CAST(@year AS VARCHAR(4)),
            @quarter,
            @quarter_name,
            @year_quarter_label,
            @year_half,
            @half_name,
            @year_half_label,
            FORMAT(@report_date, 'yyyy-MM')
        );

        SET @date_id = @date_id + 1;
        SET @month = @month + 1;
    END

    SET @year = @year + 1;
END;


-- $END

