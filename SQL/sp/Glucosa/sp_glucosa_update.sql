USE [medicdb]
GO

/****** Object:  StoredProcedure [dbo].[sp_glucosa_update]    Script Date: 27/12/2023 12:25:04 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Antonio Andrade Mares
-- Create date: 25/12/2023
-- Description:	sp para actualizar registro de glucosa
-- =============================================
CREATE PROCEDURE [dbo].[sp_glucosa_update] 
	@uIdLectura uniqueidentifier,
	@uIdPaciente uniqueidentifier,
	@fechaLectura datetime, 
	@nivelGlucosa int
AS
BEGIN
	DECLARE @error smallint = 0, @idPaciente int,@idLectura int, @resultado int, @errorMessage varchar(max)

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

			IF(@uIdLectura IS NULL)
				BEGIN
					SET @idLectura = -1
					SET @error = @error + 1
				END
			ELSE 
				BEGIN
					SELECT @idLectura = COUNT(idLectura) FROM Glucosa WHERE uIdLectura = @uIdLectura AND estatus = 1
					
					IF @idLectura = 0
						BEGIN
							SET @idLectura = -1
							SET @error = @error +1
						END
					ELSE
						BEGIN
							SET @idLectura = (SELECT idLectura FROM Glucosa WHERE uIdLectura = @uIdLectura)
						END
				END

			--- Update
			IF @error = 0
				BEGIN
					
					UPDATE Glucosa 
					SET
						idPaciente = @idPaciente,
						fechaLectura = @fechaLectura,
						nivelGlucosa = @nivelGlucosa
					WHERE 
						uIdLectura = @uIdLectura
					
					SET @resultado = 0
					SET @errorMessage = @idLectura
				END
			ELSE
				BEGIN
					IF @idPaciente = -1
						BEGIN
							SET @resultado = -2
							SET @errorMessage = 'El registro de glucosa no existe o no está activo'
						END
				END

		IF @resultado = 0
			COMMIT TRANSACTION
		ELSE 
			ROLLBACK TRANSACTION
	END TRY

	BEGIN CATCH 
		SET @resultado = -3
		SET @errorMessage = 'Error en la actualizacion de glucosa: ' + ERROR_MESSAGE()
		ROLLBACK TRANSACTION
	END CATCH

	SELECT @errorMessage AS errorMessage
	SELECT @resultado AS resultado

END

GO


