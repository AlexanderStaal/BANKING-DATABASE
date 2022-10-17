SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Refreshtoken]
(   
	[UserId] [VARCHAR] (32) NOT NULL,
	[TokenId] [VARCHAR] (32) NULL,
	[RefreshToken] [VARCHAR] (32) NOT NULL,
	[IsActive] [bit] DEFAULT (1)

) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[Refreshtoken] ADD PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO