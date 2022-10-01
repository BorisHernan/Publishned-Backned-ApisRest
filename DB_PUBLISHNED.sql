SELECT user FROM dual;

SELECT * FROM SESSION_PRIVS;

-- Creaci�n de la tabla - Cliente
CREATE TABLE CLIENTE (
    IDCLI integer PRIMARY KEY,
    NOMCLI varchar2(45)  NOT NULL,
    APECLI varchar2(45)  NOT NULL,
    TELEFCLI char(9)  NOT NULL,
    EMAILCLI varchar2(45)  NOT NULL,
    DNICLI char(8)  NOT NULL,
    ESTACLI char(1)  NOT NULL
    );


-- Creaci�n de la tabla - EMPLEADO
CREATE TABLE EMPLEADO (
    IDEMP integer PRIMARY KEY,
    NOMEMP varchar2(45)  NOT NULL,
    APEEMP varchar2(45)  NOT NULL,
    TELEFEMP char(9)  NOT NULL,
    EMAILEMP varchar2(45)  NOT NULL,
    DNIEMP char(8)  NOT NULL,
    ESTAEMP char(1)  NOT NULL
) ;

-- Creaci�n de la tabla - PRODUCTO
CREATE TABLE PRODUCTO (
    IDPRO integer PRIMARY KEY,
    NOMPRO varchar2(40)  NOT NULL,
    MARPRO varchar2(40)  NOT NULL,
    DESPRO varchar2(40)  NOT NULL,
    STOPRO integer  NOT NULL,
    ESTPRO char (1) NOT NULL
) ;

-- Creaci�n de la tabla - PROVEEDOR
CREATE TABLE PROVEEDOR (
    IDPROV integer PRIMARY KEY,
    RUCPROV char(11)  NOT NULL,
    NOMPREPROV varchar2(40)  NOT NULL,
    DIRPROV varchar2(40)  NOT NULL,
    CELPROV char(9)  NOT NULL,
    ESTPROV char(1)  NOT NULL
) ;

-- Creaci�n de la tabla - COMPRA
CREATE TABLE COMPRA (
    IDCOM integer PRIMARY KEY,
    FECCOM date  NOT NULL,
    IDEMP integer  NOT NULL,
    IDPROV integer 
    );

-- Creaci�n de la tabla - COMPRA_DETALLE
CREATE TABLE COMPRA_DETALLE (
    IDCOMDET integer PRIMARY KEY,
    CANTCOMDET integer  NOT NULL,
    PRETOTCOMDET DECIMAL(8,2)  NOT NULL,
    PRECOMPRO DECIMAL(8,2) NOT NULL,
    IDCOM integer  NOT NULL,
    IDPRO integer  NOT NULL
) ;

-- Creaci�n de la tabla - SERVICIOS
CREATE TABLE SERVICIOS (
    IDSERV integer PRIMARY KEY,
    CATEG varchar2(85)  NOT NULL,
    NOM varchar2(85)  NOT NULL,
    PREC DECIMAL(5,2)  NOT NULL,
    ESTSEV char(1) NOT NULL
) ;

-- Creaci�n de la tabla - VENTA 
CREATE TABLE VENTA (
    IDVEN integer PRIMARY KEY,
    IDCLI integer  NOT NULL,
    IDEMP integer  NOT NULL,
    FECVEN date  NOT NULL,
    ESTVENT char(1)  NOT NULL,
    PRETOTVEN DECIMAL(8,2)  NOT NULL
) ;

-- Creaci�n de la tabla - VENTA_DETALLE
CREATE TABLE VENTA_DETALLE (
    IDVENTDET integer PRIMARY KEY,
    CODVEN integer  NOT NULL,
    CODSERV integer  NOT NULL,
    SUBVENDET integer  NOT NULL,
    ESTDETVEN char (1) NOT NULL,
    NOTAS varchar2(50)  NOT NULL
) ;

