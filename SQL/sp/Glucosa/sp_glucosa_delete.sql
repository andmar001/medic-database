USE [medicdb]
GO

/****** Object:  StoredProcedure [dbo].[sp_glucosa_delete]    Script Date: 27/12/2023 12:23:30 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Antonio Andrade Mares
-- Create date: 26/12/2023
-- Description:	sp para eliminar lectura de glucosa
-- =============================================
CREATE PROCEDURE [dbo].[sp_glucosa_delete] 
	@uIdLectura uniqueidentifier
AS
BEGIN
	DECLARE @error smallint = 0, @idLectura int, @resultado int, @errorMessage varchar(max)

	SET @resultado = 1
	SET @error = 0

	BEGIN TRY
		BEGIN TRANSACTION
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

			IF @error = 0
				BEGIN
					UPDATE Glucosa
					SET 
						estatus = 0
					WHERE uIdLectura = @uIdLectura

					SET @resultado = 0
					SET @errorMessage = @idLectura
				END
			ELSE
				BEGIN
					IF @idLectura =-1
						BEGIN
							SET @resultado = -2
							SET @errorMessage = 'Lectura de glucosa no válida'
						END
				END

		IF @resultado = 0
			COMMIT TRANSACTION
		ELSE 
			ROLLBACK TRANSACTION
	END TRY
	BEGIN CATCH 
		SET @resultado = -3
		SET @errorMessage = 'Ocurrio un error al eliminar la receta' + ERROR_MESSAGE()
		ROLLBACK TRANSACTION
	END CATCH

	SELECT @errorMessage AS errorMessage
	SELECT @resultado AS resultado

END
GO


