USE ICPARCIPRESTE;

--TABLA 1.- ESTADO
CREATE TABLE ESTADO_ARTICULO(
	ID_ESTADO_ARTICULO INT CONSTRAINT PK_IDEST_EST PRIMARY KEY IDENTITY (1, 1) NOT NULL,
	ESTADO VARCHAR(15) NOT NULL
)

--TABLA 2.- ARTICULO
CREATE TABLE ARTICULO (
	ID_ARTICULO INT CONSTRAINT PK_IDART_ART PRIMARY KEY IDENTITY (1, 1) NOT NULL,
	ARTICULO VARCHAR (100) NOT NULL,
	DESCRIPCION VARCHAR (100),
	FABRICANTE VARCHAR (100),
	PESO DECIMAL (18,2) NOT NULL,
	LARGO DECIMAL (18,2) NOT NULL,
	ANCHO DECIMAL (18,2) NOT NULL,
	ALTO DECIMAL (18,2) NOT NULL,
	PRECIO DECIMAL (18,2) NOT NULL,
	ID_ESTADO_ARTICULO INT CONSTRAINT FK_IDEST_ART_EST FOREIGN KEY REFERENCES ESTADO_ARTICULO(ID_ESTADO_ARTICULO) ON DELETE SET NULL ON UPDATE CASCADE

)

--TABLA 3.- ALMACEN
CREATE TABLE ALMACEN(
	ID_ALMACEN INT CONSTRAINT PK_IDALM_ALM PRIMARY KEY IDENTITY (1, 1),
	NOMBRE_ALMACEN VARCHAR (30) NOT NULL
)

--TABLA 4.- STOCK
CREATE TABLE STOCK (
	ID_STOCK INT CONSTRAINT PK_IDSTO_STK PRIMARY KEY IDENTITY (1, 1) NOT NULL,
	ID_ALMACEN INT CONSTRAINT FK_IDALM_STK_ALM FOREIGN KEY REFERENCES ALMACEN(ID_ALMACEN) ON DELETE SET NULL ON UPDATE CASCADE,
	ID_ARTICULO INT CONSTRAINT FK_IDART_STK_ART FOREIGN KEY REFERENCES ARTICULO(ID_ARTICULO) ON DELETE SET NULL ON UPDATE CASCADE,
	CANTIDAD INT 
)


--TABLA 5.- IMAGEN
CREATE TABLE IMAGEN (
	ID_IMAGEN INT CONSTRAINT PK_IDIMG_IMG PRIMARY KEY IDENTITY (1, 1) NOT NULL,
	ID_ARTICULO INT CONSTRAINT FK_IDART_IMG_ART FOREIGN KEY REFERENCES ARTICULO(ID_ARTICULO) ON DELETE SET NULL ON UPDATE CASCADE,
	NOMBRE_IMAGEN VARCHAR (500) NOT NULL,
	IMAGEN VARCHAR (MAX) NOT NULL,
	FORMATO VARCHAR(10)
) 


--TABLA 6.- PERFIL
CREATE TABLE PERFIL (
	ID_PERFIL INT CONSTRAINT PK_IDPER_PER PRIMARY KEY IDENTITY (1, 1) NOT NULL,
	PERFIL VARCHAR(15) NOT NULL
)


--TABLA 7.- USUARIO
CREATE TABLE USUARIO (
	ID_USUARIO INT CONSTRAINT PK_IDUSR_USR PRIMARY KEY IDENTITY (1, 1) NOT NULL,
	USUARIO VARCHAR (50) NOT NULL,
	PASS VARCHAR (MAX) NOT NULL,
	EMAIL VARCHAR (30) NOT NULL,
	ID_PERFIL INT CONSTRAINT FK_IDPER_USR_PER FOREIGN KEY REFERENCES PERFIL(ID_PERFIL) ON DELETE SET NULL ON UPDATE CASCADE
)

--TABLA 8.-  DIRECCION
CREATE TABLE DIRECCION (
	ID_DIRECCION INT CONSTRAINT PK_IDDIR_DIR PRIMARY KEY IDENTITY (1, 1) NOT NULL,
	CALLE VARCHAR (30) NOT NULL,
	NUMERO VARCHAR (30) NOT NULL,
	PROVINCIA VARCHAR (42),
	POBLACION VARCHAR (50),
	CODIGO_POSTAL VARCHAR(5) NOT NULL,
	TELEFONO INT
)

