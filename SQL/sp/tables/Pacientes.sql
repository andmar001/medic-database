USE [medicdb]
GO

/****** Object:  Table [dbo].[Pacientes]    Script Date: 27/12/2023 12:29:09 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Pacientes](
	[idPaciente] [int] IDENTITY(1,1) NOT NULL,
	[uIdPaciente] [uniqueidentifier] NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[fechaNacimiento] [date] NOT NULL,
	[genero] [nvarchar](10) NOT NULL,
	[estatus] [bit] NOT NULL,
 CONSTRAINT [PK__Paciente__9353C07F8E49EC50] PRIMARY KEY CLUSTERED 
(
	[idPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


