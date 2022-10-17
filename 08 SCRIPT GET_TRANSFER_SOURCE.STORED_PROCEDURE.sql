If EXISTS (SELECT *
FROM sys.objects
WHERE object_id = object_id(N'[dbo].[GetTransferSource]'))
DROP PROCEDURE [dbo].[GetTransferSource]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetTransferSource]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT accountNumber, accountName
    FROM Account
END
GO
