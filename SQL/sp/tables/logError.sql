USE [medicdb]
GO

/****** Object:  Table [dbo].[logError]    Script Date: 27/12/2023 12:26:43 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[logError](
	[logErrorId] [int] IDENTITY(1,1) NOT NULL,
	[logErrorMensaje] [varchar](255) NULL,
	[logErrorStackTrace] [varchar](max) NULL,
	[logErrorFuncionDetono] [varchar](100) NULL,
	[logErrorData] [varchar](max) NULL,
	[logErrorFecha] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


