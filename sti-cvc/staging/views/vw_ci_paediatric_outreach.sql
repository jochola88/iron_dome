USE emtct4
GO

CREATE OR ALTER VIEW staging.vw_ci_paediatric_outreach AS 

-- $BEGIN

SELECT 
	'V2026' AS version,
	dv.dataelementid,
	de.uid AS dataelementuid,
	dv.periodid,
	dv.sourceid AS organisationunitid,
	dv.categoryoptioncomboid,
	dv.attributeoptioncomboid,
	dv.value,
	ds.datasetid,
	ds.uid AS datasetuid,
	CAST(coc.name AS VARCHAR(255)) AS categorization,
	p.startdate,
	ou.uid AS facility_uid
	
FROM 
	emtct4.cvc_sti.datavalue dv
JOIN emtct4.cvc_sti.dataelement de ON dv.dataelementid  = de.dataelementid
JOIN emtct4.cvc_sti.datasetelement dse ON de.dataelementid  = dse.dataelementid 
JOIN emtct4.cvc_sti.dataset ds ON dse.datasetid = ds.datasetid 
JOIN emtct4.cvc_sti.categoryoptioncombo coc ON dv.categoryoptioncomboid = coc.categoryoptioncomboid
JOIN emtct4.cvc_sti.period p ON dv.periodid = p.periodid
JOIN emtct4.cvc_sti.organisationunit ou ON dv.sourceid = ou.organisationunitid
WHERE 
	ds.datasetid = 349095
AND dv.deleted = 0
AND de.uid IN (
'YSyRAu8DGyu',
'm9FfwpX9FaW',
'HWIE2DrbHKt',
'mVXzxivc7Pq',
'ju6XEd6WZiC',
'caZCrsYupoC',
'PLnGjYddo2X'

);


-- $END
GO
SELECT TOP 1000 * FROM staging.vw_ci_paediatric_outreach;