-- Plan de Contigencia para eliminaci�n r�pida de tablas!
--DROP TABLE VENTA_DETALLE;
--DROP TABLE VENTA;
--DROP TABLE COMPRA_DETALLE;
--DROP TABLE COMPRA;
--DROP TABLE PROVEEDOR;
--DROP TABLE CLIENTE;
--DROP TABLE EMPLEADO;
--DROP TABLE PRODUCTO;
--DROP TABLE SERVICIOS;



-- Creaci�n de claves Foraneas
-- Referencia : COMPRADETALLE_COMPRA (tabla: COMPRA_DETALLE)
ALTER TABLE COMPRA_DETALLE ADD CONSTRAINT COMPRA_DETALLE_COMPRA FOREIGN KEY (IDCOM) REFERENCES COMPRA (IDCOM);

-- Referencia: COMPRADETALLE_PRODUCTO (tabla: COMPRA_DETALLE)
ALTER TABLE COMPRA_DETALLE ADD CONSTRAINT COMPRA_DETALLE_PRODUCTO FOREIGN KEY (IDPRO) REFERENCES PRODUCTO (IDPRO);

-- Referencia: COMPRA_EMPLEADO (tabla: COMPRA)
ALTER TABLE COMPRA ADD CONSTRAINT COMPRA_EMPLEADO FOREIGN KEY (IDEMP) REFERENCES EMPLEADO (IDEMP);

-- Referencia: COMPRA_PROVEEDOR (tabla: COMPRA)
ALTER TABLE COMPRA ADD CONSTRAINT COMPRA_PROVEEDOR FOREIGN KEY (IDPROV) REFERENCES PROVEEDOR (IDPROV);

-- Referencia: VENTA_CLIENTE (tabla : VENTA)
ALTER TABLE VENTA ADD CONSTRAINT VENTA_CLIENTE FOREIGN KEY (IDCLI) REFERENCES CLIENTE (IDCLI);

-- Referencia: VENTADETALLE_SERVICIOS (tabla : VENTA_DETALLE)
ALTER TABLE VENTA_DETALLE ADD CONSTRAINT VENTA_DETALLE_SERVICIOS FOREIGN KEY (CODSERV) REFERENCES SERVICIOS (IDSERV);

-- Referencia : VENTADETALLE_VENTA (tabla : VENTA_DETALLE)
ALTER TABLE VENTA_DETALLE ADD CONSTRAINT VENTA_DETALLE_VENTA FOREIGN KEY (CODVEN) REFERENCES VENTA (IDVEN);

-- Referencia : VENTA_EMPLEADO (tabla : VENTA)
ALTER TABLE VENTA ADD CONSTRAINT VENTA_EMPLEADO FOREIGN KEY (IDEMP) REFERENCES EMPLEADO (IDEMP); 

--Creaci�n de Trigger
--Primera parte creaci�n de secuencias :
--Creaci�n de secuencia de Cliente
CREATE SEQUENCE ID_CLIENTE START WITH 1 INCREMENT BY 1 ORDER;

--Creaci�n de secuencia de Empleado
CREATE SEQUENCE ID_EMPLEADO START WITH 1 INCREMENT BY 1 ORDER;

--Creaci�n de secuencia de Proveedor
CREATE SEQUENCE ID_PROVEEDOR START WITH 1 INCREMENT BY 1 ORDER;

--Creaci�n de secuencia de Producto
CREATE SEQUENCE ID_PRODUCTO START WITH 1 INCREMENT BY 1 ORDER;

--Creaci�n de secuencia de Venta
CREATE SEQUENCE ID_VENTA START WITH 1 INCREMENT BY 1 ORDER;

--Creaci�n de secuencia de VentaDetalle
CREATE SEQUENCE ID_VENTADETALLE START WITH 1 INCREMENT BY 1 ORDER;

--Creaci�n de secuencia de Compra
CREATE SEQUENCE ID_COMPRA START WITH 1 INCREMENT BY 1 ORDER;