--TABLA 9.-  DIRECCIONES DE USUARIO
-- CREATE TABLE DIRECCIONES_USUARIO(
-- 	ID_DIRECCION_USUARIO INT CONSTRAINT PK_IDDIRU_DIRU PRIMARY KEY IDENTITY (1, 1) NOT NULL,
-- 	ID_USUARIO INT CONSTRAINT FK_IDUSR_DIRU_USR FOREIGN KEY REFERENCES USUARIO(ID_USUARIO) ON DELETE SET NULL ON UPDATE CASCADE,
-- 	ID_DIRECCION INT CONSTRAINT FK_IDDIR_DIRU_DIR FOREIGN KEY REFERENCES DIRECCION(ID_DIRECCION) ON DELETE SET NULL ON UPDATE CASCADE
-- )

--TABLA 10.-  PEDIDO
CREATE TABLE PEDIDO(
	ID_PEDIDO INT CONSTRAINT PK_IDPED_PED PRIMARY KEY IDENTITY (1, 1) NOT NULL,
	ID_DIRECCION INT CONSTRAINT FK_IDDIR_PED_DIR FOREIGN KEY REFERENCES DIRECCION(ID_DIRECCION) ON DELETE SET NULL ON UPDATE CASCADE,
	ID_USUARIO INT CONSTRAINT FK_IDUSR_PED_USR FOREIGN KEY REFERENCES USUARIO(ID_USUARIO) ON DELETE SET NULL ON UPDATE CASCADE,
	FECHA DATETIME NOT NULL,
	CONTACTO VARCHAR (60)
)

--TABLA 11.- ESTADO_PEDIDO
CREATE TABLE ESTADO_PEDIDO(
	ID_ESTADO_PEDIDO INT CONSTRAINT PK_IDESTPED_ESTPED PRIMARY KEY IDENTITY (1, 1) NOT NULL,
	ESTADO_PEDIDO VARCHAR(10) 
)

--TABLA 12.-  SECCION_PEDIDO
CREATE TABLE SECCION_PEDIDO (
	ID_SECCION_PEDIDO INT CONSTRAINT PK_IDSEC_SEC PRIMARY KEY IDENTITY (1, 1) NOT NULL,
	ID_PEDIDO INT CONSTRAINT FK_IDPED_SEC_PED FOREIGN KEY REFERENCES PEDIDO(ID_PEDIDO) ON DELETE SET NULL ON UPDATE CASCADE,
	ID_ARTICULO INT CONSTRAINT FK_IDART_SEC_ART FOREIGN KEY REFERENCES ARTICULO(ID_ARTICULO) ON DELETE SET NULL ON UPDATE CASCADE,
	CANTIDAD INT,
	ID_ESTADO_PEDIDO INT CONSTRAINT FK_IDESTPED_SECPED_ESTPED FOREIGN KEY REFERENCES ESTADO_PEDIDO(ID_ESTADO_PEDIDO) ON DELETE SET NULL ON UPDATE CASCADE
)

--TABLA 13.-  ENVIO
CREATE TABLE ENVIO(
	ID_ENVIO INT CONSTRAINT PK_IDENV_ENV PRIMARY KEY IDENTITY (1, 1) NOT NULL,
	ID_PEDIDO INT CONSTRAINT FK_IDPED_ENV_PED FOREIGN KEY REFERENCES PEDIDO(ID_PEDIDO) ON DELETE SET NULL ON UPDATE CASCADE,
	FECHA_CREACION_ENVIO DATETIME NOT NULL
)

--TABLA 14.-  ENVIOS_ARTICULOS
CREATE TABLE ENVIOS_ARTICULOS(
	ID_ENVIO_ARTICULO INT CONSTRAINT PK_IDENVART_ENVART PRIMARY KEY IDENTITY (1, 1) NOT NULL,
	ID_ENVIO INT CONSTRAINT FK_IDENV_ENVART_ENV FOREIGN KEY REFERENCES ENVIO(ID_ENVIO) ON DELETE SET NULL ON UPDATE CASCADE,
	ID_ART  INT CONSTRAINT FK_IDART_ENVART_ART FOREIGN KEY REFERENCES ARTICULO(ID_ARTICULO) ON DELETE SET NULL ON UPDATE CASCADE,
	CANTIDAD_ARTICULO INT
)