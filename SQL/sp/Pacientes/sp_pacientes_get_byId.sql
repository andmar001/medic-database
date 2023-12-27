USE [medicdb]
GO

/****** Object:  StoredProcedure [dbo].[sp_pacientes_get_byId]    Script Date: 27/12/2023 12:18:52 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Antonio Andrade Mares
-- Create date: 19/12/2023
-- Description:	sp para obtener paciente por id
-- =============================================
CREATE PROCEDURE [dbo].[sp_pacientes_get_byId]
	@uIdPaciente uniqueidentifier
AS
BEGIN
	DECLARE @error smallint = 0, @idPaciente int, @resultado int, @errorMessage varchar(max)

	BEGIN TRY
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

		IF @error = 0
			BEGIN
				SELECT 
					uIdPaciente AS uIdPaciente,
					Nombre AS Nombre,
					FechaNacimiento AS FechaNacimiento,
					Genero AS Genero
				FROM Pacientes
				WHERE uIdPaciente = @uIdPaciente AND Estatus = 1
			END
		ELSE
			BEGIN
				IF @idPaciente =-1
					BEGIN
						SET @resultado = -2
						SET @errorMessage = 'Paciente no Encontrado'
					END
				END
	END TRY
	BEGIN CATCH
		SELECT 'Error el obtener pacientes'
	END CATCH

END
GO


