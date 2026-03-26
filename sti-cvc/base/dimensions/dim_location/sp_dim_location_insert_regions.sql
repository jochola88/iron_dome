USE emtct4;
Go

TRUNCATE TABLE base.dim_location;

-- $BEGIN

INSERT INTO base.dim_location (
    [name],
    location_uid,
    level, 
    path, 
    [type],
    parent_id,
    parent_uid
)
SELECT
    [name],
    uid,
    hierarchylevel,
    path,
    'Region',
    NULL,
    NULL 
FROM 
    cvc_sti.organisationunit 
WHERE
    hierarchylevel = 2 AND name NOT LIKE 'demo%';

    
-- $END