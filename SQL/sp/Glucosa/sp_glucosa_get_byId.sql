USE [medicdb]
GO

/****** Object:  StoredProcedure [dbo].[sp_glucosa_get_byId]    Script Date: 27/12/2023 12:23:54 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Antonio Andrade Mares
-- Create date: 19/12/2023
-- Description:	sp para obtener lectura de glucosa por id
-- =============================================
CREATE PROCEDURE [dbo].[sp_glucosa_get_byId] 
	@uIdLectura uniqueidentifier
AS
BEGIN
	DECLARE @error smallint = 0, @idLectura int, @resultado int, @errorMessage varchar(max)

	BEGIN TRY
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
				SELECT	
					glu.uIdLectura,
					pac.uIdPaciente,
					glu.fechaLectura,
					glu.nivelGlucosa
				FROM Glucosa glu
					INNER JOIN Pacientes pac on glu.idPaciente = pac.idPaciente
				WHERE glu.uIdLectura = @uIdLectura and glu.estatus = 1
			END
		ELSE
			BEGIN
				IF @idLectura =-1
					BEGIN
						SET @resultado = -2
						SET @errorMessage = 'Lectura de glucosa no encontrada'
					END
				END
	END TRY
	BEGIN CATCH 
		SELECT 'Error el obtener lecturas de glucosa'
	END CATCH 
END
GO


