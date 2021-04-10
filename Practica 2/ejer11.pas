program ejer11;
const valor_alto = 'ZZZ';
type
	encuesta = record
		provincia: string[20];
		localidad: integer;
		alfabetizados: integer;
		encuestados: Integer; 
	end;
	provincia = record
		nombre: String; 
		alfabetizados: integer;
		encuestados: Integer; 
	end;
detalle = file of encuesta;
maestro = file of provincia;


procedure importarDetalle(numero:String);
var
    archivo: detalle;
    reg: encuesta;
    texto: Text;
begin
    assign(archivo, 'dataEj11/detalle'+numero+'.dat');
    rewrite(archivo);
    assign(texto, 'dataEj11/detalle'+numero+'.txt');
    reset(texto);
    while(not eof(texto)) do begin
        readln(texto, reg.provincia);
        readln(texto, reg.localidad, reg.alfabetizados, reg.encuestados);
        write(archivo, reg);
    end;
    close(archivo);
    close(texto);
    writeln('Archivo detalle importado correctamente!!');
    writeln();
end;

procedure importarMaestro();
var
    archivo: maestro;
    reg: provincia;
    texto: Text;
begin
    assign(archivo, 'dataEj11/maestro.dat');
    rewrite(archivo);
    assign(texto, 'dataEj11/maestro.txt');
    reset(texto);
    while(not eof(texto)) do begin
        readln(texto, reg.nombre);
        readln(texto, reg.alfabetizados, reg.encuestados);
        write(archivo, reg);
    end;
    close(archivo);
    close(texto);
    writeln('Archivo Maestro importado correctamente!!');
    writeln();
end;

procedure leer(	var archivo: detalle; var encuesta: encuesta);
begin
    if (not(EOF(archivo))) then 
       read (archivo, encuesta)
    else 
		    encuesta.provincia :=  valor_alto;
end;

procedure actualizarArchivoMaestro();
var
    mae: maestro;
    det: detalle;
    regm: provincia;
    regd: encuesta;
    aux: string;
 
    total_alfabetizados:integer;
    total_encuestados: integer;
   
begin
		assign(mae, 'dataEj11/maestro.dat');
		assign(det, 'dataEj11/detalle1.dat');
		reset(mae);
		reset(det);
		read(mae, regm);
		leer(det, regd);
		while (regd.provincia <> valor_alto) do begin
			aux := regd.provincia;
			total_alfabetizados:=0;
			total_encuestados:=0;
			while (aux = regd.provincia) do begin
				total_alfabetizados:=total_alfabetizados + regd.alfabetizados;
				total_encuestados:=total_encuestados + regd.encuestados;
				leer(det, regd);
			end;
			while(regm.nombre<>aux)do
				read(mae, regm);
			regm.encuestados:= total_encuestados;
			regm.alfabetizados:= total_alfabetizados;
			
			seek(mae, filePos(mae)-1);
			write(mae, regm);
			if(not eof(mae)) then begin
				read(mae, regm);
			end;
		end;
		close(det);
		close(mae);
end;



procedure mostrarDetalle(numero:string);
var
	archivo: detalle;
	reg: encuesta;
begin
	assign(archivo, 'dataEj11/detalle'+numero+'.dat');
    reset(archivo);
    while(not eof(archivo)) do begin
		read(archivo, reg);
		writeln('provincia: ' , reg.provincia );
	end;
	close(archivo);
end;

procedure mostrarMaestro();
var
	archivo: detalle;
	reg: encuesta;
begin
	assign(archivo, 'dataEj11/maestro.dat');
    reset(archivo);
    while(not eof(archivo)) do begin
		read(archivo, reg);
		writeln('provincia: ' ,reg.provincia );
		writeln('alfabetizados: ', reg.alfabetizados);
		writeln('Encuestados: ', reg.encuestados);
		
	end;
	close(archivo);
end;

var
 	reg: encuesta;
 	archivo: detalle;
   
begin
	importarDetalle('1');
	importarMaestro();
	mostrarDetalle('1');
	
	mostrarMaestro();
end.
