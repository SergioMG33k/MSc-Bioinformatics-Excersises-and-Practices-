#Tiendas
#Crear base de datos con Create database gameshop
#usar base de datos con use gameshop

CREATE TABLE Tienda
	(
	id_tienda integer primary key ,
	direccion varchar(150) not null
	);
    
#Desarrolladoras de videojuegos
CREATE TABLE Desarrolladora_distribuidora
	(
	id_empresa integer primary key auto_increment,
	nombre_empresa varchar(25) not null,
	direccion_oficinas varchar(150) not null,
	tipo varchar(10) not null
	);

#Videojuegos(utilizamos el nombre del videojuego como clave, porque una vez una desarrolladora lo registra como un producto suyo, este no puede ser usado por otra desarroladora, y dentro de la misma desarroladora que lo ha registrado todos los juegos tendran nombres diferentes y a veces numeracion si son de la misma saga, por lo cual son unicos)
CREATE TABLE Videojuego
	(
	nombre_game varchar(50) primary key,
    id_empresa integer not null,
	genero varchar(50) not null,
    foreign key(id_empresa) references Desarrolladora_distribuidora(id_empresa),
    key idx_genero (genero)
	);

#PedidoTiendas
CREATE TABLE PedidoT
	(
	id_pedidot integer primary key auto_increment,
	fecha date not null,
    id_tienda integer not null,
	foreign key(id_tienda) references Tienda(id_tienda)
	);
	
#VideojuegoPredidoT
CREATE TABLE VideojuegoPedidoT
	(
    nombre_game varchar(50) not null,
    id_pedidot integer not null unique,
    cantidad integer(10) not null,
	precio_unidad float not null, #el precio dependera directamente de la cantidad que se pida y sera un establecido por un acuerdo entre la empresa de tiendas de videojuegos y la desarrolladora)
    foreign key(nombre_game) references Videojuego(nombre_game),
	foreign key(id_pedidot) references PedidoT(id_pedidot),
	primary key (nombre_game, id_pedidot)
	);

#Clientes
CREATE TABLE Cliente
	(
    id_cliente integer primary key auto_increment,
	dni varchar(9) unique not null ,
	domicilio varchar(150) not null,
	nombre varchar(10) not null,
	apellidos varchar (25) not null
	);
	
#Telefonos
CREATE TABLE Telefono
	(
    telefono integer(9) primary key,
    id_cliente integer not null unique,
	estado varchar(20) not null,
    foreign key(id_cliente) references Cliente(id_cliente)
	);

#Articulo tienda
CREATE TABLE Articulo_t
	(
    id_articulo integer primary key auto_increment,
    nombre_game varchar(50) not null,
    id_tienda integer not null,
	pvp float(10) not null,
    genero varchar(50) not null,
    foreign key(nombre_game) references Videojuego(nombre_game),
	foreign key(id_tienda) references Tienda(id_tienda),
    foreign key(genero) references Videojuego(genero),
    unique(nombre_game,id_tienda)
	);

#Pedidos clientes
CREATE TABLE PedidoC
	(
	id_pedidoc integer primary key auto_increment,
	fecha date not null,
    id_cliente integer not null,
	foreign key(id_cliente) references Cliente(id_cliente)
	);	
	
#ArticulosPedido
CREATE TABLE ArticulosPedido
	(
    id_pedidoc integer not null,
    id_articulo integer not null,
    cantidad integer(100) not null,
	foreign key(id_articulo) references Articulo_t(id_articulo),
	foreign key(id_pedidoc)references PedidoC(id_pedidoc),
	primary key(id_articulo, id_pedidoc)
	);

