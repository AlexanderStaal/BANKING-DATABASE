SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionsHistory]
(
    [TransactionId] [INT] NOT NULL,
    [AccountFromNumber] [INT] NULL,
    [AccountToNumber] [INT] NULL,
    [TransactionTime] [DATETIME] NULL,
    [AmountDebit] [FLOAT] NULL,
    [FromAccountBalance] [FLOAT] NULL,
    [ToAccountBalance] [FLOAT] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TransactionsHistory] ADD PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/* -------- LOAD TEST DATA -------

DECLARE @count INT
SET @count = 1
   
DECLARE @transactionId INT = 0;
DECLARE @fromAccountNumber INT = '1001';
DECLARE @toAccountNumber INT = '1002';
DECLARE @transactionTime DATETIME = null;
DECLARE @amountDebit FLOAT = 10;
DECLARE @fromAccountBalance FLOAT = 200;
DECLARE @toAccountBalance FLOAT = 50;

WHILE @count <= 10
BEGIN
INSERT INTO TransactionsHistory ( TransactionId, AccountFromNumber, AccountToNumber, TransactionTime, AmountDebit, FromAccountBalance, ToAccountBalance) 
VALUES ( @transactionId + @count, @fromAccountNumber + @count, @toAccountNumber + + @count , GETDATE() + @count, @amountDebit  + @count , @fromAccountBalance + @count, @toAccountBalance + @count)
   SET @count = @count + 1
END
*/

drop table TransactionsHistory