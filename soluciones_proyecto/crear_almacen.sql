INSERT INTO ALMACEN VALUES ('MECO 3')

SELECT * FROM ALMACEN

DECLARE @N INT = (SELECT MAX(ID_ALMACEN) FROM ALMACEN )

PRINT @N