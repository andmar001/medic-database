USE [medicdb]
GO

/****** Object:  StoredProcedure [dbo].[sp_receta_update]    Script Date: 27/12/2023 12:21:29 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Antonio Andrade Mares
-- Create date: 19/12/2023
-- Description:	sp para actualizar receta
-- =============================================
CREATE PROCEDURE [dbo].[sp_receta_update] 
	@uIdReceta uniqueidentifier,
	@uIdPaciente uniqueidentifier,
	@fechaReceta datetime, 
	@medicamento varchar(100),
	@dosis int
AS
BEGIN	
	DECLARE @error smallint = 0, @idPaciente int,@idReceta int, @resultado int, @errorMessage varchar(max)
	
	SET @resultado = 1
	SET @error = 0

	BEGIN TRY
		BEGIN TRANSACTION
			-- Validación de usuario existente y activo
			IF(@uIdPaciente IS NULL)
				BEGIN
					SET @idPaciente = -1
					SET @error = @error + 1
				END
			ELSE 
				BEGIN
					SELECT @idPaciente = COUNT(idPaciente) FROM Pacientes WHERE uIdPaciente = @uIdPaciente AND estatus = 1
					
					IF @idPaciente = 0
						BEGIN
							SET @idPaciente = -1
							SET @error = @error +1
						END
					ELSE
						BEGIN
							SET @idPaciente = (SELECT idPaciente FROM Pacientes WHERE uIdPaciente = @uIdPaciente)
						END
				END

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

			--- Update
			IF @error = 0
				BEGIN
					
					UPDATE Recetas 
					SET
						idPaciente = @idPaciente,
						fechaReceta = @fechaReceta,
						medicamento = @medicamento,
						dosificacion = @dosis
					WHERE 
						uIdReceta = @uIdReceta
					
					SET @resultado = 0
					SET @errorMessage = @idReceta
				END
			ELSE
				BEGIN
					IF @idPaciente = -1
						BEGIN
							SET @resultado = -2
							SET @errorMessage = 'La receta no existe o no está activo'
						END
				END

		IF @resultado = 0
			COMMIT TRANSACTION
		ELSE 
			ROLLBACK TRANSACTION
	END TRY
	
	BEGIN CATCH 
		SET @resultado = -3
		SET @errorMessage = 'Error en la actualizacion de receta: ' + ERROR_MESSAGE()
		ROLLBACK TRANSACTION
	END CATCH

	SELECT @errorMessage AS errorMessage
	SELECT @resultado AS resultado

END
GO


