USE emtct4;
Go


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
    'Facility',
    NULL AS parent_id,
    dbo.GetToken(path, '/', 4)

FROM 
    cvc_sti.organisationunit 
WHERE
    hierarchylevel = 4 AND  [name] NOT LIKE 'demo%' AND [name] NOT LIKE '_CI -%' AND [name] NOT LIKE 'CI -%';
    

-- Insert an Unknown location
INSERT INTO base.dim_location (
    [name],
    location_uid,
    level, 
    path, 
    [type],
    parent_id,
    parent_uid
)
VALUES(
    'Unknown',
    NULL,
    NULL, 
    NULL, 
    NULL,
    NULL,
    NULL
);
    
-- $END