#INSERTS EN TABLA TIENDA(id_tienda, direccion) --------------------------------------------------------------------------------1
insert into Tienda values(1,'Av. de Monforte de Lemos, 36, 28029 Madrid, España');
insert into Tienda values(2,'Calle de Preciados, 34, 28013 Madrid, España');
insert into Tienda values(3,'Calle Ginzo de Limia, 42, 28029 Madrid, España');
insert into Tienda values(4,'Carrer de Pau Claris, 97, 08009 Barcelona, España');
insert into Tienda values(5,'Carrer Gran de Gràcia, 116, 08012 Barcelona, España');
insert into Tienda values(6,'Carrer de Potosí, 2, 08030 Barcelona, España');
insert into Tienda values(7,'Calle Luis Montoto, 144, 41005 Sevilla, España');
insert into Tienda values(8,'Calle Chaves Nogales, 20, 41018 Sevilla, España');
insert into Tienda values(9,'Calle San Quintín, 8, 47005 Valladolid, España');
insert into Tienda values(10,'Calle de Fuenterrabía, 34, 20005 Donostia, España');
#INSERTS EN TABLA DESARROLADORA_DISTRIBUIDORA (id_empresa,nombre_empresa,direccion,tipo)---------------------------------------------------------------------------------2
insert into Desarrolladora_distribuidora(nombre_empresa,direccion_oficinas,tipo) values('Electronic Arts','209 Redwood Shores Pkwy, Redwood City, CA 94065, Estados Unidos','AAA');
insert into Desarrolladora_distribuidora(nombre_empresa,direccion_oficinas,tipo) values('Activision Blizzard','3100 Ocean Park Blvd, Santa Monica, CA 90405, Estados Unidos','AAA');
insert into Desarrolladora_distribuidora(nombre_empresa,direccion_oficinas,tipo) values('Paradox Interactive','Magnus Ladulåsgatan 4, 118 66 Stockholm, Suecia','AA');
insert into Desarrolladora_distribuidora(nombre_empresa,direccion_oficinas,tipo) values('Square Enix','240 Blackfriars Rd, London SE1 8NW, Reino Unido','AAA');
insert into Desarrolladora_distribuidora(nombre_empresa,direccion_oficinas,tipo) values('NCsoft','Bundang-gu, Seongnam-si,Korea (13494)','AAA');
insert into Desarrolladora_distribuidora(nombre_empresa,direccion_oficinas,tipo) values('Bandai Namco','2-37-25 Eitai, Koto-ku, Tokyo 135-0034, Japón','AAA');
insert into Desarrolladora_distribuidora(nombre_empresa,direccion_oficinas,tipo) values('Konami','1-11-1, Ginza, Chuo-ku, Tokyo, 104-0061 Japón','AAA');
insert into Desarrolladora_distribuidora(nombre_empresa,direccion_oficinas,tipo) values('Capcom','185 Berry St., Suite 1200, San Francisco, CA 94107, Estados Unidos','AAA');
insert into Desarrolladora_distribuidora(nombre_empresa,direccion_oficinas,tipo) values('StudioMDHR','5 High Street, Westbury On Trym, Bristol, Reino Unido','Indie');
insert into Desarrolladora_distribuidora(nombre_empresa,direccion_oficinas,tipo) values('Ubisoft','625 3rd St, San Francisco, CA 94107, Estados Unidos','AAA');
#INSERTS EN TABLA VIDEOJUEGO(nombre_game,id_dempresa,genero)--------------------------------------------------------------------------------3
insert into Videojuego values('Battlefield 1',1,'FPS');
insert into Videojuego values('Sims 4',1,'RPG');
insert into Videojuego values('FIFA 2020',1,'Deportes');
insert into Videojuego values('Star Wars battlefront',1,'FPS');
insert into Videojuego values('Starcraft 2',2,'RTS');
insert into Videojuego values('Diablo 3',2,'RPG');
insert into Videojuego values('Heroes of the storm',2,'MOBA');
insert into Videojuego values('Call of Dutty:modern warfare',2,'FPS');
insert into Videojuego values('Overwatch',2,'FPS');
insert into Videojuego values('Crusader Kings III',3,'RTS');
insert into Videojuego values('Life Is Strange',4,'Aventura gráfica');
insert into Videojuego values('Life Is Strange 2',4,'Aventura gráfica');
insert into Videojuego values('Final Fantasy X',4,'RPG-Sandbox');
insert into Videojuego values('Guild Wars',5,'MMO-RPG');
insert into Videojuego values('Guild Wars 2',5,'MMO-RPG');
insert into Videojuego values('Dragon Ball Z:kakarot',6,'Lucha-Sandbox');
insert into Videojuego values('Dragon Ball Xenoverse 2',6,'Lucha');
insert into Videojuego values('Metal Gerar Solid V',7,'FPS-sandbox');
insert into Videojuego values('Metal Gerar Solid:Survival',7,'FPS');
insert into Videojuego values('Street Fighter V',8,'Lucha');
insert into Videojuego values('Resident Evil :Village',8,'Terror');
insert into Videojuego values('Cuphead',9,'Plataformas');
insert into Videojuego values('Watch Dogs 2',10,'FPS-Sandbox');
insert into Videojuego values('Watch Dogs:Legion',10,'FPS-Sandbox');
insert into Videojuego values('Assassins creed Valhalla',10,'RPG-Sandbox');
#INSERTS EN TABLA PEDIDOT(fecha,id_tienda)-----------------------------------------------------------------------------4 
insert into PedidoT(fecha,id_tienda) values('2020-03-20',1);
insert into PedidoT(fecha,id_tienda) values('2020-03-20',1);
insert into PedidoT(fecha,id_tienda) values('2020-03-20',1);
insert into PedidoT(fecha,id_tienda) values('2020-03-20',1);
insert into PedidoT(fecha,id_tienda) values('2020-03-20',1);
insert into PedidoT(fecha,id_tienda) values('2020-03-24',2);
insert into PedidoT(fecha,id_tienda) values('2020-03-24',2);
insert into PedidoT(fecha,id_tienda) values('2020-03-24',2);
insert into PedidoT(fecha,id_tienda) values('2020-03-24',2);
insert into PedidoT(fecha,id_tienda) values('2020-02-04',3);
insert into PedidoT(fecha,id_tienda) values('2020-02-28',3);
insert into PedidoT(fecha,id_tienda) values('2020-03-20',4);
insert into PedidoT(fecha,id_tienda) values('2020-03-20',4);
insert into PedidoT(fecha,id_tienda) values('2020-03-20',4);
insert into PedidoT(fecha,id_tienda) values('2020-03-20',4);
insert into PedidoT(fecha,id_tienda) values('2020-03-20',5);
insert into PedidoT(fecha,id_tienda) values('2020-03-20',5);
insert into PedidoT(fecha,id_tienda) values('2020-03-20',5);
insert into PedidoT(fecha,id_tienda) values('2020-03-20',5);
insert into PedidoT(fecha,id_tienda) values('2020-03-17',6);
insert into PedidoT(fecha,id_tienda) values('2020-03-17',6);
insert into PedidoT(fecha,id_tienda) values('2020-03-17',6);
insert into PedidoT(fecha,id_tienda) values('2020-03-17',6);
insert into PedidoT(fecha,id_tienda) values('2020-03-17',6);
insert into PedidoT(fecha,id_tienda) values('2020-03-17',6);
insert into PedidoT(fecha,id_tienda) values('2020-03-17',6);
insert into PedidoT(fecha,id_tienda) values('2020-03-09',7);
insert into PedidoT(fecha,id_tienda) values('2020-03-09',7);
insert into PedidoT(fecha,id_tienda) values('2020-03-15',8);
insert into PedidoT(fecha,id_tienda) values('2020-03-15',8);
insert into PedidoT(fecha,id_tienda) values('2020-04-21',9);
insert into PedidoT(fecha,id_tienda) values('2020-04-29',10);
insert into PedidoT(fecha,id_tienda) values('2020-04-29',10);
insert into PedidoT(fecha,id_tienda) values('2020-04-29',10);
#INSERTS EN TABLA VIDEOJUEGO_PEDIDOT(nombre_game,id_pedidoT,cantidad,precio_unidad)-------------------------------------------------------------- 
insert into VideojuegoPedidoT values('Life Is Strange 2',1,30,45.99);
insert into VideojuegoPedidoT values('Starcraft 2',2,200,30.75);
insert into VideojuegoPedidoT values('Guild Wars 2',3,50,42.60);
insert into VideojuegoPedidoT values('Battlefield 1',4,57,41.32);
insert into VideojuegoPedidoT values('Assassins creed Valhalla',5,15,45.99);
insert into VideojuegoPedidoT values('Metal Gerar Solid V',6,50,42.60);
insert into VideojuegoPedidoT values('Crusader Kings III',7,80,39.75);
insert into VideojuegoPedidoT values('Starcraft 2',8,90,40.75);
insert into VideojuegoPedidoT values('Diablo 3',9,25,43.99);
insert into VideojuegoPedidoT values('Cuphead',10,60,42.75);
insert into VideojuegoPedidoT values('Battlefield 1',11,50,43.00);
insert into VideojuegoPedidoT values('Overwatch',12,80,38.75);
insert into VideojuegoPedidoT values('Metal Gerar Solid:Survival',13,42,42.20);
insert into VideojuegoPedidoT values('FIFA 2020',14,60,43.20);
insert into VideojuegoPedidoT values('Heroes of the storm',15,43,20.99);
insert into VideojuegoPedidoT values('Star Wars battlefront',16,97,37.75);
insert into VideojuegoPedidoT values('Call of Dutty:modern warfare',17,50,40.00);
insert into VideojuegoPedidoT values('Guild Wars',18,50,19.99);
insert into VideojuegoPedidoT values('Battlefield 1',19,69,40.30);
insert into VideojuegoPedidoT values('Diablo 3',20,12,32.99);
insert into VideojuegoPedidoT values('Dragon Ball Xenoverse 2',21,37,38.00);
insert into VideojuegoPedidoT values('Life Is Strange',22,65,33.00);
insert into VideojuegoPedidoT values('Final Fantasy X',23,22,45.75);
insert into VideojuegoPedidoT values('Dragon Ball Z:kakarot',24,14,45.99);
insert into VideojuegoPedidoT values('Street Fighter V',25,7,42.00);
insert into VideojuegoPedidoT values('FIFA 2020',26,38,44.75);
insert into VideojuegoPedidoT values('Resident Evil :Village',27,20,42.99);
insert into VideojuegoPedidoT values('Heroes of the storm',28,18,27.00);
insert into VideojuegoPedidoT values('Star Wars battlefront',29,75,38.75);
insert into VideojuegoPedidoT values('Watch Dogs 2',30,140,25.75);
insert into VideojuegoPedidoT values('Dragon Ball Xenoverse 2',31,60,36.50);
insert into VideojuegoPedidoT values('Call of Dutty:modern warfare',32,39,42.75);
insert into VideojuegoPedidoT values('Resident Evil :Village',33,56,39.75);
insert into VideojuegoPedidoT values('Watch Dogs:Legion',34,17,44.50);
#INSERTS EN TABLA CLIENTE(dni,domicilio,nombre,apellidos)----------------------------------------------------------------------
insert into Cliente(dni,domicilio,nombre,apellidos) values('34585096L','Calle de Erasmo de Rotterdam, 9, 28049 Madrid','Jon', 'Calvillo');
insert into Cliente(dni,domicilio,nombre,apellidos) values('23993312B','Calle del Gral Oraá, 38, 28006 Madrid','Mara', 'Madrid');
insert into Cliente(dni,domicilio,nombre,apellidos) values('68103702N','Calle del Sombrerete, 20, 28012 Madrid','Marco', 'Rendón Tercero');
insert into Cliente(dni,domicilio,nombre,apellidos) values('62696356N','Calle Gutiérrez Solana, 2, 28036 Madrid','David', 'Barajas');
insert into Cliente(dni,domicilio,nombre,apellidos) values('66829686N','Calle del Capitán Blanco Argibay, 50, 28029 Madrid','Diego', 'Corral');
insert into Cliente(dni,domicilio,nombre,apellidos) values('33733410T','Calle de la Puebla, 8, 28004 Madrid','Yago', 'Calderón');
insert into Cliente(dni,domicilio,nombre,apellidos) values('50687509V','Calle Dámaso Alonso, 54, 40006 Segovia','Clara', 'Delafuente Hijo');
insert into Cliente(dni,domicilio,nombre,apellidos) values('82305589C','Calle Regina, 1, 41003 Sevilla','Ian', 'Sánchez');
insert into Cliente(dni,domicilio,nombre,apellidos) values('13605102G','Plaza Zurbarán, 4, 41003 Sevilla','Omar', 'Madera');
insert into Cliente(dni,domicilio,nombre,apellidos) values('75095194X','Carrer de lAmbaixador Vich, 15, 46002 Valencia, Valencia','Lara', 'Silva');
insert into Cliente(dni,domicilio,nombre,apellidos) values('89055621N','Carrer de Sorní, 28, 46004 Valencia, Valencia','Mateo', 'Hinojosa');
insert into Cliente(dni,domicilio,nombre,apellidos) values('39407312D','Calle San Nicolás, nº4, Bajo, 03002 Alicante, Alicante','Eva', 'Acuña Hijo');
insert into Cliente(dni,domicilio,nombre,apellidos) values('56856308D','Calle San Ildefonso, 16, 03001 Alicante, Alicante','Iker', 'Mejía');
insert into Cliente(dni,domicilio,nombre,apellidos) values('87337709Q','Calle Capitán Cortés, 4, 24001 León','Oliver', 'Abad Hijo');
insert into Cliente(dni,domicilio,nombre,apellidos) values('21340027Y','Calle Legión VII, 3, 24003 León','Iván', 'Olivárez');
insert into Cliente(dni,domicilio,nombre,apellidos) values('59858825Z','Carrer de Sant Medir, 12, 08028 Barcelona','Francisco', 'Javier Quiroz');
insert into Cliente(dni,domicilio,nombre,apellidos) values('49272901R','Pl. Urquinaona, 4, 08010 Barcelona','Anna', 'Delgado Hijo');
insert into Cliente(dni,domicilio,nombre,apellidos) values('27072888W','Carrer de les Ramelleres, 16, 08001 Barcelona','Santiago', 'Mendoza');
insert into Cliente(dni,domicilio,nombre,apellidos) values('14404666L','Carrer Enric Granados, 3, 08007 Barcelona','Biel', 'Ojeda');
insert into Cliente(dni,domicilio,nombre,apellidos) values('05262238E','Carrer de Margarit, 9, 08004 Barcelona','Alonso', 'Bravo');
insert into Cliente(dni,domicilio,nombre,apellidos) values('12375299B','Carrer de la Palla, 8, 08002 Barcelona','Carlos', 'Jurado');
insert into Cliente(dni,domicilio,nombre,apellidos) values('55466772H','Carrer de Pau Claris, 90, 08010 Barcelona','Marco', 'Avilés');
insert into Cliente(dni,domicilio,nombre,apellidos) values('93636851X','Calle de Sarria, 44, 28029 Madrid','Lucía', 'Reséndez');
insert into Cliente(dni,domicilio,nombre,apellidos) values('14051772Z','Plaza de Tirso de Molina, 16, 28012 Madrid','Vera', 'Garza');
insert into Cliente(dni,domicilio,nombre,apellidos) values('03026828M','Calle de Juan Montalvo, 21, 28040 Madrid','Ane', 'Villareal');
insert into Cliente(dni,domicilio,nombre,apellidos) values('39748947W','Calle de Serrano, 47, 28001 Madrid, SS','Marco', 'Jimínez');
insert into Cliente(dni,domicilio,nombre,apellidos) values('55904173M','Calle de Núñez de Arce, 7, 28012 Madrid','Victoria', 'Luque');
insert into Cliente(dni,domicilio,nombre,apellidos) values('22615787W','Calle de Pico Balaitus, 41 A, 47, 28035 Madrid','Ignacio', 'Sevilla');
insert into Cliente(dni,domicilio,nombre,apellidos) values('78302220P','Calle de Vallehermoso, 12, 28003 Madrid','Elena', 'Barrera');
#INSERTS EN TABLA TELEFONO(telefono,id_cliente,estado)-----------------------------------------------------------------------
insert into Telefono values(615367567,1,'Operativo');
insert into Telefono values(632983430,2,'Operativo');
insert into Telefono values(649492634,3,'Operativo');
insert into Telefono values(825356058,4,'Operativo');
insert into Telefono values(616836711,5,'Operativo');
insert into Telefono values(768949256,6,'Operativo');
insert into Telefono values(868888029,7,'Operativo');
insert into Telefono values(760884413,8,'Operativo');
insert into Telefono values(787662829,9,'Operativo');
insert into Telefono values(892642290,10,'Operativo');
insert into Telefono values(693060985,11,'Operativo');
insert into Telefono values(651658380,12,'No operativo');
insert into Telefono values(641031678,13,'Operativo');
insert into Telefono values(722984715,14,'Operativo');
insert into Telefono values(895196088,15,'Operativo');
insert into Telefono values(849482629,16,'Operativo');
insert into Telefono values(836331840,17,'Operativo');
insert into Telefono values(706315220,18,'Operativo');
insert into Telefono values(794634588,19,'No operativo');
insert into Telefono values(630006932,20,'Operativo');
insert into Telefono values(627015190,21,'Operativo');
insert into Telefono values(775164980,22,'Operativo');
insert into Telefono values(818320779,23,'Operativo');
insert into Telefono values(859833807,24,'Operativo');
insert into Telefono values(722638534,25,'Operativo');
insert into Telefono values(834929781,26,'Operativo');
insert into Telefono values(883861288,27,'Operativo');
insert into Telefono values(895685163,28,'Operativo');
insert into Telefono values(671666103,29,'Operativo');
#INSERTS EN TABLA  ARTICULO_T(nombre_game.id_tienda,pvp,genero)------------------------------------------------------
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Battlefield 1',1,59.99,'FPS');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('FIFA 2020',4,59.99,'Deportes');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Star Wars battlefront',1,59.99,'FPS');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Starcraft 2',1,59.99,'RTS');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Diablo 3',2,59.99,'RPG');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Heroes of the storm',4,59.99,'MOBA');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Call of Dutty:modern warfare',5,59.99,'FPS');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Overwatch',4,59.99,'FPS');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Crusader Kings III',2,59.99,'RTS');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Life Is Strange',6,59.99,'Aventura gráfica');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Life Is Strange 2',1,59.99,'Aventura gráfica');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Final Fantasy X',6,59.99,'RPG-Sandbox');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Guild Wars',5,59.99,'MMO-RPG');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Guild Wars 2',1,59.99,'MMO-RPG');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Dragon Ball Z:kakarot',6,59.99,'Lucha-Sandbox');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Dragon Ball Xenoverse 2',6,59.99,'Lucha');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Metal Gerar Solid V',2,59.99,'FPS-sandbox');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Metal Gerar Solid:Survival',4,59.99,'FPS');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Street Fighter V',6,59.99,'Lucha');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Resident Evil :Village',7,59.99,'Terror');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Cuphead',3,59.99,'Plataformas');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Watch Dogs 2',8,59.99,'FPS-Sandbox');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Assassins creed Valhalla',1,59.99,'RPG-Sandbox');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Starcraft 2',2,59.99,'RTS');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Battlefield 1',3,59.99,'FPS');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Star Wars battlefront',5,59.99,'FPS');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Battlefield 1',5,59.99,'FPS');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Diablo 3',6,59.99,'RPG');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('FIFA 2020',6,59.99,'Deportes');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Heroes of the storm',7,59.99,'MOBA');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Star Wars battlefront',8,59.99,'FPS');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Dragon Ball Xenoverse 2',9,59.99,'Lucha');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Call of Dutty:modern warfare',10,59.99,'FPS');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Resident Evil :Village',10,59.99,'Terror');
insert into Articulo_t(nombre_game,id_tienda,pvp,genero) values('Watch Dogs:Legion',10,59.99,'FPS-Sandbox');
#INSERTS EN TABLA PEDIDOC(fecha,id_cliente)---------------------------------------------------------------------
insert into PedidoC(fecha,id_cliente) values ('2020-06-15',1);
insert into PedidoC(fecha,id_cliente) values ('2020-06-13',2);
insert into PedidoC(fecha,id_cliente) values ('2020-06-16',3);
insert into PedidoC(fecha,id_cliente) values ('2020-06-12',4);
insert into PedidoC(fecha,id_cliente) values ('2020-06-25',5);
insert into PedidoC(fecha,id_cliente) values ('2020-06-28',6);
insert into PedidoC(fecha,id_cliente) values ('2020-06-23',7);
insert into PedidoC(fecha,id_cliente) values ('2020-09-05',8);
insert into PedidoC(fecha,id_cliente) values ('2020-06-15',9);
insert into PedidoC(fecha,id_cliente) values ('2020-08-01',10);
insert into PedidoC(fecha,id_cliente) values ('2020-06-25',11);
insert into PedidoC(fecha,id_cliente) values ('2020-06-26',12);
insert into PedidoC(fecha,id_cliente) values ('2020-07-11',13);
insert into PedidoC(fecha,id_cliente) values ('2020-06-29',14);
insert into PedidoC(fecha,id_cliente) values ('2020-06-14',15);
insert into PedidoC(fecha,id_cliente) values ('2020-06-21',16);
insert into PedidoC(fecha,id_cliente) values ('2020-07-07',17);
insert into PedidoC(fecha,id_cliente) values ('2020-06-20',18);
insert into PedidoC(fecha,id_cliente) values ('2020-06-22',19);
insert into PedidoC(fecha,id_cliente) values ('2020-07-09',20);
insert into PedidoC(fecha,id_cliente) values ('2020-06-30',21);
insert into PedidoC(fecha,id_cliente) values ('2020-08-02',22);
insert into PedidoC(fecha,id_cliente) values ('2020-06-16',23);
insert into PedidoC(fecha,id_cliente) values ('2020-06-15',24);
insert into PedidoC(fecha,id_cliente) values ('2020-06-19',25);
#INSERTS EN TABLA ARTICULOS_PEDIDO(id_pedido,id_articulo,cantidad)-------------------------------------------------------------
insert into ArticulosPedido values(1,1,2);
insert into ArticulosPedido values(2,2,1);
insert into ArticulosPedido values(2,35,1);
insert into ArticulosPedido values(2,16,1);
insert into ArticulosPedido values(3,5,1);
insert into ArticulosPedido values(4,8,1);
insert into ArticulosPedido values(5,20,1);
insert into ArticulosPedido values(6,4,1);
insert into ArticulosPedido values(7,8,5);
insert into ArticulosPedido values(8,19,1);
insert into ArticulosPedido values(9,26,1);
insert into ArticulosPedido values(10,3,2);
insert into ArticulosPedido values(11,2,1);
insert into ArticulosPedido values(12,28,1);
insert into ArticulosPedido values(13,31,1);
insert into ArticulosPedido values(14,8,1);
insert into ArticulosPedido values(14,33,1);
insert into ArticulosPedido values(15,2,1);
insert into ArticulosPedido values(16,6,1);
insert into ArticulosPedido values(17,10,2);
insert into ArticulosPedido values(18,34,1);
insert into ArticulosPedido values(19,12,1);
insert into ArticulosPedido values(20,24,1);
insert into ArticulosPedido values(21,11,1);
insert into ArticulosPedido values(22,9,1);
insert into ArticulosPedido values(23,18,1);
insert into ArticulosPedido values(24,21,3);
insert into ArticulosPedido values(24,3,1);
insert into ArticulosPedido values(25,34,1);
insert into ArticulosPedido values(25,25,1);

