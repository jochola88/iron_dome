USE emtct4;
GO

DROP TABLE IF EXISTS base.dim_location;

-- $BEGIN

CREATE TABLE base.dim_location(
    location_id INT IDENTITY(1,1),
    [name] NVARCHAR(255) NULL,
    location_uid NVARCHAR(255) NULL,
    level NVARCHAR(255) NULL, 
    path NVARCHAR(255) NULL, 
    [type] NVARCHAR(255) NULL, -- Facility or Parish or Region
    parent_id INT NULL,
    parent_uid NVARCHAR(255) NULL
);
ALTER TABLE [base].dim_location ADD CONSTRAINT pk_location_id PRIMARY KEY ([location_id]);

-- $END