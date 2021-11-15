declare @usuario varchar(max) ='ALBERTO'
declare @codigo varbinary(max) = HASHBYTES('SHA2_256', @USUARIO)

DECLARE @PASS VARCHAR(MAX) = convert(varchar(max), @codigo , 2)

DECLARE @EMAIL VARCHAR(30) = CONCAT(@USUARIO,' ', @USUARIO, '.COM')

print @codigo print @usuario

INSERT INTO USUARIO(USUARIO, PASS, EMAIL, ID_PERFIL) VALUES (@USUARIO, @PASS , @EMAIL, 1 )
