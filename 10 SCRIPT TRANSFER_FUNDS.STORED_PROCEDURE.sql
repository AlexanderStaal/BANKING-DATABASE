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
    @fromAccountNumber int NULL,
    @toAccountNumber int NULL,
    @amount double PRECISION
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @return_value varchar(25)
    DECLARE @fromAccountBalance double PRECISION
    DECLARE @toAccountBalance double PRECISION
    DECLARE @ErrorMsg nvarchar(4000)
    DECLARE @ErrSeverity int
    DECLARE @ErrState int
    DECLARE @TransactionId int

    SET @fromAccountBalance = (SELECT balance FROM account WHERE accountNumber = @fromAccountNumber)
    SET @toAccountBalance = (SELECT balance FROM account WHERE accountNumber = @toAccountNumber)

    IF @fromAccountBalance < @amount 
    BEGIN
        SET @return_value = 'insufficient holdings'
    END
    ELSE
        BEGIN
            BEGIN TRY  
                    BEGIN TRANSACTION
                        SET @fromAccountBalance = @fromAccountBalance - @amount
                        SET @toAccountBalance = @toAccountbalance + @amount
                    
                        UPDATE account SET balance = @fromAccountbalance WHERE accountNumber = @fromAccountNumber
                        UPDATE account SET balance = @toAccountBalance WHERE accountNumber = @toAccountNumber

                        SET @TransactionId = (SELECT MAX(TransactionId) + 1 FROM [dbo].[TransactionsHistory])

                        INSERT INTO [dbo].[TransactionsHistory]
                                    (TransactionId, FromAccountNumber, ToAccountNumber, TransactionTime, AmountDebit, FromAccountBalance, ToAccountBalance)
                        VALUES
                                    (@TransactionId, @fromAccountNumber, @toAccountNumber, GETDATE(), @amount, @fromAccountbalance, @toAccountbalance)   
                                               
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