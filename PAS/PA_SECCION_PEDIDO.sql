USE [ARCIPRESTE1]
GO
/****** Object:  StoredProcedure [dbo].[PA_ACTUALIZAR_ARTICULO]    Script Date: 26/11/2021 11:34:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
  /*-----------------------------------------------------------------------------------------------------------------------------------------------------

	NOMBRE DEL PROCEDIMIENTO:	[PA_SECCION_PEDIDO]
	FECHA DE CREACI�N: 		23/11/2021		
	AUTOR:				LESTER ARELLANO

	FUNCIONAMIENTO:			ACTUALIZA UN ARTICULO EN LA TABLA ARTICULOS Y LA IMAGEN EN TABLA IMAGEN

------------------------------------------------------------------------------------------------------------------------------------------------------*/

ALTER PROCEDURE [dbo].[PA_SECCION_PEDIDO] 
(
	@ID_PEDIDO INT, 
	@ID_ARTICULO INT, 
	@CANTIDAD INT,

	@INVOKER INT, 
	@USUARIO VARCHAR(12),
	@CULTURA VARCHAR(5), 

	@ID_SECCION_PEDIDO INT OUTPUT, 
	@RETCODE INT OUTPUT, 
	@MENSAJE VARCHAR(1000) OUTPUT
)
AS

	BEGIN TRY

	DECLARE @ID_ESTADO_PEDIDO INT
	DECLARE @TOTAL_STOCK INT =  (SELECT SUM(CANTIDAD) FROM STOCK WHERE ID_ARTICULO = 1 GROUP BY ID_ARTICULO) 
	RETURN 
		IF (@TOTAL_STOCK > @CANTIDAD)
			BEGIN
				SET @ID_ESTADO_PEDIDO = 2
			END
		ELSE
			BEGIN	
				SET @ID_ESTADO_PEDIDO = 1			
				SELECT TOP 1 ID_ALMACEN FROM STOCK WHERE ID_ARTICULO = 1 ORDER BY  100 - CANTIDAD ASC
			END

			INSERT INTO 
					SECCION_PEDIDO
					(
						ID_PEDIDO,
						ID_ARTICULO,
						CANTIDAD,
						ID_ESTADO_PEDIDO
					)
					VALUES
					(
						@ID_PEDIDO,
						@ID_ARTICULO,
						@CANTIDAD,
						@ID_ESTADO_PEDIDO
					)
	END TRY
	BEGIN CATCH
	END CATCH