program ejer7;
type
	novela = record
		codigo:integer;
		precio:integer;
		genero:String;
		nombre:String;
	end;
	novelas= file of novela; 
var
	arc: novelas; 
	carga: text;
	nombreArchivo:String;
	ops:char;
	id: integer;

procedure crearArchivo(var origen:text; var destino:novelas);
var 
	nov: novela;
begin
	reset(origen);
	rewrite(destino);
	while(not eof(origen)) do begin
		readln(origen, nov.codigo, nov.precio, nov.genero);
		readln(origen, nov.nombre);
		write(destino, nov);
	end;
		close(origen);
		close(destino);
	writeln('Archivo cargado');
end;

procedure mostrarNovelas(var arch:novelas);
var
	nov:novela;
begin
	reset(arch);
	while(not eof(arch)) do begin
		read(arch, nov);
		writeln('Codigo: ', nov.codigo, ' Nombre: ',nov.nombre,' Genero: ', nov.genero,' Precio:', nov.precio);
	end;
	close(arch);
end;

procedure leerNovela(var n:novela);
begin
	write('Codigo: ');
	readln(n.codigo);
	write('Nombre: ');
	readln(n.nombre);
	write('Genero: ');
	readln(n.genero);
	write('Precio: ');
	readln(n.precio);
end; 

procedure agregarNovela(var arch:novelas);
var
	nov:novela;
begin
	leerNovela(nov);
	reset(arch);
	seek(arch, fileSize(arch));
	write(arch,nov);
	close(arch);
end;

procedure modificarNovela(var arch:novelas; var id:Integer);
var
	nov:novela;
begin
	reset(arch);
	while(not eof(arch)) do begin
		read(arch,nov);
		if(nov.codigo = id) then
			nov.precio := (nov.precio-100); 
	end;
	close(arch);
end;

begin
	write('igrese el nombre del archivo: ');
	read(nombreArchivo);
	assign(arc, nombreArchivo);
	assign(carga, 'novelas.txt');
	writeln('MENU');
	writeln ('a. Crear archivo de novelas');
	writeln ('b. Mostrar Novelas');
	writeln ('c. Agregar Novela'); 
	writeln ('d. Aplicar descuento a una novela');
	writeln ('s. SALIR');
	write('ingrese la opcion:  ');
	readln(ops); 
	
	while (ops <> 's') do begin; 
		case ops of
			'a': crearArchivo(carga,arc);
			'b': mostrarNovelas(arc); 
			'c': agregarNovela(arc);
			'd': begin
				write('ingrese la id buscada');
				readln(id);
				modificarNovela(arc,id);
				end;
		
		end;
		writeln('MENU');
		writeln ('a. Crear archivo de novelas');
		writeln ('b. Mostrar Novelas');
		writeln ('c. Agregar Novela'); 
		writeln ('d. Aplicar descuento a una novela');
		writeln ('s. SALIR');
		write('ingrese la opcion:  ');
		readln(ops); 
	end;
end.
