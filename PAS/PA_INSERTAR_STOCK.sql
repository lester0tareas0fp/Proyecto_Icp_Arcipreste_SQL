USE [ARCIPRESTE1]
GO
/****** Object:  StoredProcedure [dbo].[PA_CREAR_USUARIO]    Script Date: 12/11/2021 14:34:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
  /*-----------------------------------------------------------------------------------------------------------------------------------------------------

	NOMBRE DEL PROCEDIMIENTO:	[PA_INSERTAR_STOCK]
	FECHA DE CREACIÓN: 		18/11/2021		
	AUTOR:				LESTER ARELLANO

	FUNCIONAMIENTO:			AGREGA STOCK EN LA TABLA STOCK ELEGIDA

------------------------------------------------------------------------------------------------------------------------------------------------------*/


	
ALTER PROCEDURE [dbo].[PA_INSERTAR_STOCK] 
(
	@ID_STOCK INT,
	@CANTIDAD INT,
	
	@INVOKER INT,
	@USUARIO_R VARCHAR(20),
	@CULTURA VARCHAR(5),

	@RETCODE INT OUTPUT,
	@MENSAJE VARCHAR(1000) OUTPUT
)
AS

	BEGIN TRY

		-- VALIDACIONES
		-- OPERACIONES
		-- MENAJES

		IF @ID_STOCK IS NULL OR  @ID_STOCK = 0
		BEGIN
		
			SET @RETCODE = 2
			SET @MENSAJE = 'El parámetro stock no puede ser nulo o cero'	
			RETURN @RETCODE
		END

		IF @CANTIDAD IS NULL OR @CANTIDAD = 0
		BEGIN
		
			SET @RETCODE = 2
			SET @MENSAJE = 'El parámetro cantidad no puede ser nulo o cero'	
			RETURN @RETCODE
		END

		IF NOT EXISTS(SELECT * FROM STOCK WHERE ID_STOCK = @ID_STOCK)
		BEGIN
		
			SET @RETCODE = 2
			SET @MENSAJE = 'Este stock no existe en la base de datos'	
			RETURN @RETCODE
		END

		DECLARE @ESTADO INT = (SELECT ID_ESTADO FROM ARTICULO WHERE ID_ARTICULO = (SELECT ID_ARTICULO FROM STOCK WHERE ID_STOCK = 1))

		IF @ESTADO != 1
		BEGIN
		
			SET @RETCODE = 2
			SET @MENSAJE = 'No puede agregarse stock en este artículo'	
			RETURN @RETCODE
		END

		DECLARE @STOCK_ACTUAL INT = (SELECT CANTIDAD FROM STOCK WHERE ID_STOCK = @ID_STOCK)

		
		UPDATE STOCK SET CANTIDAD = @CANTIDAD + @STOCK_ACTUAL WHERE ID_STOCK = @ID_STOCK

		SET @RETCODE = 10
		SET @MENSAJE = 'Se ha creado el usuario correctamente'
		RETURN
	END TRY
	BEGIN CATCH
	END CATCH
	
