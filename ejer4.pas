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
	id_buscado: integer;
	edad: integer; 
	archivo_destino: text; 


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
	
	
procedure agregarEmpleados(	var arc_logico:archivo);
var
	e:empleado;
begin	
	reset(arc_logico);
	
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
		seek(arc_logico, fileSize(arc_logico));
		write(arc_logico,e);
		writeln('ingrese el APELLIDO del empleado: ');
		readln(	e.apellido);
	end;
	close(arc_logico);
end;

procedure modificarEdad (var arc_logico:archivo; id:integer; edad: integer);
var 
	e: empleado; 
begin
	reset(arc_logico);
	while (not eof (arc_logico)) do begin
		read(arc_logico, e);
		if (e.id = id) then begin
			e.edad:=edad;
			seek(arc_logico, filePos(arc_logico)-1);
			write(arc_logico,e);
			writeln('edad modificada con exito');
			 
		end; 
	end;
	close(arc_logico);
end;

procedure exportarTodos(var arc_logico:archivo; var arc_texto:text);
var 
	e: empleado;
begin
	reset(arc_logico);
	assign(arc_texto, 'todo_empleados.txt');
	rewrite(arc_texto);
	while(not eof (arc_logico)) do begin
		read(arc_logico, e);
		writeLn(arc_texto, e.id,' ',e.apellido,' ',e.nombre,' ', e.edad, ' ', e.dni); 
	end;
	close (arc_logico);
	close (arc_texto); 
end; 

procedure exportarTodosDNI(var arc_logico:archivo; var arc_texto:text);
var 
	e: empleado;
begin
	reset(arc_logico);
	assign(arc_texto, 'todo_empleados.txt');
	Rewrite(arc_texto);
	while(not eof (arc_logico)) do begin
		read(arc_logico, e);
		if(e.dni <> 000) then begin
			write(arc_texto, e.id);
			write(arc_texto, e.nombre);
			write(arc_texto, e.apellido);
			write(arc_texto, e.edad);
			writeln(arc_texto, e.dni);
		end; 
	end;
	close (arc_logico);
	close (arc_texto); 
end; 

	
			
begin
	writeln('Ingrese el nombre del archivo a crear o leer: ');
	readln(arc_fisico);
	assign(arc_logico,arc_fisico);
	writeln('MENU');
	writeln ('a. crear archivo de empleados');
	writeln ('b. abrir archivo de empleados');
	writeln ('c. editar archivo de empleados'); 
	writeln ('d. exportar archivo de empleados'); 
	writeln ('e. SALIR');
	write('ingrese la opcion:  ');
	readln(ops); 
	while (ops <> 'e') do begin; 
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
			'c':begin
					writeln('	4. Agregar empleados');
					writeln('	5. modificar edad empleados');
					write('	ingrese la opcion:  ');
					readln(ops); 
					case ops of
						'4': agregarEmpleados(arc_logico);
						'5': begin
							write('Ingrese el ID buscado: ');
							readln(id_buscado);
							write('Ingrese la nueva Edad: ');
							readln(edad);
							modificarEdad(arc_logico,id_buscado,edad );
							end; 
					end;
			end;
			'd': begin
					writeln('	6. exportar a "todo_empleados.txt"');
					writeln('	7. exportar a "faltaDNIEmpleado.txt"');
					write('	ingrese la opcion:  ');
					readln(ops); 
					case ops of
						'6':exportarTodos(arc_logico, archivo_destino);
						'7':exportarTodosDNI (arc_logico, archivo_destino);
					end;
			end;
			 
		end;
		writeln (' ');
		writeln ('a. crear archivo de empleados');
		writeln ('b. abrir archivo de empleados');
		writeln ('c. editar archivo de empleados'); 
		writeln ('d. exportar archivo de empleados'); 
		writeln ('e. SALIR');
		write('ingrese la opcion:  ');
		readln(ops); 
	end;
		
end.
