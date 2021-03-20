program ejer3;
type
	empleado = record
		id:Integer;
		apellido:String [20];
		nombre:String [20];
		edad: Integer;
		dni: Integer;
	end; 
	archivo= file of empleado;
var
	
	ops: char;
	arc_logico: archivo;
	arc_fisico: string [25];
	buscado: string[20];
	


procedure crearAchivo( var arc_logico:archivo);
var
	e: empleado;
begin
	rewrite(arc_logico);
	writeln('ingrese el APELLIDO del empleado: ');
	readln(	e.apellido);
	while (  e.apellido <> 'fin') do begin
		writeln('ingrese el NOMBRE del empleado: ');
		readln(e.nombre);
		writeln('ingrese el EDAD del empleado: ');
		readln(e.edad );
		writeln('ingrese el DNI del empleado: ');
		readln(e.dni);
		writeln('ingrese el ID  del empleado: ');
		readln(e.id);
		write(arc_logico,e);
		writeln('ingrese el APELLIDO del empleado: ');
		readln(	e.apellido);
	end;
	close(arc_logico);
end;

procedure buscarEmpleado(var arc_logico:archivo; buscado:String);
var
	e:empleado;
begin
	reset(arc_logico);
	while (not eof (arc_logico)) do begin
		read(arc_logico, e);
		if ((e.nombre = buscado) or (e.apellido = buscado)) then begin
			write('ID: ', e.id);
			write(', Nombre: ', e.nombre);
			write(', Apellido: ', e.apellido);
			write(', Edad: ', e.edad);
			writeln(', DNI: ', e.dni);
		end; 
	end;
	close(arc_logico);
end;

procedure mostrarEmpleados(var arc_logico:archivo);
var
	e:empleado;
begin
	reset(arc_logico);
	while (not eof (arc_logico)) do begin
		read(arc_logico,e);
		write('ID: ', e.id);
		write(', Nombre: ', e.nombre);
		write(', Apellido: ', e.apellido);
		write(', Edad: ', e.edad);
		writeln(', DNI: ', e.dni);
	end;
	close(arc_logico);
end; 

procedure mostrarJubilados(var arc_logico:archivo);
var
	e:empleado;
begin
	reset(arc_logico);
	while (not eof (arc_logico)) do begin
		read(arc_logico,e);
		if( e.edad > 70) then begin
			write('ID: ', e.id);
			write(', Nombre: ', e.nombre);
			write(', Apellido: ', e.apellido);
			write(', Edad: ', e.edad);
			writeln(', DNI: ', e.dni);
		end;
	end;
	close(arc_logico);
end; 
			
begin
	writeln('Ingrese el nombre del archivo a crear o leer: ');
	readln(arc_fisico);
	assign(arc_logico,arc_fisico);
	writeln('MENU');
	writeln ('a. crear archivo de empleados');
	writeln ('b. abrir archivo de empleados');
	writeln ('c. SALIR');
	write('ingrese la opcion:  ');
	readln(ops); 
	while (ops <> 'c') do begin; 
		case ops of
			'a': crearAchivo(arc_logico);
			'b': begin
					writeln('	1. Buscar empleado');
					writeln('	2. Listar empleados');
					writeln('	3. Empleados proximos a jubilarse');
					writeln('	4. volver al menu anterior');
					write('	ingrese la opcion:  ');
					readln(ops); 
					writeln();
					case ops of
						'1': begin
								write('Ingrese el nombre o apellido buscado: ');
								readln(buscado);
								buscarEmpleado(arc_logico,buscado);
							end;
						'2': mostrarEmpleados(arc_logico);
						'3': mostrarJubilados(arc_logico);
					end;
			end;
		end;
		writeln (' ');
		writeln ('a. crear archivo de empleados');
		writeln ('b. abrir archivo de empleados');
		writeln ('c. SALIR');
		write('ingrese la opcion:  ');
		readln(ops); 
	end;
		
end.
	

		
