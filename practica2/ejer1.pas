program ejer1;
type
	empleado =record
		id:Integer;
		nombre: String;
		comision: integer;
	end;
	maestro = file of empleado;
var
 mae: maestro;
 det: Text;
 e_det: empleado;
 e_mae: empleado;
 nombre_archivo:String;
begin
	assign(det,'comisiones.txt');
	writeln('ingrese nombre del archivo');
	readln(nombre_archivo);
	assign(mae,nombre_archivo);
	rewrite(mae);
	reset(det);
	while (not EOF (det)) do begin
		writeln('entro al while');
		read(det, e_det.id, e_det.comision, e_det.nombre);
		writeln('entro al while');
		read(mae, e_mae);
	
		while(e_det.id <> e_mae.id) do 
			read(mae,e_mae);
		e_mae.comision := e_mae.comision + e_det.comision;
		seek(mae, filepos(mae)-1);
		write(mae, e_mae);
	end;
	close(det);
	close(mae);
	reset(mae);
	while(not EOF (mae)) do begin
		read (mae, e_mae);
		writeln('id: ', e_mae.id, ' nombre: ', e_mae.nombre, ' comision: ', e_mae.comision);
	end;
end.
	
		
	
