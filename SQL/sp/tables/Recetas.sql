USE [medicdb]
GO

/****** Object:  Table [dbo].[Recetas]    Script Date: 27/12/2023 12:29:50 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Recetas](
	[idReceta] [int] IDENTITY(1,1) NOT NULL,
	[uIdReceta] [uniqueidentifier] NOT NULL,
	[idPaciente] [int] NOT NULL,
	[fechaReceta] [date] NOT NULL,
	[medicamento] [nvarchar](50) NOT NULL,
	[dosificacion] [int] NOT NULL,
	[estatus] [bit] NOT NULL,
 CONSTRAINT [PK__Recetas__03D077B81F469619] PRIMARY KEY CLUSTERED 
(
	[idReceta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Recetas]  WITH CHECK ADD  CONSTRAINT [FK__Recetas__Pacient__3F466844] FOREIGN KEY([idPaciente])
REFERENCES [dbo].[Pacientes] ([idPaciente])
GO

ALTER TABLE [dbo].[Recetas] CHECK CONSTRAINT [FK__Recetas__Pacient__3F466844]
GO


