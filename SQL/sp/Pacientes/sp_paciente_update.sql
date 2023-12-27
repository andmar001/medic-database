USE [medicdb]
GO

/****** Object:  StoredProcedure [dbo].[sp_paciente_update]    Script Date: 27/12/2023 12:18:29 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Antonio Andrade Mares
-- Create date: 19/12/2023
-- Description:	sp para actualizar paciente
-- =============================================
CREATE PROCEDURE [dbo].[sp_paciente_update] 
	@uIdPaciente uniqueidentifier,
	@nombre varchar(50),
	@fechaNacimiento datetime, 
	@genero varchar(10)
AS
BEGIN
	DECLARE @error smallint = 0, @idPaciente int, @resultado int, @errorMessage varchar(max)
	
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

			--- Update
			IF @error = 0
				BEGIN
					
					UPDATE Pacientes 
					SET
						Nombre = @nombre,
						FechaNacimiento = @fechaNacimiento,
						Genero = @genero
					WHERE 
						uIdPaciente = @uIdPaciente
					
					SET @resultado = 0
					SET @errorMessage = @idPaciente
				END
			ELSE
				BEGIN
					IF @idPaciente = -1
						BEGIN
							SET @resultado = -2
							SET @errorMessage = 'El paciente no existe o no está activo'
						END
				END

		IF @resultado = 0
			COMMIT TRANSACTION
		ELSE 
			ROLLBACK TRANSACTION

	END TRY
	BEGIN CATCH 
		SET @resultado = -3
		SET @errorMessage = 'Error en la actualización de paciente: ' + ERROR_MESSAGE()
		ROLLBACK TRANSACTION
	END CATCH

	SELECT @errorMessage AS errorMessage
	SELECT @resultado AS resultado

END
GO


