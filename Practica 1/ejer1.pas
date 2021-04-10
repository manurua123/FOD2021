program ejer1;
type 
	archivo = file of integer;
var
	arc_logico: archivo;
	nro: integer;
	arc_fisico: string [25];
begin
	writeln('ingrese el nombre del archivo: ');
	read(arc_fisico);
	assign(arc_logico,arc_fisico);
	rewrite(arc_logico);
	writeln('archivo creado');
	writeln('ingrese el nombre del archivo: ');
	read(nro);
	while nro <> 30000 do begin
		write(arc_logico,nro);
		writeln('ingrese el nombre del archivo: ');
		read(nro);
	end;
	close(arc_logico);
end.