#QUERIES
#mostrando todo el contenido de las tablas
select * from Tienda;
select * from Desarrolladora_distribuidora;
select * from Videojuego order by id_empresa;
select * from PedidoT;	
select * from VideojuegoPedidoT order by id_pedidot;
select * from Cliente order by id_cliente;
select * from Telefono;
select * from Articulo_t;

#Mostrar los videojuegos de un mismo genero y los ordenamos alfabeticamente segun el nombre dle juego
select * from Videojuego where genero = 'FPS' order by nombre_game;

#mostrar las empresas que son indie y AA
select * from Desarrolladora_distribuidora where tipo = 'AA' or tipo ='Indie';

#Queremos saber cuantos numeros estan operativos y cuantos no lo estas(utilizamos group by)
select estado,count(telefono) from Telefono group by estado;

#Mostrar solo los pedidos realizados por las tiendas a las desarrolladoras antes del mes de marzo del 2020
select * from PedidoT where fecha < '2020-03-01';

#Evitamos mostrar los resultados de los titutos de videojuegos que han sido pedidos por las tiendas, evitando ver el juego repetido(usando select distinc)
select distinct nombre_game from VideojuegoPedidoT;

#Vemos los pedidos efectuados por clientes a las tiendas entre el dia  15 de junio y el 3 de julio
select * from PedidoC where fecha between '2020-06-15' and '2020-07-03' order by fecha;

