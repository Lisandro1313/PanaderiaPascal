program Panaderia;

const
  MAX_CATEGORIAS = 26;
  MAX_COMPRAS = 100;

type
  Categoria = record
    nombre: string;
    codigo: integer;
    precioPorKilo: real;
  end;

  Compra = record
    dniCliente: string;
    categoria: integer;
    cantidadKilos: real;
  end;

var
  categorias: array[1..MAX_CATEGORIAS] of Categoria;
  compras: array[1..MAX_COMPRAS] of Compra;
  cantidadCompras: integer;

// Función para leer la información de las categorías
procedure LeerCategorias();
var
  i: integer;
begin
  for i := 1 to MAX_CATEGORIAS do
  begin
    writeln('Ingrese el nombre de la categoría ', i, ':');
    readln(categorias[i].nombre);
    writeln('Ingrese el código de la categoría ', i, ':');
    readln(categorias[i].codigo);
    writeln('Ingrese el precio por kilo de la categoría ', i, ':');
    readln(categorias[i].precioPorKilo);
  end;
end;

// Función para leer la información de las compras
procedure LeerCompras();
begin
  cantidadCompras := 0;
  repeat
    cantidadCompras := cantidadCompras + 1;
    writeln('Ingrese el DNI del cliente:');
    readln(compras[cantidadCompras].dniCliente);
    writeln('Ingrese el código de la categoría:');
    readln(compras[cantidadCompras].categoria);
    writeln('Ingrese la cantidad de kilos comprados:');
    readln(compras[cantidadCompras].cantidadKilos);
  until compras[cantidadCompras].dniCliente = '0'; // Termina la lectura con '0'
  cantidadCompras := cantidadCompras - 1; // Resta 1 para no considerar el último '0'
end;

// Función para encontrar el DNI del cliente que más compras ha realizado
function DniClienteMasCompras(): string;
var
  i: integer;
  dniMasCompras: string;
  maxCompras: integer;
  contadorCompras: array[1..MAX_COMPRAS] of integer;
begin
  // Inicializar contador de compras
  for i := 1 to MAX_COMPRAS do
    contadorCompras[i] := 0;

  // Contar las compras por cliente
  for i := 1 to cantidadCompras do
    contadorCompras[StrToInt(compras[i].dniCliente)] := contadorCompras[StrToInt(compras[i].dniCliente)] + 1;

  // Encontrar el máximo
  maxCompras := 0;
  for i := 1 to MAX_COMPRAS do
  begin
    if contadorCompras[i] > maxCompras then
    begin
      maxCompras := contadorCompras[i];
      dniMasCompras := IntToStr(i);
    end;
  end;

  DniClienteMasCompras := dniMasCompras;
end;

// Función para calcular el monto total recaudado por cada categoría
procedure MontoTotalRecaudado(var montoPorCategoria: array of real);
var
  i: integer;
begin
  // Inicializar montos por categoría
  for i := 1 to MAX_CATEGORIAS do
    montoPorCategoria[i] := 0;

  // Calcular los montos por categoría
  for i := 1 to cantidadCompras do
  begin
    montoPorCategoria[compras[i].categoria] := montoPorCategoria[compras[i].categoria] +
      (compras[i].cantidadKilos * categorias[compras[i].categoria].precioPorKilo);
  end;
end;

var
  montoPorCategoria: array[1..MAX_CATEGORIAS] of real;
  dniMasCompras: string;
  i: integer;
begin
  LeerCategorias();
  LeerCompras();

  dniMasCompras := DniClienteMasCompras();
  writeln('DNI del cliente que más compras ha realizado: ', dniMasCompras);

  MontoTotalRecaudado(montoPorCategoria);
  writeln('Monto total recaudado por cada categoría:');
  for i := 1 to MAX_CATEGORIAS do
    writeln('Categoría ', i, ': ', montoPorCategoria[i]:0:2);

  readln;
end.
