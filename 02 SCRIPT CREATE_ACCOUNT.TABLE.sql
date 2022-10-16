SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account]
(
    [Id] int NOT NULL IDENTITY,
    [AccountNumber] [int] NOT NULL,
    [AccountName] [varchar] (32) NULL,
    [Balance] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/* -------- LOAD TEST DATA -------

DECLARE @count INT;
SET @count = 1;
   
DECLARE @AccountNumber INT = 1001;
DECLARE @AccountName VARCHAR (32) = 'Account';
DECLARE @Balance FLOAT = 100;

WHILE @count <= 25
BEGIN

INSERT INTO Account (AccountNumber, AccountName, Balance) 
VALUES ( @AccountNumber + @count, @AccountName + CAST(@count AS varchar(32)), @Balance + @count)
   SET @count = @count + 1;
END;
*/
