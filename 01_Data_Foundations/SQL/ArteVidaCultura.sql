DROP DATABASE IF EXISTS ArteVidaCultural;
CREATE DATABASE ArteVidaCultural;
USE ArteVidaCultural;

/*
=============================================
||   1. CREACIÓN DE TABLAS  DE ENTIDADES   ||
=============================================
*/
CREATE TABLE ubicacion (
   CodUb varchar(4) primary key,
   Nombre varchar(40) not null,
   Direccion varchar(40) not null,
   Ciudad varchar(9) not null,
   Alquiler numeric(6,2) not null,
   Aforo int not null
);

CREATE TABLE caracteristicas (
   CodUb  varchar(4),
   Caracteristica   varchar(40) not null,
   PRIMARY KEY(CodUb, Caracteristica),
   FOREIGN KEY(CodUb) REFERENCES ubicacion(CodUb) ON DELETE CASCADE ON UPDATE CASCADE
 );
 
  CREATE TABLE artista (
   CodArt varchar(4) primary key,
   Nombre varchar(40) not null,
   Biografia text
);

 CREATE TABLE actividad (
   CodAct varchar(4) primary key,
   Nombre varchar(40) not null,
   Tipo varchar(40) not null
);

 CREATE TABLE genero (
   CodGenero varchar(4) primary key,
   NombreGenero varchar(40) not null
);

 CREATE TABLE actividadGenero (
   CodAct varchar(4),
   CodGenero varchar(4) not null,
   PRIMARY KEY(CodAct, CodGenero),
   FOREIGN KEY(CodAct) REFERENCES actividad(CodAct) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(CodGenero) REFERENCES genero(CodGenero) ON DELETE CASCADE ON UPDATE CASCADE
);

 CREATE TABLE asistente (
   CodAs varchar(4) primary key,
   Nombre varchar(40) not null,
   Email varchar(40) not null
);

 CREATE TABLE telefono (
   CodAs varchar(4),
   numTelefono varchar(9) not null check(numTelefono REGEXP '^[0-9]{9}$'), -- Ponemos numTelefono para distinguir ente tabla y atributo
   PRIMARY KEY(CodAs, numTelefono),
   FOREIGN KEY(CodAs) REFERENCES asistente(CodAs) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE evento (
   CodEv varchar(4) primary key,
   Nombre varchar(40) not null,
   Precio numeric(6,2) not null,
   Descripcion TEXT,
   Fecha date not null,
   Hora time not null,
   CodUb varchar(50),
   CodAct varchar(50),
   -- Añadiremos una restricción para que no haya dos eventos en el mismo sitio a la misma hora
   CONSTRAINT unicoEventoFechaHoraUbi UNIQUE (Fecha, Hora, CodUb),
   -- Marcamos las claves ajenas
   FOREIGN KEY(CodAct) REFERENCES actividad(CodAct) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(CodUb) REFERENCES ubicacion(CodUb) ON DELETE CASCADE ON UPDATE CASCADE
);

/*
=============================================
||   2. CREACIÓN DE TABLAS  DE RELACIONES  ||
=============================================
*/
 CREATE TABLE participa (
   CodArt varchar(4),
   CodAct varchar(4),
   -- A diferencia del documento teórico ponemos nCache ya que Cache es una palabra reservada del programa
   nCache numeric(9,2) not null, 
   PRIMARY KEY(CodArt, CodAct),
   FOREIGN KEY(CodArt) REFERENCES artista(CodArt) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(CodAct) REFERENCES actividad(CodAct) ON DELETE CASCADE ON UPDATE CASCADE
);
 CREATE TABLE asiste (
   CodAs varchar(4),
   CodEv varchar(4),
   Valoracion tinyint not null check(Valoracion between 0 and 5),
   PRIMARY KEY(CodAs, CodEv),
   FOREIGN KEY(CodAs) REFERENCES asistente(CodAs) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(CodEv) REFERENCES evento(CodEv) ON DELETE CASCADE ON UPDATE CASCADE
);

/*
=============================================
||          3. TRIGGERS Y VISTAS           ||
=============================================
*/

-- Comenzamos viendo el trigger para el control de aforo

DELIMITER //

CREATE TRIGGER controlAforo
BEFORE INSERT ON asiste
FOR EACH ROW
BEGIN
    DECLARE aforo_max INT;
    DECLARE asistentes_actuales INT;

    -- 1. Obtenemos el aforo máximo permitido para el evento
    SELECT u.Aforo INTO aforo_max
    FROM evento e INNER JOIN ubicacion u ON e.CodUb = u.CodUb
    WHERE e.CodEv = NEW.CodEv;

    -- 2. Contamos cuántos asistentes hay ya registrados en ese evento
    SELECT COUNT(*) INTO asistentes_actuales
    FROM asiste
    WHERE CodEv = NEW.CodEv;

    -- 3. Comparamos y lanzamos error si está lleno
    IF asistentes_actuales >= aforo_max THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El aforo para este evento ya está completo.';
    END IF;
END //

DELIMITER ;

-- Creamos otro trigger para controlar que un artista no esté en dos eventos el mismo día
DELIMITER //

CREATE TRIGGER tg_artista_disponibilidad_fecha
BEFORE INSERT ON participa
FOR EACH ROW
BEGIN
    DECLARE numEventos INT;
    SELECT COUNT(e.CodEv) INTO numEventos
    FROM evento e INNER JOIN participa p ON e.CodAct = p.CodAct
    WHERE p.CodArt = NEW.CodArt AND  e.Fecha IN ( SELECT Fecha 
												   FROM evento
                                                   WHERE  CodAct = NEW.CodAct);
	-- Si numEventos >= 1,  el artista ya participa en un evento en esa fecha
    IF numEventos >= 1 THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Este artista ya tiene programado otro evento 
        en la misma fecha.';
	END IF;
END //
DELIMITER ;

-- Creamos una vista que muestra cuánta gente se ha inscrito en cada evento 
-- en comparación con el aforo total y cuánto dinero se ha recaudado

CREATE VIEW vista_ocupacion_eventos AS
SELECT 
    e.Nombre AS Evento,
    e.Fecha,
    u.Nombre AS Lugar,
    u.Aforo AS Capacidad_Max,
    COUNT(asi.CodAs) AS Asistentes_Inscritos,
    (u.Aforo - COUNT(asi.CodAs)) AS Plazas_Libres,
    (COUNT(asi.CodAs) * e.Precio) AS Recaudacion_Total
FROM evento e
INNER JOIN ubicacion u ON e.CodUb = u.CodUb
LEFT JOIN asiste asi ON e.CodEv = asi.CodEv
GROUP BY e.CodEv;

-- Creamos una vista que permita ver de un solo vistazo qué artista 
-- tiene que ir a qué lugar, en qué fecha y qué actividad realizará.
CREATE VIEW vista_agenda_artistas AS
SELECT 
    a.Nombre AS Artista,
    act.Nombre AS Actividad,
    e.Fecha,
    e.Hora,
    u.Nombre AS Ubicacion,
    u.Ciudad,
    p.nCache AS Pago_Acordado
FROM artista a
INNER JOIN participa p ON a.CodArt = p.CodArt
INNER JOIN actividad act ON p.CodAct = act.CodAct
INNER JOIN evento e ON act.CodAct = e.CodAct
INNER JOIN ubicacion u ON e.CodUb = u.CodUb;
/*
=============================================
||       4. INSERCIÓN DE DATA SET          ||
=============================================
*/
-- Utilizamos la ayuda de la IA para conseguir datos correspondientes al problema

-- 1. UBICACIONES (3 registros)
INSERT INTO ubicacion VALUES 
('U001', 'Teatro Real Madrid', 'Plaza de Isabel II', 'Madrid', 850.00, 10), -- Aforo pequeño para probar trigger
('U002', 'Palau de la Música', 'C/ Palau de la Música', 'Barcelona', 600.00, 50),
('U003', 'Centro Cultural Las Cigarreras', 'Calle San Carlos', 'Alicante', 150.00, 100);

-- 2. CARACTERÍSTICAS
INSERT INTO caracteristicas VALUES 
('U001', 'Acústica Premium'), ('U001', 'Escenario Giratorio'),
('U002', 'Patrimonio Humanidad'), ('U003', 'Espacio Abierto');

-- 3. ARTISTAS (5 registros)
INSERT INTO artista VALUES 
('AR01', 'Elena Ferrante', 'Pianista clásica de renombre internacional.'),
('AR02', 'Marc Sanchis', 'Especialista en teatro de calle y performance.'),
('AR03', 'Sara Baras', 'Bailaora de flamenco contemporáneo.'),
('AR04', 'Dúo Armonía', 'Dúo de violonchelo y violín.'),
('AR05', 'Roberto Carlos', 'Pintor expresionista y muralista.');

-- 4. ACTIVIDADES (5 registros)
INSERT INTO actividad VALUES 
('AC01', 'Recital de Piano', 'Música Clásica'),
('AC02', 'Noche de Flamenco', 'Danza'),
('AC03', 'Taller de Expresión Corporal', 'Teatro'),
('AC04', 'Exposición Muralismo', 'Artes Plásticas'),
('AC05', 'Concierto de Cuerda', 'Música');

-- 5. GÉNEROS
INSERT INTO genero VALUES 
('G001', 'Clásico'), ('G002', 'Folklore'), ('G003', 'Experimental'), ('G004', 'Moderno');

-- 6. ACTIVIDAD-GÉNERO
INSERT INTO actividadGenero VALUES 
('AC01', 'G001'), ('AC02', 'G002'), ('AC03', 'G003'), ('AC04', 'G004'), ('AC05', 'G001');

-- 7. PARTICIPA (Artistas en Actividades)
INSERT INTO participa VALUES 
('AR01', 'AC01', 1500.00),
('AR03', 'AC02', 2000.00),
('AR02', 'AC03', 800.00),
('AR05', 'AC04', 500.00),
('AR04', 'AC05', 1200.00);

-- 8. EVENTOS (10 registros distribuidos)
INSERT INTO evento VALUES 
('E001', 'Gala de Invierno', 45.00, 'Evento inaugural', '2024-12-01', '20:00:00', 'U001', 'AC01'),
('E002', 'Pasión Flamenca', 30.00, 'Espectáculo de danza', '2024-12-05', '21:30:00', 'U002', 'AC02'),
('E003', 'Cuerdas en el Palau', 25.00, 'Concierto íntimo', '2024-12-10', '19:00:00', 'U002', 'AC05'),
('E004', 'Murales Vivos', 5.00, 'Exposición guiada', '2024-12-15', '10:00:00', 'U003', 'AC04'),
('E005', 'Mover el Alma', 15.00, 'Workshop intensivo', '2024-12-20', '17:00:00', 'U003', 'AC03'),
('E006', 'Piano bajo las estrellas', 50.00, 'Recital nocturno', '2024-12-22', '22:00:00', 'U001', 'AC01'),
('E007', 'Navidad Clásica', 35.00, 'Concierto festivo', '2024-12-25', '18:00:00', 'U001', 'AC05'),
('E008', 'Arte en la Calle', 0.00, 'Evento gratuito', '2025-01-05', '12:00:00', 'U003', 'AC04'),
('E009', 'Flamenco y Olé', 30.00, 'Segunda función', '2025-01-10', '21:30:00', 'U002', 'AC02'),
('E010', 'Despedida Elena', 60.00, 'Último concierto', '2025-01-15', '20:00:00', 'U001', 'AC01'),
('E011', 'Los Miserables', 80.00, 'Última actuación', '2027-01-15', '20:00:00', 'U001', 'AC01');

-- 9. ASISTENTES (20 registros)
INSERT INTO asistente VALUES 
('A001', 'Carlos Ruiz', 'carlos@mail.com'), ('A002', 'Ana Belén', 'ana@mail.com'),
('A003', 'Luis Miguel', 'luis@mail.com'), ('A004', 'Marta Sánchez', 'marta@mail.com'),
('A005', 'Jorge Sanz', 'jorge@mail.com'), ('A006', 'Lucía Gil', 'lucia@mail.com'),
('A007', 'Pedro Marín', 'pedro@mail.com'), ('A008', 'Elena Poe', 'elena@mail.com'),
('A009', 'Raúl Giner', 'raul@mail.com'), ('A010', 'Sofía Loren', 'sofia@mail.com'),
('A011', 'Marcos Paz', 'marcos@mail.com'), ('A012', 'Julia Otero', 'julia@mail.com'),
('A013', 'Iván Ferreiro', 'ivan@mail.com'), ('A014', 'Nerea Ruiz', 'nerea@mail.com'),
('A015', 'Óscar Casas', 'oscar@mail.com'), ('A016', 'Paula Eche', 'paula@mail.com'),
('A017', 'Quique Gon', 'quique@mail.com'), ('A018', 'Rocío Jurado', 'rocio@mail.com'),
('A019', 'Sergio Dalma', 'sergio@mail.com'), ('A020', 'Tania Llasera', 'tania@mail.com');

-- 10. TELÉFONOS (9 dígitos check)
INSERT INTO telefono VALUES 
('A001', '600111222'), ('A002', '611222333'), ('A003', '622333444'), ('A004', '633444555'),
('A005', '600111222'), ('A006', '655666777'), ('A007', '666777888'), ('A008', '677888999'),
('A009', '688999000'), ('A010', '699000111'), ('A011', '601000111'), ('A012', '602000222'),
('A013', '603000333'), ('A014', '604000444'), ('A015', '605000555'), ('A016', '606000666'),
('A017', '607000777'), ('A018', '608000888'), ('A019', '609000999'), ('A020', '610111222');

-- 11. ASISTENCIA (Llenamos algunos eventos)
-- Vamos a llenar el evento E001 (Aforo 10 en U001) para probar el trigger
INSERT INTO asiste VALUES 
('A001', 'E001', 5), ('A002', 'E001', 4), ('A003', 'E001', 5), ('A004', 'E001', 3), ('A005', 'E001', 5),
('A006', 'E001', 4), ('A007', 'E001', 2), ('A008', 'E001', 5), ('A009', 'E001', 4), ('A010', 'E001', 5);

-- Otros eventos con menos gente
INSERT INTO asiste VALUES 
('A011', 'E002', 5), ('A012', 'E002', 4), ('A013', 'E003', 3), ('A014', 'E004', 5),
('A015', 'E005', 4), ('A016', 'E006', 5), ('A017', 'E007', 4), ('A018', 'E008', 3);

/*
=============================================
||              5. CONSULTAS               ||
=============================================
*/

-- 1. Comenzamos probando las vistas para ver su correcto funcionamiento
select * from vista_agenda_artistas;
select * from vista_ocupacion_eventos;

-- 2.  Probamos el funcionamiento del trigger de aforo: Para ello, 
-- intentamos añadir un nuevo asistente a un evento completo (Nos da error)
INSERT INTO asiste VALUES ('A011', 'E001', 5); 

-- A continuación, probamos el trigger que comprueba que un artista no puede tener 
-- dos eventos el mismo día. Para ello, tomamos al artista Elena Ferrante (AR01),
-- con actividad AC01 (Recital de Piano) vinculada a tres eventos.
-- Creamos una actividad nueva
INSERT INTO actividad VALUES ('AC06', 'Charla Magistral', 'Educativa');

-- Creamos un evento para esa actividad el mismo día que el Evento E001 (2024-12-01)
INSERT INTO evento VALUES 
('E012', 'Masterclass Piano', 10.00, 'Charla técnica', '2024-12-01', '10:00:00', 'U003', 'AC06');

-- Esto falla:
INSERT INTO participa VALUES ('AR01', 'AC06', 300.00);

-- 3. Finalmente, empezamos las consultas solicitadas en el ejercicio:

-- Número de eventos en los que se realiza cada actividad
select e.codAct, ac.Nombre as 'Nombre de la actividad' ,  count(e.codAct) as  'Número de eventos'
from evento e inner join actividad ac on e.CodAct = ac.CodAct
group by e.CodAct ;

-- Listado de las calificaciones de los eventos según las  valoraciones  de los asistentes
select e.CodEv, e.Nombre as 'Nombre del evento', count(asi.CodAs) as 'Número de asistentes',
u.Nombre as 'Lugar', round(avg(asi.Valoracion),2) as 'Valoracion Media',
case
	when avg(asi.Valoracion) >= 4.5 then 'Excelente'
    when avg(asi.Valoracion) >= 3 then 'Buena'
    when avg(asi.Valoracion) >= 2 then 'Regular'
    else 'Mala'
end as 'Clasificación'
from evento e inner join asiste asi on e.CodEv = asi.CodEv
			  inner join ubicacion u on u.CodUb = e.CodUb
group by e.CodEv
order by avg(asi.Valoracion) desc, count(asi.CodAs) desc ;

-- Número de personas que acuden a cada tipo de actividad
select a.Tipo, count(asiste.CodAs) as 'Número total de asistentes a la actividad'
from evento e inner join actividad a on e.CodAct = a.CodAct
			  inner join asiste on asiste.CodEv = e.CodEv
group by a.Tipo;

-- Top 3 artistas más rentables
select a.Nombre as Artista, COUNT(e.CodEv) as 'Númmero Eventos', SUM(p.nCache) as 'Coste Total Caché',
       SUM(e.Precio * sub.Total_Asistentes) as 'Recaudación Generada',
       (SUM(e.Precio * sub.Total_Asistentes) - SUM(p.nCache)) as Beneficio_Neto
from artista a inner join participa p on a.CodArt = p.CodArt
			   inner join evento e on p.CodAct = e.CodAct
inner join (
    -- Subconsulta para contar asistentes por evento
    select CodEv, COUNT(*) AS Total_Asistentes
    from asiste 
    group by CodEv
) sub on e.CodEv = sub.CodEv
group by a.CodArt
order by Beneficio_Neto desc
limit 3; -- Si queremos ver el balance de los otros  artistas basta con eliminarr esta condición

-- Ubicaciones con peor funcionamiento: Consideraremos un mal funcionamiento cuando tengamos una ocupación con menos del 50%
select u.Nombre as Ubicacion, u.Ciudad, u.Aforo as 'Capacidad Max', round(avg(asistencias.Total), 2) as 'Promedio Asistentes',
    round((avg(asistencias.Total) / u.Aforo) * 100, 2) as 'Porcentaje Ocupacion Media'
from ubicacion u inner join evento e on u.CodUb = e.CodUb
inner join (
    -- Contamos asistentes por cada evento en esa ubicación
    select CodEv, count(CodAs) as 'Total' 
    from asiste 
    group by CodEv
) asistencias on e.CodEv = asistencias.CodEv
group by u.CodUb
having 'Porcentaje Ocupacion Media' < 50
order by 'Porcentaje Ocupacion Media';

-- Consulta el último evento visitado de cada usuario
select a.Nombre, max(e.Fecha) as UltimoEvento
from asistente a inner join asiste asi on a.CodAs = asi.CodAs
				 inner join evento e on asi.CodEv = e.CodEv
group by a.Nombre
order by a.Nombre;


-- Consulta acerca de los usuarios que más han asistido a eventos, la valoración media de cada usuario y el último evento visitado
select asi.Nombre, asi.Email, count(ast.CodEv) as Eventos_Visitados,
    round(avg(ast.Valoracion), 1) as Valoracion_Media_Asistente,
    (--  Hacemos una subconsulta para conectar el nombre del asistente con el último evento al que ha acudido
        select e.Nombre 
        from asiste a2 inner join evento e on a2.CodEv = e.CodEv
        where a2.CodAs = asi.CodAs 
        order by e.Fecha desc, e.Hora desc
        limit 1
    ) AS Ultimo_Evento_Visto
from asistente asi inner join asiste ast on asi.CodAs = ast.CodAs
group by asi.CodAs, asi.Nombre, asi.Email
having Eventos_Visitados >= 1
order by Eventos_Visitados DESC;

-- Consulta para ver qué personas comparten teléfono
select asistente.CodAs, asistente.Nombre, t.numTelefono
from asistente inner join telefono t on asistente.CodAs = t.CodAs
where t.numTelefono in (select numTelefono from telefono
						group by numTelefono having count(numTelefono) > 1);
                         
-- Tiempo que falta para cada evento no celebrado
select e.CodEv, e.Nombre, e.Fecha, abs(timestampdiff(day, e.Fecha, curdate())) 'Días Restantes'
from evento e
where e.Fecha >= curdate()
order by e.Fecha;

-- Buscador de ubicaciones disponibles para undía solicitado: En  este caso, tomaremos como ejemplo '2024-12-01'
select u.Nombre as 'Ubicación Disponible', u.Ciudad, u.Aforo
from ubicacion u
where u.CodUb not in (
    -- Subconsulta que busca ubicaciones ocupadas en una fecha
    select CodUb 
    from evento 
    where Fecha = '2024-12-01'
);

-- Mapa de Popularidad por Género
select g.NombreGenero, count(ast.CodAs) as 'Total Asistentes', round(avg(ast.Valoracion), 2) as 'Valoracion Media'
from genero g inner join actividadGenero ag on g.CodGenero = ag.CodGenero
  			  inner join evento e on ag.CodAct = e.CodAct
			  left join asiste ast on e.CodEv = ast.CodEv
group by g.CodGenero
order by 'Total Asistentes' DESC;

-- Utilizamos la vista para consultar el total recaudado por cada evento
select Evento, Recaudacion_Total as 'Recaudación Total por evento'
from vista_ocupacion_eventos;

-- Por último, queremos saber cuál ha sido la recaudación total de todos los eventos
-- organizados por la empresa
select sum(Recaudacion_Total) as 'Recaudación Total'
from vista_ocupacion_eventos;
