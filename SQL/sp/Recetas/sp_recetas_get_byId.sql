USE [medicdb]
GO

/****** Object:  StoredProcedure [dbo].[sp_recetas_get_byId]    Script Date: 27/12/2023 12:21:58 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Antonio Andrade Mares
-- Create date: 19/12/2023
-- Description:	sp para obtener recetas por id
-- =============================================
CREATE PROCEDURE [dbo].[sp_recetas_get_byId] 
	@uIdReceta uniqueidentifier
AS
BEGIN
	DECLARE @error smallint = 0, @idReceta int, @resultado int, @errorMessage varchar(max)

	BEGIN TRY
		IF(@uIdReceta IS NULL)
			BEGIN
				SET @idReceta = -1
				SET @error = @error + 1
			END
		ELSE 
			BEGIN
				SELECT @idReceta = COUNT(idReceta) FROM Recetas WHERE uIdReceta = @uIdReceta AND estatus = 1
					
				IF @idReceta = 0
					BEGIN
						SET @idReceta = -1
						SET @error = @error +1
					END
				ELSE
					BEGIN
						SET @idReceta = (SELECT idReceta FROM Recetas WHERE uIdReceta = @uIdReceta)
					END
			END

		IF @error = 0
			BEGIN
				SELECT 
					rec.uIdReceta AS uIdReceta,
					pac.uIdPaciente AS uIdPaciente,
					rec.fechaReceta AS fechaReceta,
					rec.medicamento AS medicamento,
					rec.dosificacion AS dosificacion
				FROM Recetas rec
					INNER JOIN Pacientes pac on rec.idPaciente = pac.idPaciente
				WHERE rec.uIdReceta = @uIdReceta AND rec.Estatus = 1 
			END
		ELSE
			BEGIN
				IF @idReceta =-1
					BEGIN
						SET @resultado = -2
						SET @errorMessage = 'Receta no encontrada'
					END
				END
	END TRY 
	BEGIN CATCH 
		SELECT 'Error el obtener recetas'
	END CATCH 
END
GO