--Creaci�n de secuencia de CompraDetalle
CREATE SEQUENCE ID_COMPRADETALLE START WITH 1 INCREMENT BY 1;

--Creaci�n de secuencia de Servicios
CREATE SEQUENCE ID_SERVICIOS START WITH 1 INCREMENT BY 1;

-- Plan de Contigencia para eliminaci�n r�pida de Secuencias!
--DROP SEQUENCE ID_CLIENTE;
--DROP SEQUENCE ID_EMPLEADO;
--DROP SEQUENCE ID_PROVEEDOR;
--DROP SEQUENCE ID_PRODUCTO;
--DROP SEQUENCE ID_VENTA;
--DROP SEQUENCE ID_VENTADETALLE;
--DROP SEQUENCE ID_COMPRA;
--DROP SEQUENCE ID_COMPRADETALLE;
--DROP SEQUENCE ID_SERVICIOS;

--Segunda parte creaci�n de Triggers :
-- Crea o remplaza al Trigger activo en este caso Cliente :
CREATE OR REPLACE TRIGGER ID_CLIENTE BEFORE INSERT ON CLIENTE FOR EACH ROW BEGIN SELECT ID_CLIENTE.NEXTVAL INTO :NEW.IDCLI FROM DUAL;
END;
/

-- Crea o remplaza al Trigger activo en este caso Empleado :
CREATE OR REPLACE TRIGGER ID_EMPLEADO BEFORE INSERT ON EMPLEADO FOR EACH ROW BEGIN SELECT ID_EMPLEADO.NEXTVAL INTO :NEW.IDEMP FROM DUAL;
END;
/

-- Crea o remplaza al Trigger activo en este caso Proveedor :
CREATE OR REPLACE TRIGGER ID_PROVEEDOR BEFORE INSERT ON PROVEEDOR FOR EACH ROW BEGIN SELECT ID_PROVEEDOR.NEXTVAL INTO :NEW.IDPROV FROM DUAL;
END;
/

-- Crea o remplaza al Trigger activo en este caso Producto :
CREATE OR REPLACE TRIGGER ID_PRODUCTO BEFORE INSERT ON PRODUCTO FOR EACH ROW BEGIN SELECT ID_PRODUCTO.NEXTVAL INTO :NEW.IDPRO FROM DUAL;
END;
/

-- Crea o remplaza al Trigger activo en este caso Venta :
CREATE OR REPLACE TRIGGER ID_VENTA BEFORE INSERT ON VENTA FOR EACH ROW BEGIN SELECT ID_VENTA.NEXTVAL INTO :NEW.IDVEN FROM DUAL;
END;
/

-- Crea o remplaza al Trigger activo en este caso VentaDetalle :
CREATE OR REPLACE TRIGGER ID_VENTADETALLE BEFORE INSERT ON VENTA_DETALLE FOR EACH ROW BEGIN SELECT ID_VENTADETALLE.NEXTVAL INTO :NEW.IDVENTDET FROM DUAL;
END;
/
-- Crea o remplaza al Trigger activo en este caso Compra :
CREATE OR REPLACE TRIGGER ID_COMPRA BEFORE INSERT ON COMPRA FOR EACH ROW BEGIN SELECT ID_COMPRA.NEXTVAL INTO :NEW.IDCOM FROM DUAL;
END;
/
-- Crea o remplaza al Trigger activo en este caso CompraDetalle :
CREATE OR REPLACE TRIGGER ID_COMPRADETALLE BEFORE INSERT ON COMPRA_DETALLE FOR EACH ROW BEGIN SELECT ID_COMPRADETALLE.NEXTVAL INTO :NEW.IDCOMDET FROM DUAL;
END;
/

-- Crea o remplaza al Trigger activo en este caso Servicios :
CREATE OR REPLACE TRIGGER ID_SERVICIOS BEFORE INSERT ON SERVICIOS FOR EACH ROW BEGIN SELECT ID_SERVICIOS.NEXTVAL INTO :NEW.IDSERV FROM DUAL;
END;
/

