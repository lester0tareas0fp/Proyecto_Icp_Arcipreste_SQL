USE [ARCIPRESTE1]
GO
/****** Object:  StoredProcedure [dbo].[PA_CREAR_ARTICULO]    Script Date: 17/11/2021 13:26:58 ******/
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

	@ARTICULO VARCHAR(100),
	@DESCRIPCION VARCHAR(100),
	@FABRICANTE VARCHAR(100),
	@PESO DECIMAL(18,2),
	@LARGO DECIMAL(18,2),
	@ANCHO DECIMAL(18,2),
	@ALTO DECIMAL(18,2),
	@PRECIO DECIMAL(18,2),
	@NOMBRE_IMAGEN VARCHAR(500),
	@IMAGEN VARCHAR(MAX),
	@FORMATO VARCHAR(10),
	
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
		-- MENSAJES

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
			ID_ESTADO_ARTICULO
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

		INSERT INTO IMAGEN
		(
			ID_ARTICULO,
			NOMBRE_IMAGEN,
			IMAGEN,
			FORMATO
		)
		VALUES
		(
			@ID_ARTICULO,
			UPPER(@NOMBRE_IMAGEN),
			@IMAGEN,
			@FORMATO
		)
			

		DECLARE @N_ALMACENES INT = (SELECT MAX(ID_ALMACEN) FROM ALMACEN)
		DECLARE @I INT = 1
		
		WHILE @I <= @N_ALMACENES 
		BEGIN
			IF EXISTS ( SELECT ID_ALMACEN FROM ALMACEN WHERE @I = ID_ALMACEN)
			BEGIN
				INSERT INTO STOCK VALUES (@I, @ID_ARTICULO, 0)
			END;
			SET @I = @I + 1
		END;

		SET @RETCODE = 10
		SET @MENSAJE = 'Se ha creado el artículo correctamente'
		RETURN
	END TRY
	BEGIN CATCH
	END CATCH
	