#Buscamos a los clientes cuyo domicilio este en madrid, y los ordenamos al reves del orden alfabetico
select * from Cliente where domicilio like '%Madrid' order by nombre DESC;

#Como saber la media de precios por unidad de todos los videojuegos que se piden
select avg(precio_unidad) as media_precio from VideojuegoPedidoT;

#Saber el total de juegos pedidos a las desarroladoras
select sum(cantidad) as cantidad_de_juegos from VideojuegoPedidoT;

#Saber el total de juegos que han pedido los clientes a las tiendas
select sum(cantidad) from ArticulosPedido;

#Calcular la cantidad total gastada en pedidos a desarrolladoras por parte de la empresa de tiendas de videojuegos
select Round(sum(cantidad*precio_unidad),3) as total from VideojuegoPedidoT;

#Vemos las direcciones de las tiendas donde estan los diferentes juegos(asi vemos , si una tienda tiene un juego o no lo tiene, o a cuales ir para conseguir un determinado juego)
select * from Articulo_t natural join Tienda;

#Repetimos la query anterior pero en este caso, solo nos interesan las tiendas que estan en una ciudad determinada.
select * from Articulo_t natural join Tienda where Tienda.direccion like '%Madrid%';
select * from Articulo_t natural join Tienda where Tienda.direccion like '%Sevilla%';

#Queremos ver los datos de cada cliente que realizaron un pedido y en que fecha lo realizaron.
select * from Cliente natural join PedidoC;

#y si queremos ver el telefono de los clientes que han realizado un pedido y la fecha en la cual lo realizaron
select * from Cliente natural join PedidoC natural join Telefono ;

#Queremos ver el importe total que cuesta un pedido de una cantidad determinada de un juego(con un maximo de 3 decimales)
select  Round(cantidad * precio_unidad,3) as importe_total ,cantidad,precio_unidad,nombre_game from VideojuegoPedidoT;

