If EXISTS (SELECT *
FROM sys.objects
WHERE object_id = object_id(N'[dbo].[CreateAccount]'))
DROP PROCEDURE [dbo].[CreateAccount]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateAccount]
    @accountName VARCHAR(32),
    @balance DOUBLE PRECISION
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @return_value varchar(45)
    DECLARE @accountNumber INT

    IF EXISTS (SELECT 1
    FROM Account
    where accountName = @accountName)
            BEGIN
        SET @return_value = 'Account name: ' + @accountName + ' already exists'
    END
    ELSE
        BEGIN
        SET @accountNumber = (SELECT MAX(AccountNumber) + 1
        FROM [dbo].[Account])
        INSERT INTO Account
            ( AccountNumber, AccountName, Balance)
        VALUES
            ( @accountNumber, @accountName, @balance)

        IF @@error = 0
                BEGIN
            SET @return_value = 'create account complited'
        END 
                ELSE
                BEGIN
            SET @return_value = 'create account failed'
        END
    END
    SELECT @return_value AS 'Return value'
END
GO
