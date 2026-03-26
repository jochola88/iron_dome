USE emtct4
GO

CREATE OR ALTER VIEW staging.vw_sti_monthly_summary AS 

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
	ds.uid AS datasetuid
	
FROM 
	emtct4.cvc_sti.datavalue dv
JOIN emtct4.cvc_sti.dataelement de ON dv.dataelementid  = de.dataelementid
JOIN emtct4.cvc_sti.datasetelement dse ON de.dataelementid  = dse.dataelementid 
JOIN emtct4.cvc_sti.dataset ds ON dse.datasetid = ds.datasetid 
JOIN emtct4.cvc_sti.categoryoptioncombo coc ON dv.categoryoptioncomboid = coc.categoryoptioncomboid
JOIN emtct4.cvc_sti.period p ON dv.periodid = 
WHERE 
	ds.datasetid = 349348
AND dv.deleted = 0

UNION ALL 

SELECT 
	'V2025' AS version,
	dv.dataelementid,
	de.uid AS dataelementuid,
	dv.periodid,
	dv.sourceid AS organisationunitid,
	dv.categoryoptioncomboid,
	dv.attributeoptioncomboid,
	dv.value,
	ds.datasetid,
	ds.uid AS datasetuid
	
FROM 
	emtct4.cvc_sti.datavalue dv
JOIN emtct4.cvc_sti.dataelement de ON dv.dataelementid  = de.dataelementid
JOIN emtct4.cvc_sti.datasetelement dse ON de.dataelementid  = dse.dataelementid 
JOIN emtct4.cvc_sti.dataset ds ON dse.datasetid = ds.datasetid 
WHERE 
	ds.datasetid = 3841
AND dv.deleted = 0

-- $END
GO

SELECT  TOP 1000 * FROM staging.vw_sti_monthly_summary;