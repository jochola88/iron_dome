USE emtct4
GO

CREATE OR ALTER VIEW  staging.vw_emtct_monthly_report AS 

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
WHERE 
	ds.datasetid = 349421
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
	ds.datasetid = 329443
AND dv.deleted = 0

-- $END
GO

SELECT TOP 1000 * FROM staging.vw_emtct_monthly_report;