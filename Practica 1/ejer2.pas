program ejer2;
type 
	archivo = file of integer;
var
	menores, cantidad, total, leido: integer;
	promedio: Real;
	arc_logico: archivo;
	arc_fisico: string [25];
begin
	menores:=0;
	cantidad:=0;
	total:=0;
	promedio:=0;
	writeln('ingrese nombre del archivo');
	readln(arc_fisico);
	assign(arc_logico,arc_fisico);
	reset(arc_logico);
	while(not eof(arc_logico)) do begin
		read(arc_logico, leido);
		writeln(leido);
		if(leido <1500) then 
			menores := menores +1;
		cantidad:= cantidad +1;
		total:=total +leido;
	end;
	close(arc_logico);
	promedio:= total / cantidad;
	writeln('la cantidad de numeros menores a 1500 es: ', menores);
	writeln('el promedio es: ', promedio); 
end.
		
		
	
	
	
