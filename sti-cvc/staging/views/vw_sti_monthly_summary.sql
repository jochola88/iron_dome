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
	ds.datasetid = 349348
AND dv.deleted = 0
AND de.uid IN (
'ew162yddjeq',
'gZHRLn2r4e2',
'ukMVh6Hg46C',
'K5kXubJrtfp',
'I9cw2hv4I5l',
'sqaT64FVVN1',
'hMcJ1JXIlMs',
'r19VLYTMcXW',
'WcMFerTVFsI',
'smrkgQybqHT',
'a6OO6pAohZT',
'nRuBRbZojXf',
'P3o19y0hUrE',
'RiH5JScp4iD',
'PeW8R8VAVqd',
'HiTSPEWyJqK',
'uSBZrFJJh5B',
'GXXVmDmV0PM',
'KpK9yMDCPWx',
'Yxzk5juzkhB',
'WTXZaI4GFhD',
'bSbmJMTTv6R',
'BoEkvW61pWJ',
'a8BBcPWVrrj',
'CQYuanS7PnK',
'WLhIV7EWR5s',
'MchzFr4Saqm'
);

-- $END
GO

SELECT  TOP 1000 * FROM staging.vw_sti_monthly_summary;