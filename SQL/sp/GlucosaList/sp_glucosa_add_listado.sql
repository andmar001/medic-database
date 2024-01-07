USE [medicdb]
GO
/****** Object:  StoredProcedure [dbo].[sp_glucosa_add_listado]    Script Date: 07/01/2024 12:31:05 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Antonio Andrade Mares
-- Create date: 25/12/2023
-- Description:	sp para alta de glucosa

-- =============================================
ALTER PROCEDURE [dbo].[sp_glucosa_add_listado] 
	@uIdPaciente uniqueidentifier,
	@json varchar(MAX)

AS
BEGIN
	DECLARE @error smallint = 0, @idPaciente int, @resultado int, @errorMessage varchar(max)

	SET @resultado = 1
	SET @error = 0

	BEGIN TRY
		BEGIN TRANSACTION
				IF @uIdPaciente IS NULL
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

					IF @error = 0 
						BEGIN
							BEGIN
								DECLARE @TablaTemporal TABLE
								(
									--uIdGlucosa UNIQUEIDENTIFIER,
									FechaLectura DATE,
									NivelGlucosa INT
							
								);

								INSERT INTO @TablaTemporal ( FechaLectura, NivelGlucosa)
								SELECT  FechaLectura, NivelGlucosa
								FROM OPENJSON(@json)
								WITH
								(
									FechaLectura DATE '$.FechaLectura',
									NivelGlucosa INT '$.NivelGlucosa'
								)
							
								INSERT INTO Glucosa(uIdLectura,idPaciente, fechaLectura,nivelGlucosa,estatus)
								SELECT NEWID(), @idPaciente, FechaLectura, NivelGlucosa,1
								FROM @TablaTemporal
							
							END 
							
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
			BEGIN
				COMMIT TRANSACTION
			END
		ELSE
			BEGIN
				ROLLBACK TRANSACTION
			END

	END TRY
	BEGIN CATCH 
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION
			END

		SET @resultado = 1
		SET @errorMessage = 'El paciente no existe o no está activo' + ERROR_MESSAGE()

	END CATCH 
	
	SELECT @errorMessage AS errorMessage
	SELECT @resultado AS resultado 

END
