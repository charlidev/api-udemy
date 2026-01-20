create database CICLO_ESCOLAR;

use CICLO_ESCOLAR

create table carreras(
	idCarrera int identity primary key,
	descripcion varchar(100) not null
)

create table conceptos(
	idConcepto int identity primary key,
	descripcion varchar(100)
)

create table alumno(
	idAlumno int identity primary key,
	Nombre varchar(100),
	Apellido_Paterno varchar(100),
	Apellido_Materno varchar(100),
	Correo varchar(100),
	Direccion varchar(150),
	Telefono varchar(20),
	idCarrera int,
	fechaAlta date,
	foreign key (idCarrera) references carreras(idCarrera)
)

create table pagos(
	idPago int identity primary key,
	folio int,
	idAlumno int,
	idConcepto int,
	fechaPago date,
	importe int,
	foreign key (idAlumno) references alumno(idAlumno),
	foreign key (idConcepto) references conceptos(idConcepto)
)

--procedimientos almacenados
--insertar alumno
create procedure sp_InsertarAlumno
	@Nombre varchar(100),
	@ApellidoPaterno varchar(100),
	@ApellidoMaterno varchar(100),
	@Correo varchar(100),
	@Direccion varchar(100),
	@Telefono varchar(100),
	@idCarrera int
as
begin
	insert into alumno
	values(
		@Nombre,
		@ApellidoPaterno,
		@ApellidoMaterno,
		@Correo, @Direccion,
		@Telefono,
		@idCarrera,
		GETDATE()
	)
end

--eliminar alumnos si no tienen pagos
create procedure sp_EliminarAlumno
	@idAlumno int
as
begin
	if not exists(select 1 from pagos where idAlumno = @idAlumno)
	delete from alumno where idAlumno = @idAlumno
end

--insertar pago

create procedure sp_InsertarPago
	@idAlumno int,
	@idConcepto int,
	@importe decimal (10,2)
as
begin
	insert into pagos
	values(
		(select ISNULL(Max(folio),0)+1 from pagos),
		@idAlumno,
		@idConcepto,
		GETDATE(),
		@importe
	)
end