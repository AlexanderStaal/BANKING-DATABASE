If EXISTS (SELECT *
FROM sys.objects
WHERE object_id = object_id(N'[dbo].[TransferFunds]'))
DROP PROCEDURE [dbo].[TransferFunds]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].TransferFunds
    @accountFromNumber INT NULL,
    @accountToNumber INT NULL,
    @amount DOUBLE PRECISION
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @return_value VARCHAR(25)
    DECLARE @accountFrombalance DOUBLE PRECISION
    DECLARE @accountTobalance DOUBLE PRECISION
    DECLARE @ErrorMsg NVARCHAR(4000)
    DECLARE @ErrSeverity INT
    DECLARE @ErrState INT
    DECLARE @TransactionId INT

    SET @accountFrombalance = (SELECT balance FROM account WHERE accountNumber = @accountFromNumber)
    SET @accountTobalance = (SELECT balance FROM account WHERE accountNumber = @accountToNumber)

    IF @accountFrombalance < @amount 
    BEGIN
        SET @return_value = 'insufficient holdings'
    END
    ELSE
        BEGIN
            BEGIN TRY  
                    BEGIN TRANSACTION
                        SET @accountFrombalance = @accountFrombalance - @amount
                        SET @accountTobalance = @accountTobalance + @amount
                    
                        UPDATE account SET balance = @accountFrombalance WHERE accountNumber = @accountFromNumber
                        UPDATE account SET balance = @accountTobalance WHERE accountNumber = @accountToNumber

                        SET @TransactionId = (SELECT MAX(TransactionId) + 1 FROM [dbo].[TransactionsHistory])

                        INSERT INTO [dbo].[TransactionsHistory]
                                    (TransactionId, AccountFromNumber, AccountToNumber, TransactionTime, AmountDebit, FromAccountBalance, ToAccountBalance)
                        VALUES
                                    (@TransactionId, @accountFromNumber, @accountToNumber, GETDATE(), @amount, @accountFrombalance, @accountTobalance)   
                                               
                    COMMIT TRANSACTION                  
                END TRY
                BEGIN CATCH
                        ROLLBACK TRANSACTION
                END CATCH

            IF @@error = 0
                        BEGIN
                SET @return_value = 'transfer complited'
            END 
                    ELSE
                        BEGIN
                SET @return_value = 'transfer failed'
            END
        END

        SELECT @return_value as 'Return value'
        
    END
GO