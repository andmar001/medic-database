USE [medicdb]
GO
/****** Object:  StoredProcedure [dbo].[sp_recetas_getall]    Script Date: 27/12/2023 12:22:17 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Antonio Andrade Mares
-- Create date: 19/12/2023
-- Description:	sp para obtener todos las recetas
-- =============================================
ALTER PROCEDURE [dbo].[sp_recetas_getall]
AS
BEGIN
	BEGIN TRY
		SELECT 
			rec.uIdReceta as uIdReceta,
			pac.uIdPaciente as uIdPaciente,
			rec.fechaReceta as fechaReceta,
			rec.medicamento as medicamento,
			rec.dosificacion as dosis
		FROM Recetas rec
			INNER JOIN Pacientes pac ON rec.idPaciente = pac.idPaciente 		
		WHERE rec.estatus = 1
	END TRY
	BEGIN CATCH 
		SELECT 'Error el obtener las recetas'
	END CATCH
END
