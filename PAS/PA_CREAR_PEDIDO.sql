USE [ARCIPRESTE1]
GO
/****** Object:  StoredProcedure [dbo].[PA_ACTUALIZAR_ARTICULO]    Script Date: 26/11/2021 11:34:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
  /*-----------------------------------------------------------------------------------------------------------------------------------------------------

	NOMBRE DEL PROCEDIMIENTO:	[PA_CREAR_PEDIDO]
	FECHA DE CREACI?N: 		26/11/2021		
	AUTOR:				LESTER ARELLANO

	FUNCIONAMIENTO:			ACTUALIZA UN ARTICULO EN LA TABLA ARTICULOS Y LA IMAGEN EN TABLA IMAGEN

------------------------------------------------------------------------------------------------------------------------------------------------------*/


ALTER PROCEDURE [dbo].[PA_CREAR_PEDIDO] 
(
	@CALLE VARCHAR(30), 
	@NUMERO VARCHAR(30), 
	@PROVINCIA VARCHAR(42), 
	@POBLACION VARCHAR(50), 
	@CODIGO_POSTAL VARCHAR(5), 
	@TELEFONO INT,
	@CONTACTO VARCHAR(60),
	@ID_USUARIO INT,

	@INVOKER INT, 
	@USUARIO VARCHAR(12),
	@CULTURA VARCHAR(5), 

	@ID_PEDIDO INT OUTPUT, 
	@RETCODE INT OUTPUT, 
	@MENSAJE VARCHAR(1000) OUTPUT
)
AS

	BEGIN TRY

		-- VALIDACIONES
		-- OPERACIONES
		-- MENSAJES

		DECLARE @ID_DIRECCION INT

		IF EXISTS(SELECT ID_DIRECCION FROM DIRECCION WHERE ( @CALLE = CALLE AND   @NUMERO = NUMERO AND @PROVINCIA = PROVINCIA AND @POBLACION = POBLACION AND @CODIGO_POSTAL = CODIGO_POSTAL AND @TELEFONO = TELEFONO))
		BEGIN
		
			SET @ID_DIRECCION = (SELECT ID_DIRECCION FROM DIRECCION WHERE ( @CALLE = CALLE AND @NUMERO = NUMERO AND @PROVINCIA = PROVINCIA AND @POBLACION = POBLACION AND @CODIGO_POSTAL = CODIGO_POSTAL AND @TELEFONO = TELEFONO))
			
		END

		ELSE
		BEGIN 
			INSERT INTO 
				DIRECCION
				(
					CALLE, 
					NUMERO, 
					PROVINCIA, 
					POBLACION, 
					CODIGO_POSTAL, 
					TELEFONO
				) 
			VALUES 
				(
					@CALLE,
					@NUMERO, 
					@PROVINCIA,
					@POBLACION, 
					@CODIGO_POSTAL, 
					@TELEFONO
				)

			SET @ID_DIRECCION = SCOPE_IDENTITY()--(SELECT ID_DIRECCION FROM DIRECCION WHERE ( @CALLE = CALLE AND @NUMERO = NUMERO AND @PROVINCIA = PROVINCIA AND @POBLACION = POBLACION AND @CODIGO_POSTAL = CODIGO_POSTAL AND @TELEFONO = TELEFONO))
		END

		INSERT INTO
			PEDIDO
			(
				ID_DIRECCION,
				ID_USUARIO,
				FECHA,
				CONTACTO
			)
		VALUES
			(
				@ID_DIRECCION,
				@ID_USUARIO,
				GETDATE(),
				@CONTACTO
			)



		SET @ID_PEDIDO = SCOPE_IDENTITY()
		SET @RETCODE = 10
		SET @MENSAJE = 'Direcci?n del pedido y pedido creado'
		RETURN 
	END TRY
	BEGIN CATCH
	END CATCH