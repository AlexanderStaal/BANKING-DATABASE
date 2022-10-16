SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users]
(
	[Id] int NOT NULL IDENTITY,
	[UserId] [char] (32) NOT NULL,
	[FirstName] [car] (32) NULL,
	[LastName] [car] (32) NULL,
	[UserRole] [char] (32) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[Users] ADD PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/* -------- LOAD TEST DATA -------

INSERT INTO Users ( UserId, FirstName, LastName, UserRole) VALUES ( 'Elon', 'Elon', 'Musk', 'app-admin')
INSERT INTO Users ( UserId, FirstName, LastName, UserRole) VALUES ( 'Guest', '', '', 'app-user')
INSERT INTO Users ( UserId, FirstName, LastName, UserRole) VALUES ( 'Developer', '', '', 'app-developer')

*/
