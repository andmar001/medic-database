USE [medicdb]
GO

/****** Object:  Table [dbo].[PresionArterial]    Script Date: 27/12/2023 12:29:30 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PresionArterial](
	[LecturaID] [int] NOT NULL,
	[PacienteID] [int] NOT NULL,
	[FechaLectura] [date] NOT NULL,
	[Sistolica] [int] NOT NULL,
	[Diastolica] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LecturaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PresionArterial]  WITH CHECK ADD  CONSTRAINT [FK__PresionAr__Pacie__4222D4EF] FOREIGN KEY([PacienteID])
REFERENCES [dbo].[Pacientes] ([idPaciente])
GO

ALTER TABLE [dbo].[PresionArterial] CHECK CONSTRAINT [FK__PresionAr__Pacie__4222D4EF]
GO


