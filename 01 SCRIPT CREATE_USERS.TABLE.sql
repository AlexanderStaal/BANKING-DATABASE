SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users]
(
	[UserId] [CHAR] (32) NOT NULL,
	[FirstName] [CHAR] (32) NULL,
	[LastName] [CHAR] (32) NULL,
	[UserRole] [CHAR] (32) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[Users] ADD PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/* -------- LOAD TEST DATA -------

INSERT INTO Users ( UserId, FirstName, LastName, UserRole) VALUES ( 'Elon', 'Elon', 'Musk', 'app-admin')
INSERT INTO Users ( UserId, FirstName, LastName, UserRole) VALUES ( 'Guest', '', '', 'app-user')
INSERT INTO Users ( UserId, FirstName, LastName, UserRole) VALUES ( 'Developer', '', '', 'app-developer')

*/
