USE recency_uganda_prod_analysis_test
GO

-- $BEGIN

DROP TABLE IF EXISTS derived_recency.data_refresh_log

CREATE TABLE derived_recency.data_refresh_log (
	last_refreshed DATETIME NOT NULL
)

INSERT INTO derived_recency.data_refresh_log (last_refreshed) VALUES (GETDATE())

-- $END
