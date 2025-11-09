--SELECT distinct(cast(TextData as nvarchar(max))),StartTime ,LoginName
--FROM    sys.fn_trace_gettable(CONVERT(VARCHAR(150), 
--( SELECT TOP 1 f.[value]
--  FROM    sys.fn_trace_getinfo(NULL) f
--  WHERE   f.property = 2
--   )), DEFAULT) T
-- JOIN sys.trace_events TE ON T.EventClass = TE.trace_event_id
--WHERE Error=18456 AND CONVERT(DATE,StartTime)=CONVERT(DATE,GETDATE())


WITH CTE_Logins (ErrorMsg,StartTime,LoginName,AppName,RN)
AS 
(

	SELECT 
		distinct(cast(TextData as nvarchar(max))),
		StartTime ,
		LoginName,
		ApplicationName,
		ROW_NUMBER() OVER (PARTITION BY LoginName ORDER BY StartTime DESC) AS rn
	FROM    sys.fn_trace_gettable(CONVERT(VARCHAR(150), 
	( SELECT TOP 1 f.[value]
	FROM    sys.fn_trace_getinfo(NULL) f
	WHERE   f.property = 2
	   )), DEFAULT) T
	JOIN sys.trace_events TE ON T.EventClass = TE.trace_event_id
	WHERE Error=18456 AND CONVERT(DATE,StartTime)=CONVERT(DATE,GETDATE())

)

SELECT *
FROM CTE_Logins
WHERE rn = 1 --and LoginName ='LS_ADXCTSQL'
ORDER BY [StartTime] DESC