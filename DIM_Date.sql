;WITH DateCTE AS (
    SELECT CAST('2016-01-01' AS DATE) AS dt
    UNION ALL
    SELECT DATEADD(DAY, 1, dt) FROM DateCTE WHERE dt < '2020-12-31'
)
INSERT INTO dbo.Dim_Date (Date_Key, Full_Date, [Day], [Month], Month_Name, [Quarter], [Year], Is_Weekend)
SELECT
    CONVERT(INT, FORMAT(dt, 'yyyyMMdd')),
    dt,
    DAY(dt),
    MONTH(dt),
    DATENAME(MONTH, dt),
    DATEPART(QUARTER, dt),
    YEAR(dt),
    CASE WHEN DATEPART(WEEKDAY, dt) IN (1, 7) THEN 1 ELSE 0 END
FROM DateCTE
OPTION (MAXRECURSION 0);