USE [medicdb]
GO

/****** Object:  StoredProcedure [dbo].[sp_Log_Error]    Script Date: 27/12/2023 12:25:56 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Log_Error]
  @Mensaje varchar(255),
  @StackTrace varchar(max),
  @MetodoLanzaError varchar(100) = NULL,
  @Data varchar(max) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO logError (logErrorMensaje, logErrorStackTrace, logErrorFuncionDetono, logErrorData, logErrorFecha)
	OUTPUT inserted.logErrorId as ID
	VALUES(@Mensaje, @StackTrace, @MetodoLanzaError, @Data, SYSDATETIME());
END
GO


