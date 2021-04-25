program ejer3;
const valor_alto = 9999;
type
	novela = record
		codigo: integer;
		genero: ShortString;
		nombre: ShortString;
		duracion: integer;
		director: ShortString;
		precio: integer;
		
	end;
	novelas = file of novela; 

procedure leer(var archivo: novelas; var dato: novela);
begin
	if (not(EOF(archivo))) then 
		read (archivo, dato)
    else 
		dato.codigo := valor_alto;
end;


procedure leerNovela(var n:novela);
begin
	writeln('ingrese el CODIGO de la novela: ');
	readln(	n.codigo);
	if (  n.codigo <> valor_alto) then begin;
		writeln('ingrese el GENERO de la novela: ');
		readln(	n.genero);
		writeln('ingrese el NOMBRE de la novela: ');
		readln(	n.nombre);
		writeln('ingrese el DURACION de la novela: ');
		readln(	n.duracion);
		writeln('ingrese el DIRECTOR de la novela: ');
		readln(	n.director);
		writeln('ingrese el PRECIO de la novela: ');
		readln(	n.precio);
	end;
end;
	
procedure crearAchivo( var archivo:novelas);
var
	n: novela;
	name: string;
begin
	writeln('Ingrese nombre del archivo');
    readln(name);
    assign (archivo, name+'.dat');
	rewrite(archivo);
	n.codigo:= 0;
	write(archivo,n);
	leerNovela(n);
	while ( n.codigo <> valor_alto) do begin
		write(archivo,n);
		leerNovela(n);
	end;
	close(archivo);
end;

procedure bajaNovela(var archivo: novelas);
var
	aux: novela;
	n: novela;
	buscado: integer;
	pos: integer;
	
begin
	writeln('Ingrese codigo de novela buscado');
    readln(buscado);
	reset(archivo);
	leer(archivo,aux);
	pos:= aux.codigo;
	leer(archivo,n);
	while(n.codigo <> valor_alto) do 
		leer(archivo,n);
	if(n.codigo = buscado) then begin
		seek(archivo, filepos(archivo)-1);
		aux:= n;
		aux.codigo := (filepos(archivo)*-1);
		n.codigo:= pos;
		write(archivo,n);
		seek(archivo,0);
		write(archivo,aux);
		writeln('se elimino la novela buscada');
	end
	else
		writeln('no se encontro la novela');
	close(archivo);
end;
		


procedure altaNovela(var archivo:novelas);
var
	aux: novela;
	n: novela;
begin
	reset(archivo);
	read (archivo, aux);
	if ( aux.codigo < 0 ) then begin
		aux.codigo:= aux.codigo*-1;
		writeln('Ingrese la nueva novela:');
		leerNovela(n);
		seek(archivo, aux.codigo);
		read (archivo, aux);
		seek(archivo, filepos(archivo)-1);
		write(archivo,n);
		seek(archivo, 0);
		write(archivo,aux);
	end
	else 
		writeln('No hay espacio en el acrhivo');

	close(archivo)
end;

	
procedure modificarNovela(var archivo:novelas);
var
   aux: integer;
	n: novela;
begin
    writeln('Ingrese codigo de novela a modificar');
    readln(aux);
    reset(archivo);
    leer (archivo,n);
    leer (archivo,n);
    while ((n.codigo <> valor_alto) and (n.codigo <> aux)) do 
       leer (archivo,n);
    if (n.codigo = aux) then begin
        leerNovela(n);
        seek(archivo, (filepos(archivo)-1));
        write(archivo,n);
        writeln('Se modifico la novela');
    end
    else
        writeln('no se encontro la novela');
    writeln();
    close(archivo);
end;		

procedure exportarATexto(var archivo:novelas);
var
    texto:text; 
    n:novela;
begin
    assign(texto, 'novelas.txt');
    rewrite(texto);
    reset(archivo);
    leer(archivo, n);
    leer(archivo, n);
    while (n.codigo <> valor_alto) do begin
        with n do 
            writeln(texto, 'Codigo de novela: ',n.codigo,' Genero: ', n.genero, ' Nombre: ', n.nombre, ' Duracion: ',n.duracion, ' Direccion: ', n.director, ' Precio: ',n.precio);
        leer(archivo,n);
    end;
    close(archivo);
    close(texto);
    writeln('se exporto el archivo');
    writeln();
end;
	
var
    archivo:novelas;
	opcion:char;
begin
    opcion:= 'h';
    while(opcion <> 's') do begin
		writeln('a - Crear Archivo de novelas');
		writeln('b - ingresar nueva novela');
		writeln('c - eliminar novela');
		writeln('d - exportar a texto');
		writeln('s - salir');
		readln(opcion);
		case opcion of
			'a' : crearAchivo(archivo);
			'b' : altaNovela(archivo);
			'c' : bajaNovela(archivo);
			'd' : exportarATexto(archivo);
		end; 
	end;
	writeln('Saliendo');
end.	
		
