USE emtct4;
GO


-- $BEGIN

-- Update the parent_id for the parish
UPDATE parish 
SET parish.parent_id = region.location_id 
FROM  base.dim_location parish INNER JOIN base.dim_location region 
ON parish.parent_uid = region.location_uid
WHERE 
    parish.type = 'Parish' AND region.type = 'Region';


-- Update the parent_id for the Facility
UPDATE facility 
SET facility.parent_id = parish.location_id 
FROM  base.dim_location facility INNER JOIN base.dim_location parish 
ON facility.parent_uid = parish.location_uid
WHERE 
    facility.type = 'Facility' AND parish.type = 'Parish';

-- $END