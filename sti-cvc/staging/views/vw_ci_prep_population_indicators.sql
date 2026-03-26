USE emtct4
GO

CREATE OR ALTER VIEW staging.vw_ci_general_indicators AS 

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
'sQCwJFlb6TA','kOUVR2QmRiX','pFrRKO0QXE8','o3b428Othqr','zpStPPIz0jy',
'rzlOGLNUUsX','wdgeDGAW0L2','Oa1GU8MMOrW','Wc3HqMLks8d','txG10LrLagM',
'z46XtqLQsqg','epsfU9gXeKT','A0gEhJXHVFq','W3qfGxV4L8S','ydmEU7ZDsoq',
'AmYZHNRerfg','NNLGYkqMNzf','QXgwiQY2Ig7','EqP5ZzUHFk7','p7bjVvAH7RH',
'r0y7wxl5WkV','IW3QdHcViNO','vUeQsW4bA3x','wkDybKA7sNB','m50Qthik0f1',
'wmhy2G3KTy0','joUfcVapwWo','y776CjW4dOL','Oxks9QfnUXm','tEbgFurUehO',
'tW6R8chDidO','I2BuirBmWK6','zKXNWMaxoH1','i7MZUpBG2Uj','CEiEtMyOd7W',
'Bpv1sEPw8uj','Il5ZQTYKf8w','NBFMna7oP5S','K4oazPMP7a4','G6aLoIYG1mg',
'vNWf2wAs6EA','VPSsEAzt9qF','kwduyt4tjvC','RV7iG5zbdW8','o7IB0fevYnJ'
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
SELECT TOP 1000 * FROM staging.vw_ci_prep_population_indicators;
