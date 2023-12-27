USE [medicdb]
GO

/****** Object:  StoredProcedure [dbo].[sp_glucosa_getall]    Script Date: 27/12/2023 12:24:19 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Antonio Andrade Mares
-- Create date: 26/12/2023
-- Description:	sp para obtener todos los registros de 
-- =============================================
CREATE PROCEDURE [dbo].[sp_glucosa_getall] 

AS
BEGIN
	BEGIN TRY
		SELECT	
			glu.uIdLectura,
			pac.uIdPaciente,
			glu.fechaLectura,
			glu.nivelGlucosa
		FROM Glucosa glu
			INNER JOIN Pacientes pac on glu.idPaciente = pac.idPaciente 
		WHERE glu.estatus = 1
	END TRY
	BEGIN CATCH
		SELECT 'Error el obtener las lecturas de glucosa'
	END CATCH
END
GO


