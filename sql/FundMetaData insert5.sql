UPDATE dbo.Fund_Metadata
SET FundAge_Years = DATEDIFF(YEAR,LaunchDate,GETDATE());