program ejer5;
type
	celular = record
		codigo: Longint; 
		marcaModelo: string;
		descripcion: string;
		precio: Longint;
		stockMin: Longint;
		stock: Longint;
	end;
	arcCelulares= file of celular; 
var
	celulares: arcCelulares; 
	carga: text;
	destino:text; 
	nombreArchivo:String;
	ops:char;
	buscado: string;
	id: integer;
	stock:integer;
	
 
procedure cargarArchivo(var origen:text; var destino:arcCelulares);
var 
	cel: celular;
begin
	reset(origen);
	rewrite(destino);
	while(not eof(origen)) do begin
		readln(origen, cel.codigo, cel.precio, cel.marcaModelo);
		readln(origen, cel.stock, cel.stockMin, cel.descripcion);
		write(destino, cel);
	end;
		close(origen);
		close(destino);
	writeln('Archivo cargado');
end;

procedure mostrarCelularesPocoStock(var arch:arcCelulares);
var
	cel: celular;
begin
	reset(arch);
	while(not eof(arch)) do begin
		read(arch, cel);
		if(cel.stock < cel.stockMin) then
			writeln('Marca y Modelo: ', cel.marcaModelo,' Precio: ', cel.precio,' Stock: ', cel.stock);
	end;
	close(arch);
end;

procedure buscarDescr(var arch:arcCelulares; buscado:string);
var 
	cel:celular;
begin
	reset(arch);
	while(not eof(arch)) do begin
		read(arch, cel);
		if(cel.descripcion = buscado) then
			writeln('Marca y Modelo: ', cel.marcaModelo,' Precio: ', cel.precio,' Stock: ', cel.stock);
	end;
	close(arch);
end;

procedure leerCelular( var c:celular);
begin
	write('ingrese el CODIGO del equipo');
	readln(c.codigo);
	if(c.codigo<>0) then begin
		write('ingrese el Marca y Modelo del equipo');
		readln(c.marcaModelo);
		write('ingrese el DESCRIPCION del equipo');
		readln(c.descripcion);
		write('ingrese el PRECIO del equipo');
		readln(c.precio);
		write('ingrese el STOCK MINIMO del equipo');
		readln(c.stockMin);
		write('ingrese el STOCK ACTUAL del equipo');
		readln(c.stock);
		
	end; 
end;
		
procedure agregarCelular(var arch:arcCelulares);
var
	cel: celular;
begin
	leerCelular(cel);
	reset(arch);
	while (cel.codigo <> 0) do begin
		seek(arch, fileSize(arch));
		write(arch,cel);
		leerCelular(cel);
	end;
	close(arch);
end;
		
procedure modificarStock(var arch:arcCelulares; stock: integer; id: integer);
var
	cel: celular;
begin
	reset(arch);
	while(not eof(arch)) do begin
		read(arch, cel);
		if(cel.codigo = id) then
			cel.stock:= stock;
	end;
	close(arch);
end;

procedure exportarSinStock(var arch:arcCelulares; var destino: text);
var
	cel: celular;
begin
	reset(arch);
	assign(destino, 'SinStock.txt');
	rewrite(destino);
	while(not eof (arch)) do begin
		read(arch, cel);
		if(cel.stock = 0) then begin
			writeLn(destino, cel.codigo,' ',cel.precio,' ',cel.marcaModelo);
			writeLn(destino, cel.stock,' ',cel.stockMin,' ',cel.descripcion);
		end;
	end;	
	close(destino);
	close(arch);
end;

procedure mostrarTodos(var arch:arcCelulares);
var
	cel:celular;
begin
	reset (arch);
	while(not eof (arch)) do begin
		read(arch,cel);
		writeln('Marca y Modelo: ', cel.marcaModelo,' Precio: ', cel.precio,' Stock: ', cel.stock,' Stock Minimo: ', cel.stockMin);
	end;
	close(arch);
end;

begin
	write('Ingrese nombre del archivo:  ');
	readln(nombreArchivo);
	assign(celulares, nombreArchivo);
	assign(carga, 'celulares.txt');
	writeln('MENU');
	writeln ('a. Crear archivo de celulares');
	writeln ('b. Mostrar celulares faltos de stock');
	writeln ('c. Buscar descripcion'); 
	writeln ('d. Exportar Celulares sin stock'); 
	writeln ('e. Anadir celulares'); 
	writeln ('f. Modificar Stock'); 
	writeln ('m. mostrar todos los equipos');
	writeln ('s. SALIR');
	write('ingrese la opcion:  ');
	readln(ops); 
	while (ops <> 's') do begin; 
		case ops of
			'a': cargarArchivo(carga,celulares);
			'b': mostrarCelularesPocoStock(celulares); 
			'c': begin
				write('ingrese la descripcion buscada');
				readln(buscado);
				buscarDescr(celulares,buscado);
				end;
			'd': exportarSinStock(celulares,destino);
			'e': agregarCelular(celulares);
			'f': begin
				write('ingrese la ID buscada y el stock actual');
				readln(id,stock);
				modificarStock(celulares,stock,id);
				end;
			'm': mostrarTodos(celulares);
		end;
		writeln('MENU');
		writeln ('a. Crear archivo de celulares');
		writeln ('b. Mostrar celulares faltos de stock');
		writeln ('c. Buscar descripcion'); 
		writeln ('d. Exportar Celulares sin stock'); 
		writeln ('e. Anadir celulares'); 
		writeln ('f. Modificar Stock'); 
		writeln ('m.mostrar todos los equipos');
		writeln ('s. SALIR');
		write('ingrese la opcion:  ');
		readln(ops); 
	end;
end.
