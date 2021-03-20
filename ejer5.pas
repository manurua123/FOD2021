program ejer5;
type
	celular = record
		codigo: Longint; 
		nombre: string;
		descripcion: string;
		marca: string;
		precio: Longint;
		stockMin: Longint;
		stock: Longint;
	end;
	arcCelulares= file of celular; 
var
	celulares: arcCelulares; 
	carga: text;
	nombreArchivo:String;
	ops:char;
	buscado: string;
 
procedure cargarArchivo(var origen:text; var destino:arcCelulares);
var 
	cel: celular;
begin
	reset(origen);
	rewrite(destino);
	while(not eof(origen)) do begin
		readln(origen, cel.codigo, cel.precio, cel.marca, cel.nombre);
		readln(origen, cel.stockMin, cel.stock, cel.descripcion);
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
		if(cel.stock <cel.stockMin) then
			writeln('Nombre: ', cel.nombre,' Marca: ',cel.marca,' Precio: ', cel.precio,' Stock: ', cel.stock);
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
			writeln('Nombre: ', cel.nombre,' Marca: ',cel.marca,' Precio: ', cel.precio,' Stock: ', cel.stock);
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
	writeln ('d. exportar celulares'); 
	writeln ('e. SALIR');
	write('ingrese la opcion:  ');
	readln(ops); 
	while (ops <> 'e') do begin; 
		case ops of
			'a': cargarArchivo(carga,celulares);
			'b': mostrarCelularesPocoStock(celulares); 
			'c': begin
				write('ingrese la descripcion buscada');
				readln(buscado);
				buscarDescr(celulares,buscado);
				end;
		end;
		writeln ('a. Crear archivo de celulares');
		writeln ('b. Mostrar celulares faltos de stock');
		writeln ('c. Buscar descripcion'); 
		writeln ('d. exportar celulares'); 
		writeln ('e. SALIR');
		write('ingrese la opcion:  ');
		readln(ops); 
	end;
end.
	
		
		
