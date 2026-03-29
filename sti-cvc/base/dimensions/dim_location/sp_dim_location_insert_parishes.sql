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
    'Parish',
    NULL AS parent_id,
    dbo.GetToken(path,'/',3)

FROM 
    cvc_sti.organisationunit 
WHERE
    hierarchylevel = 3 AND name NOT LIKE 'demo%';

    
-- $END