--Inserci�n de datos de : Cliente 
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Juan Carlos','Zegarra Lopez','960849234','juan@gmail.com','73349428','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Kevin Correa','Quispe Perez',	'932456123','Kevin@gmail.com','74474832','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Melissa Andrea','Gonzales Mariano','908472934','Melissa@gmail.com','63874397','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Irene Pallares','Orlando Hurtado','964347823','Irene@gmail.com','75947573','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Jorge Arroyo','Judith Canela','749374937','Jorjito@gmail.com','74398273','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Veronica Cespedes','Alarcon Lobato','994782789','Veronica@gmail.com','37589479','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Montserrat Santa','Eugenia Matas','934647638','Montecito@gmail.com','75984789','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Lidia Montesinos','Abellan Ramiro','974095689','Lidiaita@gmail.com','84798734','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Maribel Mora','Morilla Lora','998748978','Mari@gmail.com','75893479',	'A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Elia Aguado', 'Tatiana Rovira','935747594','Elisita@gmail.com','53294889','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Armando Pepera', 'Blas Zaragosa','947985478','AmandoFernando@gmail.com','74879548','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Hugo Quesada','Barbera Galiano','943984579','Hugo@gmail.com','54754387','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Lorenzo Hernandez','Casta�o Morrillo','934875804','Lorenzo@gmail.com','78998548','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Emilio Castellss','Alemany Corral','949847547','Emilio@gmail.com','75489472','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Sonsoles Sacristan','Alonso Tejero','958475894','Sonsoles@gmail.com','84574339','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Flora Antunez','Rincon Maroto','959047579','Florita@gmail.com','98437578','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Antunez Sonsoles','Alemany Corral','949847547','Emilio@gmail.com','75489472','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Castellss Rovira','Alonso Tejero','958475894','Sonsoles@gmail.com','84574339','A');
INSERT INTO CLIENTE (NOMCLI,APECLI,TELEFCLI,EMAILCLI,DNICLI,ESTACLI) VALUES ('Flora Hugo','Rincon Maroto','959047579','Florita@gmail.com','98437578','A');


--Inserci�n de datos de : Empleados
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Hugo', 'Suarez Medina', '936296570', 'hugo.medina@ooutlook.com', '18750024', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Nicolas', 'Casas Perez', '911000411', 'nicolas.casas@gmail.com', '77755425', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Joel', 'Gonzales Sanchez', '921893013', 'joel_sanchez@yahoo.com', '77077616', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Pedro', 'Saenz Rodriguez', '922652686', 'pedro_rodri@hotmail.com', '49459763', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Diego', 'Gutierrez Venturo', '966729376', 'diegoventuro@gmail.com', '20353264', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('George', 'Guerra Lopez', '933067766', 'george..guerra@outlook.com', '93558826', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Piero', 'Yactayo Mendoza', '945220596', 'piero-mendoza@yahoo.com', '53330527', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Alex', 'Villanueva Medrano', '991102507', 'alex.medrano@hotmail.com', '47045643', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Alexander', 'Garay Levano', '916922038', 'alexander.garay@gmail.com', '78200902', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Victor', 'Porta Reynoso', '976607612', 'victor_reynoso@yahoo.com', '36614874', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Alisson', 'Acu�a Candela', '966310150', 'Alisson23@gmail.com', '21326672', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Valeria', 'Vivanco Alcala', '905223438', 'Valerie_ADC@hotmail.com', '38495971', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Alberto', 'Diaz Sulca', '977749646', 'Alberto_diaoutlook.com', '72248439', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Naomi', 'Tello Lozano', '926032710', 'NaomiJuan@gmail.com', '38894608', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Sandra', 'Rueda Barrios', '914703422', 'Sandrita342@hotmail.com', '54704643', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Rosa', 'Aylas Ramos', '927581799', 'Rosa342Atea@hotmail.com', '46940875', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Patrick', 'Acosto Condori', '968131519', 'Patrick.caso@gmail.com', '22564402', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Nadia', 'Zegarra Ayala', '926613171', 'Nadia23@hotmail.com', '90737782', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Paola', 'Quispe Pumasupa', '977324174', 'Paolita@hotmail.com', '50924426', 'A');
INSERT INTO EMPLEADO (NOMEMP, APEEMP, TELEFEMP, EMAILEMP, DNIEMP, ESTAEMP) VALUES ('Nayelli', 'Nolazco Arizaga', '928620155', 'Nayeli_Nola@outlook.com', '78157834', 'A');

