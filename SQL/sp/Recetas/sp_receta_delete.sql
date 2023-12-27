USE [medicdb]
GO
/****** Object:  StoredProcedure [dbo].[sp_receta_delete]    Script Date: 27/12/2023 12:21:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Antonio Andrade Mares
-- Create date: 19/12/2023
-- Description:	sp para eliminar recetas
-- =============================================
ALTER PROCEDURE [dbo].[sp_receta_delete]
	@uIdReceta uniqueidentifier
AS
BEGIN
	DECLARE @error smallint = 0, @idReceta int, @resultado int, @errorMessage varchar(max)

	SET @resultado = 1
	SET @error = 0

	BEGIN TRY
		BEGIN TRANSACTION
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
					UPDATE Recetas
					SET 
						estatus = 0
					WHERE uIdReceta = @uIdReceta

					SET @resultado = 0
					SET @errorMessage = @idReceta
				END
			ELSE
				BEGIN
					IF @idReceta =-1
						BEGIN
							SET @resultado = -2
							SET @errorMessage = 'Receta no válida'
						END
				END

		IF @resultado = 0
			COMMIT TRANSACTION
		ELSE 
			ROLLBACK TRANSACTION
	END TRY
	
	BEGIN CATCH 
		SET @resultado = -3
		SET @errorMessage = 'Ocurrio un error al eliminar la receta'
		ROLLBACK TRANSACTION
	END CATCH

	SELECT @errorMessage AS errorMessage
	SELECT @resultado AS resultado

END
