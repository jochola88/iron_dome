USE emtct4
GO

CREATE OR ALTER VIEW staging.vw_ci_paediatric_indicators AS 

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
'pQXOqp1s7bu','IvD0NVF9oqZ','gxkwfXu8Vjf','TCKrCWHrL1m','LD81Wxcgia8',
'pjKa8DqCAHU','LHGF5prkgpH','uYjkGZwO3aA','jayfEQEevVo','eF5RIIEALHi',
'G290IPqB7hA','CfQ2ogfkrvK','Xix2TUeGNFh','yR2bxEdmln7','tN4F5oXeg5y',
'CfC1tbzk6ru','dbRoxCkUeR2','POqxyhGpwpG','GVNo8kWuubN','DbdmWkU6BDl',
'rkIav4dVG5J','w4dLr0HvEHb','mBFpcGm83M5','ODCIzSHPx2j','dXcRJw4JHlo',
'sfygeJIyQ9V','UfRdNKzC4Up','CfnFqgCm5h6','ni7RgMM70pu','u9SxjVWCGXD',
'j7UUJKSgB3A','vrn4dWetIBu','g8sUeTJVWE1','PaFCPuzy6L5','kWmJ6umG18h',
'dCFGHuEKQFV','XlQNtdK9w3G','menryI01jyw','Oq3LVf8NcWy','Aoz0BFTbIS1',
'kSMMx0gdFBZ','PAPo2FQ6edH','TAVL9nsddNg','ylIUcO0n8lm','CNdkKukKI8Z',
'D0U07FUZKMW','PpxMtLEydky','vTk4YrcH9ik','eczJTG71Y3E','ePYmxlEuRj8',
'q3gwknrWxqI','kZNWM8GKMyS','j9ylw5PdtFR','IoqhwLsk4hq'
);

-- UNION ALL 

-- SELECT 
-- 	'V2025' AS version,
-- 	dv.dataelementid,
-- 	de.uid AS dataelementuid,
-- 	dv.periodid,
-- 	dv.sourceid AS organisationunitid,
-- 	dv.categoryoptioncomboid,
-- 	dv.attributeoptioncomboid,
-- 	dv.value,
-- 	ds.datasetid,
-- 	ds.uid AS datasetuid
	
-- FROM 
-- 	emtct4.cvc_sti.datavalue dv
-- JOIN emtct4.cvc_sti.dataelement de ON dv.dataelementid  = de.dataelementid
-- JOIN emtct4.cvc_sti.datasetelement dse ON de.dataelementid  = dse.dataelementid 
-- JOIN emtct4.cvc_sti.dataset ds ON dse.datasetid = ds.datasetid 
-- WHERE 
-- 	ds.datasetid = 4750
-- AND dv.deleted = 0


-- $END
GO
SELECT TOP 1000 * FROM staging.vw_ci_general_indicators;