--Inserci�n de datos de : Servicios
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Dise�o Publicitario','Creaci�n de Logo','59,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Dise�o Publicitario','Redise�o de Logo','63,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Dise�o Publicitario','Identidad de Marca','80,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Dise�o Publicitario','Foto de perfil','71,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Dise�o Publicitario','Tarjetas personales','43,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Dise�o Publicitario','Portada de FanPage','63,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Dise�o Publicitario','Folleto','57,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Fotograf�a Profesional','Fotograf�a Indrustrial','48,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Fotograf�a Profesional','Fotograf�a Corporativa','83,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Fotograf�a Profesional','Fotograf�a profesional','77,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Fotograf�a Profesional','Sesiones fotogr�ficas','51,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Fotograf�a Profesional','Sesiones preboda y boda','88,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Fotograf�a Profesional','Cobertura de eventos','100,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Audio Visual','Videos Corporativos','112,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Audio Visual','Videos Institucionales','54,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Audio Visual','Video de Servicios y Negocios','119,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Audio Visual','Videos Publicitarios','96,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Audio Visual','Video de Marketing','82,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Audio Visual','Spot publicitario','104,00','A');
INSERT INTO SERVICIOS (CATEG,NOM,PREC,ESTSEV) VALUES ('Audio Visual','Filmaciones en Full ','54,00','A');

--Inserci�n de datos de : Venta
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('3','10','A','01/05/2022','28' );
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('5','13','A','01/05/2022','67');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('7','8','A','01/05/2022','71');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('10','7','A','01/05/2022','12');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('17','8','A','01/05/2022','96');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('9','11','A','01/05/2022','103');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('8','16','A','01/05/2022','64');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('4','4','A','01/05/2022','56');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('5','6','A','01/05/2022','35');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('13','15','A','01/05/2022','15');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('18','16','A','01/05/2022','19');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('3','10','A','01/05/2022','78');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('10','1','A','01/05/2022','29');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('11','5','A','01/05/2022','69');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('12','8','A','01/05/2022','34');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('14','2','A','01/05/2022','102');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('13','9','A','01/05/2022','93');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('19','7','A','01/05/2022','81');
INSERT INTO VENTA (IDCLI, IDEMP, ESTVENT,FECVEN,PRETOTVEN) VALUES ('15','12','A','01/05/2022','29');

--Inserci�n de datos de : VentaDetalle
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','100','2','2','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','11','2','2','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','120','3','3','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','20','4','4','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','30','5','5','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','40','6','6','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','50','7','7','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','50','8','8','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','60','9','9','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','60','10','10','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','60','11','11','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','70','12','12','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','70','13','13','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','70','14','14','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','80','15','15','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','80','16','16','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','30','5','5','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','40','6','6','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','50','7','7','Sin notas por el Cliente');
INSERT INTO VENTA_DETALLE (ESTDETVEN,SUBVENDET,CODVEN,CODSERV,NOTAS) VALUES ('A','50','8','8','Sin notas por el Cliente');

