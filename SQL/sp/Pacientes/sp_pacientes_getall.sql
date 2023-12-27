USE [medicdb]
GO

/****** Object:  StoredProcedure [dbo].[sp_pacientes_getall]    Script Date: 27/12/2023 12:19:20 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Antonio Andrade Mares
-- Create date: 19/12/2023
-- Description:	sp para obtener todos los pacientes
-- =============================================
CREATE PROCEDURE [dbo].[sp_pacientes_getall]
AS
BEGIN
	BEGIN TRY
		SELECT 
			uIdPaciente as uIdPaciente,
			Nombre AS Nombre,
			FechaNacimiento AS FechaNacimiento,
			Genero as Genero
		FROM Pacientes
		WHERE Estatus = 1

	END TRY
	BEGIN CATCH
		SELECT 'Error el obtener pacientes'
	END CATCH
END
GO


