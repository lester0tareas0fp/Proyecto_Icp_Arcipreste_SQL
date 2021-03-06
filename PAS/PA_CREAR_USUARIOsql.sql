USE [ARCIPRESTE1]
GO
/****** Object:  StoredProcedure [dbo].[PA_CREAR_USUARIO]    Script Date: 18/11/2021 14:17:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
  /*-----------------------------------------------------------------------------------------------------------------------------------------------------

	NOMBRE DEL PROCEDIMIENTO:	[PA_CREAR_ARTICULO]
	FECHA DE CREACIÓN: 		12/11/2021		
	AUTOR:				LESTER ARELLANO

	FUNCIONAMIENTO:			CREA UN USUARIO EN LA TABLA USUARIOS

------------------------------------------------------------------------------------------------------------------------------------------------------*/


	
ALTER PROCEDURE [dbo].[PA_CREAR_USUARIO] 
(

	@USUARIO VARCHAR(50),
	@PASS VARCHAR(MAX),
	@EMAIL VARCHAR (30),
	@ID_PERFIL INT,
	
	@INVOKER INT,
	@USUARIOR VARCHAR(20),
	@CULTURA VARCHAR(5),

	@ID_USUARIO INT OUTPUT,
	@RETCODE INT OUTPUT,
	@MENSAJE VARCHAR(1000) OUTPUT
)
AS

	BEGIN TRY

		-- VALIDACIONES
		-- OPERACIONES
		-- MENSAJES

		IF @USUARIO IS NULL OR @USUARIO = ''
		BEGIN
		
			SET @RETCODE = 2
			SET @MENSAJE = 'El parámetro usuario no puede ser nulo o vacío'	
			RETURN @RETCODE
		END

		IF @PASS IS NULL OR @PASS = ''
		BEGIN
		
			SET @RETCODE = 2
			SET @MENSAJE = 'El parámetro pass no puede ser nulo o vacío'	
			RETURN @RETCODE
		END

		IF @EMAIL IS NULL OR @EMAIL = ''
		BEGIN
		
			SET @RETCODE = 2
			SET @MENSAJE = 'El parámetro email no puede ser nulo o vacío'	
			RETURN @RETCODE
		END

		IF @ID_PERFIL IS NULL OR @ID_PERFIL <= 0 or @ID_PERFIL >3
		BEGIN
		
			SET @RETCODE = 2
			SET @MENSAJE = 'El parámetro id_perfil debe de ser un número entre 1 y 3'	
			RETURN @RETCODE
		END

		IF EXISTS(SELECT ID_USUARIO FROM USUARIO WHERE USUARIO = @USUARIO)
		BEGIN
		
			SET @RETCODE = 2
			SET @MENSAJE = 'Ya existe un usuario con ese nombre'	
			RETURN @RETCODE
		END

		DECLARE @PASSHASH varbinary(max) = HASHBYTES('SHA2_256', @PASS )

		SET @PASS = convert(varchar(max), @PASSHASH , 2)

		INSERT INTO USUARIO
		(
			USUARIO,
			PASS,
			EMAIL,
			ID_PERFIL
		)
		VALUES
		(
			UPPER(@USUARIO),
			@PASS,
			UPPER(@EMAIL),
			@ID_PERFIL
		)
		
		SET @ID_USUARIO = SCOPE_IDENTITY()

		PRINT @USUARIO
		SET @RETCODE = 10
		SET @MENSAJE = 'Se ha creado el usuario correctamente'
		RETURN
	END TRY
	BEGIN CATCH
	END CATCH
	
