
DECLARE @ID_ARTICULO INT = (SELECT ID_ARTICULO FROM STOCK WHERE ID_STOCK = 1)

PRINT @ID_ARTICULO

SELECT ID_ESTADO FROM ARTICULO WHERE ID_ARTICULO = (SELECT ID_ARTICULO FROM STOCK WHERE ID_STOCK = 1)

UPDATE STOCK SET CANTIDAD = @CANTIDAD WHERE ID_STOCK = @ID_STOCK

DECLARE @STOCK_ACTUAL INT = (SELECT CANTIDAD FROM STOCK WHERE ID_STOCK = 1) + 5

PRINT @STOCK_ACTUAL