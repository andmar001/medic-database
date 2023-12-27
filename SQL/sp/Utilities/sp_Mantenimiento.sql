USE [medicdb]
GO
/****** Object:  StoredProcedure [dbo].[sp_Mantenimiento]    Script Date: 27/12/2023 12:27:43 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[sp_Mantenimiento]

AS
BEGIN
		SET NOCOUNT OFF;
		DECLARE @FechaServer AS DATETIME;
		SET @FechaServer = SYSDATETIME();

		SELECT
			CASE
				WHEN @FechaServer < m.FechaInicioMantenimiento THEN 'Aviso'
				ELSE 'Mantenimiento'
			END AS Tipo,
			m.Descripcion AS Descripcion,
			m.FechaInicioMantenimiento AS FechaInicio
		FROM CatMantenimiento AS m
		WHERE @FechaServer >= m.FechaAnuncioMantenimiento
		AND @FechaServer <= m.FechaFinMantenimiento AND m.Activo = 1
END
