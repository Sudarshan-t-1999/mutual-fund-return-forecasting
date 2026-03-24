WITH AllNAVs AS
(
    SELECT 'Motilal Oswal Midcap fund' AS FundName, [Date], NAV
    FROM dbo.Motilal_NAV
    UNION ALL
    SELECT 'Edelweiss Midcap fund' AS FundName, [Date], NAV
    FROM dbo.Edelweiss_NAV
),
MonthEnds AS 
(
    SELECT
        FundName, 
        FORMAT([Date],'yyyy-MM') AS YearMonth,
        MAX([Date]) AS MonthEndDate
    FROM AllNAVs
    GROUP BY FundName, FORMAT([Date],'yyyy-MM')
),
MonthEndNAVs AS
(
    SELECT m.FundName,m.YearMonth,m.MonthEndDate, a.NAV
    FROM MonthEnds m
    JOIN AllNAVs a ON 
    a.FundName=m.FundName AND a.[Date]=m.MonthEndDate
),
WithLags AS
(
    SELECT 
        FundName,
        YearMonth,
        MonthEndDate,
        NAV,
        LAG(NAV) OVER (ORDER BY MonthEndDate ASC) AS Prev_NAV
    FROM MonthEndNAVs
)
SELECT 
    FundName,
    YearMonth, 
    MonthEndDate, 
    NAV,
    Prev_NAV,
    ROUND(1.0 * (NAV / Prev_NAV - 1) * 100,2) AS Monthly_Returns
FROM WithLags
ORDER BY FundName, MonthEndDate DESC;