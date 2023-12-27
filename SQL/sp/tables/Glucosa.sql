USE [medicdb]
GO

/****** Object:  Table [dbo].[Glucosa]    Script Date: 27/12/2023 12:28:39 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Glucosa](
	[idLectura] [int] IDENTITY(1,1) NOT NULL,
	[uIdLectura] [uniqueidentifier] NOT NULL,
	[idPaciente] [int] NOT NULL,
	[fechaLectura] [date] NOT NULL,
	[nivelGlucosa] [int] NOT NULL,
	[estatus] [bit] NOT NULL,
 CONSTRAINT [PK__Glucosa__B421D4DCF61BB49A] PRIMARY KEY CLUSTERED 
(
	[idLectura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Glucosa]  WITH CHECK ADD  CONSTRAINT [FK__Glucosa__Pacient__44FF419A] FOREIGN KEY([idPaciente])
REFERENCES [dbo].[Pacientes] ([idPaciente])
GO

ALTER TABLE [dbo].[Glucosa] CHECK CONSTRAINT [FK__Glucosa__Pacient__44FF419A]
GO


