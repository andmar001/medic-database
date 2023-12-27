USE [medicdb]
GO

/****** Object:  StoredProcedure [dbo].[sp_paciente_add]    Script Date: 27/12/2023 12:16:54 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Antonio Andrade Mares
-- Create date: 19/12/2023
-- Description:	sp para alta de paciente
-- =============================================
CREATE PROCEDURE [dbo].[sp_paciente_add]
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
				IF @error = 0
					BEGIN
						INSERT INTO Pacientes(uIdPaciente, nombre,fechaNacimiento, genero, estatus)
						VALUES (NEWID(), @nombre, @fechaNacimiento, @genero,1)

						SET @idPaciente =  @@IDENTITY

						SET @resultado = 0
						SET @errorMessage = @idPaciente
					END
				
		IF @resultado = 0
			COMMIT TRANSACTION
		ELSE 
			ROLLBACK TRANSACTION

	END TRY
	BEGIN CATCH 
		SET @resultado = -3
		SET @errorMessage = 'Ocurrio un error al guardar el paciente'
		ROLLBACK TRANSACTION
	END CATCH

	SELECT @errorMessage AS errorMessage
	SELECT @resultado AS resultado

END
GO