--Inserci�n de datos de : Proveedor
INSERT INTO PROVEEDOR (RUCPROV, NOMPREPROV, CELPROV, DIRPROV, ESTPROV) VALUES ('20469462906', 'Grey Agency', '969718579', 'Av. Libertadores', 'A');
INSERT INTO PROVEEDOR (RUCPROV, NOMPREPROV, CELPROV, DIRPROV, ESTPROV) VALUES ('20879856584', 'McCan WorldGroup', '904721944', 'Jr. Casuarinas', 'A');
INSERT INTO PROVEEDOR (RUCPROV, NOMPREPROV, CELPROV, DIRPROV, ESTPROV) VALUES ('20380013309', 'MullenLowe', '965953626', 'Urb. Los Pinos', 'A');
INSERT INTO PROVEEDOR (RUCPROV, NOMPREPROV, CELPROV, DIRPROV, ESTPROV) VALUES ('20147083284', 'Publicis', '994965712', 'Urb. Hualcara', 'A');
INSERT INTO PROVEEDOR (RUCPROV, NOMPREPROV, CELPROV, DIRPROV, ESTPROV) VALUES ('20926811570', 'Havas S.A.C', '977349534', 'Jr. Miguel Grau', 'A');
INSERT INTO PROVEEDOR (RUCPROV, NOMPREPROV, CELPROV, DIRPROV, ESTPROV) VALUES ('20438430870', 'LatinBrands', '966662025', 'Av. Los Cerezos', 'A');
INSERT INTO PROVEEDOR (RUCPROV, NOMPREPROV, CELPROV, DIRPROV, ESTPROV) VALUES ('20712511840', 'Alicorp', '946443025', 'Av. 2 de Mayo', 'A');
INSERT INTO PROVEEDOR (RUCPROV, NOMPREPROV, CELPROV, DIRPROV, ESTPROV) VALUES ('20395986143', 'Fahrenheit', '940685639', 'Jr. El Sol', 'A');
INSERT INTO PROVEEDOR (RUCPROV, NOMPREPROV, CELPROV, DIRPROV, ESTPROV) VALUES ('20475329306', 'Wunderman', '918984187', 'Urb. Almenares', 'A');
INSERT INTO PROVEEDOR (RUCPROV, NOMPREPROV, CELPROV, DIRPROV, ESTPROV) VALUES ('20845197381', 'Phantasia', '971226638', 'Fundo Santa Adela', 'A');

--Inserci�n de datos de : Producto
INSERT INTO PRODUCTO(NOMPRO, MARPRO, DESPRO, STOPRO, ESTPRO) VALUES ('Tinta Negra', 'Epson', 'Tinta de color negra', '30', 'A');
INSERT INTO PRODUCTO(NOMPRO, MARPRO, DESPRO, STOPRO, ESTPRO) VALUES ('Tinta Azul', 'Epson', 'Tinta de color azul', '30', 'A');
INSERT INTO PRODUCTO(NOMPRO, MARPRO, DESPRO, STOPRO, ESTPRO) VALUES ('Tinta Rosada', 'Epson', 'Tinta de color rosado', '30', 'A');
INSERT INTO PRODUCTO(NOMPRO, MARPRO, DESPRO, STOPRO, ESTPRO) VALUES ('Tinta Amarilla', 'Epson', 'Tinta de color amarillo', '30', 'A');
INSERT INTO PRODUCTO(NOMPRO, MARPRO, DESPRO, STOPRO, ESTPRO) VALUES ('Hojas Fotogr�ficas ', 'Millenium', 'Hojas para fotos', '100', 'A');
INSERT INTO PRODUCTO(NOMPRO, MARPRO, DESPRO, STOPRO, ESTPRO) VALUES ('Papel Bond', 'Atlas', 'Hojas para apuntes', '20', 'A');

--Inserci�n de datos de : Compra
INSERT INTO COMPRA (FECCOM, IDPROV, IDEMP) VALUES ('01/04/2022', '9', '1');
INSERT INTO COMPRA (FECCOM, IDPROV, IDEMP) VALUES ('03/04/2022', '2', '2');
INSERT INTO COMPRA (FECCOM, IDPROV, IDEMP) VALUES ('10/05/2022', '3', '3');
INSERT INTO COMPRA (FECCOM, IDPROV, IDEMP) VALUES ('15/05/2022', '4', '4');
INSERT INTO COMPRA (FECCOM, IDPROV, IDEMP) VALUES ('20/05/2022', '5', '5');
INSERT INTO COMPRA (FECCOM, IDPROV, IDEMP) VALUES ('17/06/2022', '6', '6');
INSERT INTO COMPRA (FECCOM, IDPROV, IDEMP) VALUES ('20/06/2022', '7', '7');
INSERT INTO COMPRA (FECCOM, IDPROV, IDEMP) VALUES ('23/06/2022', '8', '8');

