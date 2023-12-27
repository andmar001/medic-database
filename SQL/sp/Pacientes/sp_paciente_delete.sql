USE [medicdb]
GO

/****** Object:  StoredProcedure [dbo].[sp_paciente_delete]    Script Date: 27/12/2023 12:18:01 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Antonio Andrade Mares
-- Create date: 19/12/2023
-- Description:	sp para eliminar paciente
-- =============================================
CREATE PROCEDURE [dbo].[sp_paciente_delete] 
	-- Add the parameters for the stored procedure here
	@uIdPaciente uniqueidentifier
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
					IF((SELECT idPaciente FROM Pacientes WHERE uIdPaciente = @uIdPaciente AND Estatus = 1) > 0)
						BEGIN
							SET @idPaciente = (SELECT idPaciente FROM Pacientes WHERE uIdPaciente = @uIdPaciente)
						END
					ELSE
						BEGIN
							SET @idPaciente = -1
							SET @error = @error + 1
						END
				END

			--- Update
			IF @error = 0
				BEGIN
					UPDATE Pacientes 
					SET
						Estatus = 0
					WHERE 
						uIdPaciente = @uIdPaciente

					SET @resultado = 0
					SET @errorMessage = @idPaciente
				END
			ELSE
				BEGIN
					IF @idPaciente =-1
						BEGIN
							SET @resultado = -2
							SET @errorMessage = 'Paciente no válido'
						END
				END

		IF @resultado = 0
			COMMIT TRANSACTION
		ELSE 
			ROLLBACK TRANSACTION

	END TRY
	BEGIN CATCH 
		SET @resultado = -3
		SET @errorMessage = 'Ocurrio un error al eliminar el paciente'
		ROLLBACK TRANSACTION
	END CATCH

	SELECT @errorMessage AS errorMessage
	SELECT @resultado AS resultado

END
GO
