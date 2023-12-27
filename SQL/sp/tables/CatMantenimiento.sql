USE [medicdb]
GO

/****** Object:  Table [dbo].[CatMantenimiento]    Script Date: 27/12/2023 12:28:06 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CatMantenimiento](
	[IdMantenimiento] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[FechaInicioMantenimiento] [datetime] NOT NULL,
	[FechaFinMantenimiento] [datetime] NOT NULL,
	[FechaAnuncioMantenimiento] [datetime] NOT NULL,
	[Activo] [char](1) NOT NULL
) ON [PRIMARY]
GO