--Inserci�n de datos de : CompraDetalle
INSERT INTO COMPRA_DETALLE (CANTCOMDET, IDCOM, IDPRO, PRETOTCOMDET, PRECOMPRO)VALUES ('10', '1', '1', '150', '15');
INSERT INTO COMPRA_DETALLE (CANTCOMDET, IDCOM, IDPRO, PRETOTCOMDET, PRECOMPRO)VALUES ('15', '2', '2', '225', '15');
INSERT INTO COMPRA_DETALLE (CANTCOMDET, IDCOM, IDPRO, PRETOTCOMDET, PRECOMPRO)VALUES ('8', '3', '3', '120', '15');
INSERT INTO COMPRA_DETALLE (CANTCOMDET, IDCOM, IDPRO, PRETOTCOMDET, PRECOMPRO)VALUES ('2', '4', '4', '30', '15');
INSERT INTO COMPRA_DETALLE (CANTCOMDET, IDCOM, IDPRO, PRETOTCOMDET, PRECOMPRO)VALUES ('7', '5', '5', '280', '40');
INSERT INTO COMPRA_DETALLE (CANTCOMDET, IDCOM, IDPRO, PRETOTCOMDET, PRECOMPRO)VALUES ('10', '6', '6', '300', '30');
INSERT INTO COMPRA_DETALLE (CANTCOMDET, IDCOM, IDPRO, PRETOTCOMDET, PRECOMPRO)VALUES ('1', '7', '2', '15', '15');
INSERT INTO COMPRA_DETALLE (CANTCOMDET, IDCOM, IDPRO, PRETOTCOMDET, PRECOMPRO)VALUES ('5', '8', '5', '200', '40');
INSERT INTO COMPRA_DETALLE (CANTCOMDET, IDCOM, IDPRO, PRETOTCOMDET, PRECOMPRO)VALUES ('9', '2', '3', '135', '15');
INSERT INTO COMPRA_DETALLE (CANTCOMDET, IDCOM, IDPRO, PRETOTCOMDET, PRECOMPRO)VALUES ('10', '5', '4', '150', '15');



--Creaci�n de una Vista Vventa :
CREATE VIEW vVenta
AS
SELECT
    V.IDVEN AS IDVEN,
	C.IDCLI AS IDCLI,
    C.DNICLI AS DNICLI,
	INITCAP((C.APECLI)|| ', ' ||(C.NOMCLI)) AS NOMCLI,
	E.IDEMP AS IDEMP,
    E.DNIEMP AS DNIEMP,
	INITCAP((E.APEEMP)|| ', ' ||(E.NOMEMP)) AS NOMEMP,
    V.FECVEN AS FECVEN,
    V.PRETOTVEN AS PRETOTVEN
FROM VENTA  V
    INNER JOIN CLIENTE C
    ON V.IDCLI = C.IDCLI
	INNER JOIN EMPLEADO E
	 ON V.IDEMP = E.IDEMP;
     
--Dropear Vista 
--DROP VIEW vVenta;
     
--Plan de contigencia para tener un vista de todas las tablas
--SELECT * FROM CLIENTE;
--SELECT * FROM COMPRA;
--SELECT * FROM COMPRA_DETALLE;
--SELECT * FROM EMPLEADO;
--SELECT * FROM PRODUCTO;
--SELECT * FROM PROVEEDOR;
--SELECT * FROM SERVICIOS;
--SELECT * FROM VENTA;
--SELECT * FROM VENTA_DETALLE;



