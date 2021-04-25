program ejer2;
const valor_alto = 9999;
type
	empleado = record
		codigo: integer;
		nombre: ShortString;
		dni: longInt;
	end;
	empleados = file of empleado; 

procedure crearAchivo( var archivo:empleados);
var
	e: empleado;
begin
	rewrite(archivo);
	writeln('ingrese el CODIGO del empleado: ');
	readln(	e.codigo);
	while (  e.codigo <> valor_alto) do begin
		writeln('ingrese el NOMBRE del empleado: ');
		readln(e.nombre);
		writeln('ingrese el DNI del empleado: ');
		readln(e.dni);
		write(archivo,e);
		writeln('ingrese el CODIGO del empleado: ');
		readln(	e.codigo);
	end;
	close(archivo);
end;
	
procedure leer(var archivo: empleados; var dato: empleado);
begin
	 if (not(EOF(archivo))) then 
       read (archivo, dato)
    else 
		    dato.codigo := valor_alto;
end;

procedure bajaLogica(var archivo:empleados);
var
	e:empleado;
begin
	reset(archivo);
	leer(archivo,e);
	while(e.codigo <> valor_alto) do begin
		if( e.dni < 8000000) then begin
			e.nombre:= '*' + e.nombre;
			seek(archivo, filepos(archivo)-1);
			write(archivo,e);
		end;
		leer(archivo,e);
	end;
	close(archivo);
end;

procedure imprimirArchivo( var archivo: empleados);
var
	e:empleado;
begin
	reset(archivo);
	leer(archivo,e);
	while(e.codigo <> valor_alto) do begin
		writeln('codigo: ' , e.codigo ,' nombre: ' , e.nombre , ' dni: ' , e.dni);
		leer(archivo,e);
	end;
	close(archivo);
end;

var
	arc_logico: empleados;
	arc_fisico: string [25];
begin
	writeln('ingrese nombre del archivo');
	readln(arc_fisico);
	assign(arc_logico,arc_fisico);
	crearAchivo(arc_logico);
	writeln('Lista Empleados');
	imprimirArchivo(arc_logico);
	bajaLogica(arc_logico);
	writeln('Baja Logica');
	imprimirArchivo(arc_logico);
end.
	
