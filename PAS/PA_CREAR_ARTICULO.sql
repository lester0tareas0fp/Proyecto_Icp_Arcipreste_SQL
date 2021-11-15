USE [ARCIPRESTE1]
GO
/****** Object:  StoredProcedure [dbo].[PA_CREAR_ARTICULO]    Script Date: 12/11/2021 14:34:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
  /*-----------------------------------------------------------------------------------------------------------------------------------------------------

	NOMBRE DEL PROCEDIMIENTO:	[PA_CREAR_ARTICULO]
	FECHA DE CREACIÓN: 		05/11/2021		
	AUTOR:				LESTER ARELLANO

	FUNCIONAMIENTO:			CREA UN ARTICULO EN LA TABLA ARTICULOS

------------------------------------------------------------------------------------------------------------------------------------------------------*/


	
ALTER PROCEDURE [dbo].[PA_CREAR_ARTICULO] 
(

	@ARTICULO VARCHAR(50),
	@DESCRIPCION VARCHAR(50),
	@FABRICANTE VARCHAR(50),
	@PESO DECIMAL(18,2),
	@LARGO DECIMAL(18,2),
	@ANCHO DECIMAL(18,2),
	@ALTO DECIMAL(18,2),
	@PRECIO DECIMAL(18,2),
	
	@INVOKER INT,
	@USUARIO VARCHAR(20),
	@CULTURA VARCHAR(5),

	@ID_ARTICULO INT OUTPUT,
	@RETCODE INT OUTPUT,
	@MENSAJE VARCHAR(1000) OUTPUT
)
AS

	BEGIN TRY

		-- VALIDACIONES
		-- OPERACIONES
		-- MENAJES

		IF @DESCRIPCION IS NULL OR @DESCRIPCION = ''
		BEGIN
		
			SET @RETCODE = 2
			SET @MENSAJE = 'El parámetro descripción no puede ser nulo o vacío'	
			RETURN @RETCODE
		END

		IF EXISTS(SELECT ID_ARTICULO FROM ARTICULO WHERE DESCRIPCION = @DESCRIPCION)
		BEGIN
		
			SET @RETCODE = 2
			SET @MENSAJE = 'No se pueden insertar artículos repetidos'	
			RETURN @RETCODE
		END

		INSERT INTO ARTICULO
		(
			ARTICULO,
			DESCRIPCION,
			FABRICANTE,
			PESO,
			LARGO,
			ANCHO,
			ALTO,
			PRECIO,
			ID_ESTADO
		)
		VALUES
		(
			UPPER(@ARTICULO),
			UPPER(@DESCRIPCION),
			UPPER(@FABRICANTE),
			@PESO,
			@LARGO,
			@ANCHO,
			@ALTO,
			@PRECIO,
			1
		)
		
		SET @ID_ARTICULO = SCOPE_IDENTITY()

		PRINT @ARTICULO
		SET @RETCODE = 10
		SET @MENSAJE = 'Se ha creado el artículo correctamente'
		RETURN
	END TRY
	BEGIN CATCH
	END CATCH
	
